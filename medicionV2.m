function  [tiempos] = medicionV2(pointer,handles)

%Creo el Canal de grabación, de reproducción y de escritura
Record = createRecordV2(pointer);
Player = createPlayerV2(pointer);
Writer = createWriterV2(pointer);
Reader = createReaderV2();

load('app_data/current.mat','nmedicion');
load('app_data/current.mat','logico_ordenado');

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
load('app_data/current.mat','xlimites');

trefresh = 1; %tiempo de actualizacion de la pantalla al graficar;
trefresh_s = ceil(trefresh * SampleRate / SamplesPerFrame) * SamplesPerFrame;
frame_plot = trefresh_s /SamplesPerFrame;
int_plot = 4;
b_d_ip = SamplesPerFrame/int_plot;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag_rec =handles.flag_rec;
memory = zeros(Record.BufferSize,length(Record.ChannelMapping));
silencio = zeros(Record.BufferSize,1);
latency = (QueueDuration * SampleRate + 2 * BufferSize)/SampleRate;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%CONFIGURACIÓN DEL GRAFICO
Line = handles.Line;

switch Line
    case 1
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');


    case 2
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

            Line2=line('Parent',handles.ax_chan6, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

    case 3
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

            Line2=line('Parent',handles.ax_chan6, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');        
        
            Line3=line('Parent',handles.ax_chan7, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white'); 
    case 4
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

            Line2=line('Parent',handles.ax_chan6, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');        
        
            Line3=line('Parent',handles.ax_chan7, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');  
        
            Line4=line('Parent',handles.ax_chan8, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');          
    case 5
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

            Line2=line('Parent',handles.ax_chan6, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');        
        
            Line3=line('Parent',handles.ax_chan7, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');  
        
            Line4=line('Parent',handles.ax_chan8, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');         
        
             Line5=line('Parent',handles.ax_chan1, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');
    case 6
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

            Line2=line('Parent',handles.ax_chan6, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');        
        
            Line3=line('Parent',handles.ax_chan7, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');  
        
            Line4=line('Parent',handles.ax_chan8, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');         
        
             Line5=line('Parent',handles.ax_chan1, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');     

             Line6=line('Parent',handles.ax_chan2, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');       
        
    case 7
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

            Line2=line('Parent',handles.ax_chan6, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');        
        
            Line3=line('Parent',handles.ax_chan7, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');  
        
            Line4=line('Parent',handles.ax_chan8, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');         
        
             Line5=line('Parent',handles.ax_chan1, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');     

             Line6=line('Parent',handles.ax_chan2, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');   
        
             Line7=line('Parent',handles.ax_chan3, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');        
    case 8
            Line1=line('Parent',handles.ax_chan5, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');

            Line2=line('Parent',handles.ax_chan6, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');        
        
            Line3=line('Parent',handles.ax_chan7, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');  
        
            Line4=line('Parent',handles.ax_chan8, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');         
        
             Line5=line('Parent',handles.ax_chan1, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');     

             Line6=line('Parent',handles.ax_chan2, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');   
        
             Line7=line('Parent',handles.ax_chan3, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');   
        
             Line8=line('Parent',handles.ax_chan4, ... 
            'Tag','signalLine',...
            'XData',[],'YData',[],...
            'Color','white');         
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tiempos = 0;
frame1 = 1;
frame2 = 1;
frame_ini = 1;
time = 1;
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
  
         %%%Variables Buf_Plot y Time_Plot son usadas para graficar.
         %%%Frame1, Frame2, frame3.. etc, son flags para actualizar las
         %%%distintas líneas de gráficos
         
         buf_plot((frame1-1)*b_d_ip + 1:(frame1*b_d_ip),:) = memory(1:int_plot:end,:);
         time_plot((frame1-1)*b_d_ip + 1:(frame1*b_d_ip)) = (time-1)*SamplesPerFrame + 1:int_plot:(time*SamplesPerFrame);
         frame1 = frame1 + 1;
         frame2 = frame2 + 1;
         frame_ini = frame_ini + 1;
         time = time + 1;
         
%Para simplificar el código hay varios archivos graficarXcanal, donde X es
%la cantidad de canales que se están grabando a la vez.

             if Line == 1
             graficar1canal;
             elseif Line == 2
   %          grafico = tic;
             graficar2canal;
   %          a = toc(grafico);
    %         tiempos = [tiempos a ];
             elseif Line == 3
             graficar3;
             elseif Line == 4
             graficar4;
             elseif Line == 5
             graficar5;
             elseif Line == 6
             graficar6;
             elseif Line == 7
             graficar7;
             elseif Line == 8
             graficar8;
             end
                
    else
        fin_grabacion = tic;
        while toc(fin_grabacion)<latency + sec_factor
        
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
            
         %%%Variables Buf_Plot y Time_Plot son usadas para graficar.
         %%%Frame1, Frame2, frame3.. etc, son flags para actualizar las
         %%%distintas líneas de gráficos
         
            buf_plot((frame1-1)*b_d_ip + 1:(frame1*b_d_ip),:) = memory(1:int_plot:end,:);
            time_plot((frame1-1)*b_d_ip + 1:(frame1*b_d_ip)) = (time-1)*SamplesPerFrame + 1:int_plot:(time*SamplesPerFrame);
            frame1 = frame1 + 1;
            frame2 = frame2 + 1;
            frame_ini = frame_ini + 1;
            time = time + 1;
            
            
             if Line == 1
             graficar1canal;
             elseif Line == 2
%             grafico = tic;
             graficar2canal;
%             a = toc(grafico);
%             tiempos = [tiempos a ];
             elseif Line == 3
             graficar3;
             elseif Line == 4
             graficar4;
             elseif Line == 5
             graficar5;
             elseif Line == 6
             graficar6;
             elseif Line == 7
             graficar7;
             elseif Line == 8
             graficar8;
             end         

        end
            flag_rec = 0;
        
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

end