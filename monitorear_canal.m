
load('app_data/current.mat','monitoreo');
switch canal
    case 1
    if monitoreo ~= canal;
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);

        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = 0;
        save('app_data/current.mat','monitoreo','-append');
    end
    
    case 2
    if monitoreo ~= canal;
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
         set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
       set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
       monitoreo = 0;
       save('app_data/current.mat','monitoreo','-append');
    end

    
    case 3
    if monitoreo ~= canal;
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
         set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
       set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
       monitoreo = 0;
       save('app_data/current.mat','monitoreo','-append');
    end

    case 4
    if monitoreo ~= canal;
        set(handles.icon_chan4_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
         set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
       set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
       monitoreo = 0;
       save('app_data/current.mat','monitoreo','-append');
    end
    case 5
    if monitoreo ~= canal;
        set(handles.icon_chan5_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
         set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
       set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
       monitoreo = 0;
       save('app_data/current.mat','monitoreo','-append');
    end
    case 6
    if monitoreo ~= canal;
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
         set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
       set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
       monitoreo = 0;
       save('app_data/current.mat','monitoreo','-append');
    end
    case 7
    if monitoreo ~= canal;
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
         set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
       set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
       monitoreo = 0;
       save('app_data/current.mat','monitoreo','-append');
    end
    case 8
    if monitoreo ~= canal;
        set(handles.icon_chan8_monitoreo,'BackgroundColor',[1 0 0 ]);
        set(handles.icon_chan2_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan3_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan1_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
         set(handles.icon_chan5_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan6_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan7_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        set(handles.icon_chan4_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
        monitoreo = canal;
        save('app_data/current.mat','monitoreo','-append');
    else
       set(handles.icon_chan8_monitoreo,'BackgroundColor',[ 0.9412    0.9412    0.9412 ]);
       monitoreo = 0;
       save('app_data/current.mat','monitoreo','-append');
    end
end

if monitoreo == 0
hts = handles.hts;
hts.BufferLength = 4096;
else
hts = handles.hts;
hts.BufferLength = 1024;
end
handles.hts = hts;
guidata(hObject,handles)
