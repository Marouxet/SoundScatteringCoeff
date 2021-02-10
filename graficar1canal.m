         if frame1 == frame_plot
         Line1 = copyobj(Line1,handles.ax_chan5);
         %Line2 = copyobj(Line2,handles.ax_chan6);
         set(Line1,'XData',time_plot,'YData',buf_plot(:,1)); 
         %set(Line2,'XData',time_plot,'YData',buf_plot(:,1)); 
         drawnow;
         frame1 = 1;
         end
         