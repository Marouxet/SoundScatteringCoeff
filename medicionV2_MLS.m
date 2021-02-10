function  [tiempos] = medicionV2_MLS(pointer,handles)

%Creo el Canal de grabación, de reproducción y de escritura
Record = createRecordV2(pointer);
Player = createPlayerV2(pointer);
Writer = createWriterV2(pointer);
Reader = createReaderV2();

load('app_data/orden.mat','nmedicion');
load('app_data/orden.mat','logico_ordenado');

i = 1;
pos_actual = find(nmedicion{i}==pointer,1);
while(isempty(pos_actual))
i = i+1;
pos_actual = find(nmedicion{i}==pointer,1);
end
fila_orden_actual = i;
mics_actual = logico_ordenado(fila_orden_actual,3);



load('app_data/settings.mat','BufferSize')
load('app_data/settings.mat','QueueDuration')
load('app_data/settings.mat','SampleRate');
load('app_data/settings.mat','sec_factor');
load('app_data/settings.mat','c_mics_simultaneo');
load('app_data/settings.mat','objectName');
load('app_data/current.mat','monitoreo');
load('app_data/settings.mat','SamplesPerFrame');
%load('app_data/current.mat','xlimites');
load('app_data/current.mat','angle_mls');

% trefresh = 1; %tiempo de actualizacion de la pantalla al graficar;
% trefresh_s = ceil(trefresh * SampleRate / SamplesPerFrame) * SamplesPerFrame;
% frame_plot = trefresh_s /SamplesPerFrame;
% int_plot = 4;
% b_d_ip = SamplesPerFrame/int_plot;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%flag_rec =handles.flag_rec;
global flag_rec

memory = zeros(Record.BufferSize,length(Record.ChannelMapping));
silencio = zeros(Record.BufferSize,1);
latency = (QueueDuration * SampleRate + 2 * BufferSize)/SampleRate;


if logico_ordenado(pointer,4) == 1;
    a = 1;
else
    a = 0;
end

while  flag_rec ==1 
    if a == 1;
   ET250_3D('set',angle_mls);
    end
    a = 0;
    if ~isDone(Reader)
        
        if monitoreo ==0
        play = [step(Reader) silencio];
        else
        play =[step(Reader) memory(:,monitoreo)];
        end
        
        step(Player, play);
        memory = step(Record);
        
            if a == 1;
           ET250_3D('set',angle_mls);
            a = 0;
            end
            
         for i = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{i};
            step(Writer.(name), memory(:,i));
         end
 

         switch c_mics_simultaneo 
             case 1
                     step(handles.hts,memory(:,1))
             case 2
                     step(handles.hts,memory(:,1), memory(:,2))
             case 3
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3))
             case 4
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3), memory(:,4))
         end
         
    else
        fin_grabacion = tic;
        while toc(fin_grabacion)<latency + sec_factor
        
             if monitoreo ==0
               Player.QueueDuration = 1.5;
               Record.QueueDuration = 1.5;
        play = [step(Reader) silencio];
             else
        play =[step(Reader) memory(:,monitoreo)];
               Player.QueueDuration = 0.15;
               Record.QueueDuration = 0.15;
             end

            step(Player, play);
          memory = step(Record); 
        
            for i = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{i};
            step(Writer.(name), memory(:,i));
            end
            
         switch c_mics_simultaneo 
             case 1
                     step(handles.hts,memory(:,1))
             case 2
                     step(handles.hts,memory(:,1), memory(:,2))
             case 3
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3))
             case 4
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3), memory(:,4))
         end
        

        end
            flag_rec = 0;
        
    end

end

flag_rec = 1;
%%%%%Libero los objetos!

release(Record);
release(Player);
release(Reader);
release(handles.hts)
for i =1:c_mics_simultaneo;
name = objectName{mics_actual}{i};
release(Writer.(name));
end

end