load('app_data/current.mat','active_chan');
load('app_data/settings.mat','maxinp');
load('app_data/settings.mat','Canales');
load('app_data/settings.mat','objectName');
load('app_data/settings.mat','nBits');
load('app_data/current.mat','xlimites');

if(active_chan<maxinp)
 switch(active_chan)
     case 0
         active_chan = 1;
         save('app_data/current.mat','active_chan','-append');
         set(handles.panel_config_chan1,'Visible','On')
         set(handles.ax_chan1,'Visible','On')
         set(handles.ax_chan1,'box','on')
         set(handles.ax_chan1,'MinorGridLineStyle','none')
         set(handles.ax_chan1,'NextPlot','add')
         set(handles.ax_chan1,'XTick',[])
         set(handles.ax_chan1,'YTick',[]) 
        
         if nBits == 16
             set(handles.ax_chan1,'Ylim',[-32767 32767]);
         else
             set(handles.ax_chan1,'Ylim',[-2147483647 2147483647]);
         end
        
         set(handles.c1_canales,'String',Canales)
         objectName = {'Chann1'};
         save('app_data/settings.mat','objectName','-append');
         ax_chan1 = handles.ax_chan1;
         save('app_data/current.mat','ax_chan1','-append');

     case 1
         active_chan = 2;
         save('app_data/current.mat','active_chan','-append');
         set(handles.panel_config_chan2,'Visible','On')
         set(handles.ax_chan2,'Visible','On')
         set(handles.ax_chan2,'box','on')
         set(handles.ax_chan2,'MinorGridLineStyle','none')
         set(handles.ax_chan2,'NextPlot','add')
         set(handles.ax_chan2,'XTick',[])
         set(handles.ax_chan2,'YTick',[])
         if nBits == 16
             set(handles.ax_chan2,'Ylim',[-32767 32767]);
         else
             set(handles.ax_chan2,'Ylim',[-2147483647 2147483647]);
         end
         set(handles.c2_canales,'String',Canales)
         objectName = [objectName 'Chann2'];
         save('app_data/settings.mat','objectName','-append');
         ax_chan2 = handles.ax_chan2;
         save('app_data/current.mat','ax_chan2','-append');

     case 2
         active_chan = 3;
         save('app_data/current.mat','active_chan','-append');
         set(handles.panel_config_chan3,'Visible','On')
         set(handles.ax_chan3,'Visible','On')
         set(handles.ax_chan3,'box','on')
         set(handles.ax_chan3,'MinorGridLineStyle','none')
         set(handles.ax_chan3,'NextPlot','add')
         set(handles.ax_chan3,'XTick',[])
         set(handles.ax_chan3,'YTick',[])
         if nBits == 16
             set(handles.ax_chan3,'Ylim',[-32767 32767]);
         else
             set(handles.ax_chan3,'Ylim',[-2147483647 2147483647]);
         end
         set(handles.c3_canales,'String',Canales)
         objectName = [objectName 'Chann3'];
         save('app_data/settings.mat','objectName','-append');
         ax_chan3 = handles.ax_chan3;
         save('app_data/current.mat','ax_chan3','-append');
     case 3
         active_chan = 4;
         save('app_data/current.mat','active_chan','-append');
         set(handles.panel_config_chan4,'Visible','On')
         set(handles.ax_chan4,'Visible','On')
         set(handles.ax_chan4,'box','on')
         set(handles.ax_chan4,'MinorGridLineStyle','none')
         set(handles.ax_chan4,'NextPlot','add')
         set(handles.ax_chan4,'XTick',[])
         set(handles.ax_chan4,'YTick',[])
         if nBits == 16
             set(handles.ax_chan4,'Ylim',[-32767 32767]);
         else
             set(handles.ax_chan4,'Ylim',[-2147483647 2147483647]);
         end
         set(handles.c4_canales,'String',Canales)
         objectName = [objectName 'Chann4'];
         save('app_data/settings.mat','objectName','-append');
         ax_chan4 = handles.ax_chan4;
         save('app_data/current.mat','ax_chan4','-append');

     case 4
      return
 end
else
errordlg('Su placa de audio no tiene más canales disponibles', 'Error');
return
end
