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
             graficar2canal;
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
   %          graficar1canal;
             elseif Line == 2
%             grafico = tic;
    %         graficar2canal;
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