         
         if frame_ini == round(frame_plot/2)
         set(Line2,'XData',time_plot,'YData',buf_plot(:,2)); 
         frame2 = 1;
         drawnow
         end
         
         if frame1 == frame_plot
             tic
         Line1 = copyobj(Line1,handles.ax_chan5);
         %Line2 = copyobj(Line2,handles.ax_chan6);
         set(Line1,'XData',time_plot,'YData',buf_plot(:,1)); 
         %set(Line2,'XData',time_plot,'YData',buf_plot(:,1)); 
         drawnow;
         frame1 = 1;
         toc
         end
         
         if frame2 == frame_plot 
             tic
         %set(Line1,'XData',time_plot,'YData',buf_plot(:,2));
         Line2 = copyobj(Line2,handles.ax_chan6);
         set(Line2,'XData',time_plot,'YData',buf_plot(:,2)); 
         drawnow;
         frame2 = 1;
         toc
         end
         