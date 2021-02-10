function  [] = medicionV2_SWEEP(pointer,handles)

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


global flag_rec
%flag_rec;
 
memory = zeros(Record.BufferSize,length(Record.ChannelMapping));
silencio = zeros(Record.BufferSize,1);
latency = (QueueDuration * SampleRate + 2 * BufferSize)/SampleRate;

hts = handles.hts;
%global flag_rec
while  flag_rec ==1 
 

    if ~isDone(Reader)
        
        if monitoreo ==0
        play = [step(Reader) silencio];
        else
        play =[step(Reader) memory(:,monitoreo)];
        end
        
        step(Player, play);
        memory = step(Record);  
        
         for i = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{i};
            step(Writer.(name), memory(:,i));
          
         end


         switch c_mics_simultaneo 
             case 1
                     step(hts,memory(:,1))
             case 2
                     step(hts,memory(:,1), memory(:,2))
             case 3
                     step(hts,memory(:,1), memory(:,2), memory(:,3))
             case 4
                     step(hts,memory(:,1), memory(:,2), memory(:,3), memory(:,4))
         end

                
    else
        fin_grabacion = tic;
        while toc(fin_grabacion)<latency + sec_factor
        
             if monitoreo ==0
  %             hts.BufferLength = 4096;
               Player.QueueDuration = 1.5;
               Record.QueueDuration = 1.5;
        play = [step(Reader) silencio];
             else
    %           hts.BufferLength = 1024;
               Player.QueueDuration = 0.15;
               Record.QueueDuration = 0.15;
        play =[step(Reader) memory(:,monitoreo)];
             end

            step(Player, play);
          memory = step(Record); 
        
            for i = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{i};
            step(Writer.(name), memory(:,i));
            end
            
            
         switch c_mics_simultaneo 
             case 1
                     step(hts,memory(:,1))
             case 2
                     step(hts,memory(:,1), memory(:,2))
             case 3
                     step(hts,memory(:,1), memory(:,2), memory(:,3))
             case 4
                     step(hts,memory(:,1), memory(:,2), memory(:,3), memory(:,4))
         end

        end
            break
          %  flag_rec = 0;
        
    end

end


%%%%%Libero los objetos!

release(Record);
release(Player);
release(Reader);

for i =1:c_mics_simultaneo;
name = objectName{mics_actual}{i};
release(Writer.(name));
end
% if flag_rec == 0
%     return
% end
end