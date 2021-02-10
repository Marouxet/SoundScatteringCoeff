          tic;
          j = j + 1;
          buf_plot(m*k+((j-1)*n+1:j*n),:) = memory(1:int_plot:end,:); %Guardando el promedio de el frame
          if j==cant
          %ejey =[ejey(:,1) ;   buf_plot(:,1)];
          plot(ax_chan1,buf_plot(:,1))
          %set(ploteo1,'YData',buf_plot(:,1));
          drawnow
          %hold on
          j = 0;  
          m = m+1;  
          end
          x = x+1;
          tictoc(x) = toc;