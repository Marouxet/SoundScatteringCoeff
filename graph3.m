
          j = j + 1;
          buf_plot(((j-1)*n+1:j*n),:) = memory(1:int_plot:end,:); 
          if j==cant
          
%               switch active_chan
%                   case 1
%                   plot(ax_chan1,m*k+1:(m+1)*k,buf_plot(:,1))
%                   case 2
                    tic
                    


                  plot(handles.ax_chan5,m*k+1:(m+1)*k,buf_plot(:,1))
                  plot(handles.ax_chan6,m*k+1:(m+1)*k,buf_plot(:,2))
                  toc
%                   case 3
%                   plot(ax_chan1,m*k+1:(m+1)*k,buf_plot(:,1))
%                   plot(ax_chan2,m*k+1:(m+1)*k,buf_plot(:,2))
%                   plot(ax_chan3,m*k+1:(m+1)*k,buf_plot(:,3))
%                   case 4
%                   plot(ax_chan1,m*k+1:(m+1)*k,buf_plot(:,1))
%                   plot(ax_chan2,m*k+1:(m+1)*k,buf_plot(:,2))
%                   plot(ax_chan3,m*k+1:(m+1)*k,buf_plot(:,3))
%                   plot(ax_chan4,m*k+1:(m+1)*k,buf_plot(:,4))
%               end
          drawnow
         
         % j = 0;  
          m = m+1;  
          end
          x = x+1;
