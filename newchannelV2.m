load('app_data/settings.mat','c_mics_simultaneo');
load('app_data/settings.mat','nBits');
load('app_data/settings.mat','objectName');
%load('app_data/current.mat','xlimites');
load('app_data/settings.mat','int_plot');
load('app_data/settings.mat','BufferSize');
load('app_data/settings.mat','QueueDuration');
load('app_data/settings.mat','SamplesPerFrame');
load('app_data/settings.mat','SampleRate');

latency = 2*BufferSize + QueueDuration*SampleRate;

     if c_mics_simultaneo >= 1
         
         set(handles.panel_config_chan1,'Visible','On')
         
%          set(handles.ax_chan5,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan5,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan5,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line1=line('Parent',handles.ax_chan5, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);

     if c_mics_simultaneo>= 2
         
    set(handles.panel_config_chan2,'Visible','On')
    
%          set(handles.ax_chan6,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan6,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan6,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line2=line('Parent',handles.ax_chan6, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);
% 
     if c_mics_simultaneo >= 3
         set(handles.panel_config_chan3, 'Visible','On')
%         set(handles.ax_chan7,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan7,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan7,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line3=line('Parent',handles.ax_chan7, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);
        
     if c_mics_simultaneo >= 4
         set(handles.panel_config_chan4,'Visible','On')
%          set(handles.ax_chan8,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan8,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan8,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line4=line('Parent',handles.ax_chan8, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);
%         
     if c_mics_simultaneo >= 5
         set(handles.panel_config_chan5,'Visible','On')
%          set(handles.ax_chan1,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan1,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan1,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line5=line('Parent',handles.ax_chan1, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);
         
              if c_mics_simultaneo >= 6
                  set(handles.panel_config_chan6,'Visible','On')
%          set(handles.ax_chan2,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan2,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan2,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line6=line('Parent',handles.ax_chan2, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);
         
              if c_mics_simultaneo >= 7
                  set(handles.panel_config_chan7,'Visible','On')
%          set(handles.ax_chan3,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan3,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan3,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line7=line('Parent',handles.ax_chan3, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);
         
              if c_mics_simultaneo >= 8
                  set(handles.panel_config_chan8,'Visible','On')
%          set(handles.ax_chan4,'Visible','On',...
%                                   'box','on',...
%                  'MinorGridLineStyle','none',...
%                             'NextPlot','add',...
%                        'XTick',[],'YTick',[],...
%                        'XLim',[latency xlimites(2)+latency]);
%          if nBits == 16
%              set(handles.ax_chan4,'Ylim',[-32767 32767]);
%          else
%              set(handles.ax_chan4,'Ylim',[-2147483647 2147483647]);
%          end
%         
%          Line8=line('Parent',handles.ax_chan4, ... 
%             'Tag','signalLine',...
%             'XData',[],'YData',[]);
              end
              end
              end
         
     end
     end
     end
     end
     end

%   if     exist('Line8','var')
%       handles.Line = 8;
%   elseif exist('Line7','var')
%       handles.Line = 7;
%   elseif exist('Line6','var')
%       handles.Line = 6;
%   elseif exist('Line5','var')
%       handles.Line = 5;
%   elseif exist('Line4','var')
%       handles.Line = 4;
%   elseif exist('Line3','var')
%       handles.Line = 3;
%   elseif exist('Line2','var')
%       handles.Line = 2;
%   else
%       handles.Line = 1;
%   end
 % Armado de TimeScope
% load('app_data/settings.mat','hts');
% show(hts)
% %hts = dsp.TimeScope;
% hts.Name = 'Grafica de señales Grabadas';
% load('app_data/settings.mat','c_mics_simultaneo');
% hts.NumInputPorts = c_mics_simultaneo;
% load('app_data/settings.mat','SampleRate');
% hts.SampleRate = SampleRate;
% hts.YLimits = [-2^16 2^16];
% load('app_data/current.mat','sweep_duracion');
% load('app_data/current.mat','sweep_silencio');
% hts.TimeSpan = sweep_duracion + sweep_silencio;
% hts.LayoutDimensions = [c_mics_simultaneo 1];
% save('app_data/settings.mat','-v6','hts','-append');
%handles.hts = hts;
%guidata(hObject,handles);
%show(hts)