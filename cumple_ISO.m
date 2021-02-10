%%%cumple_ISO

fuentes = str2double(get(handles.c_mics_total,'String'));
mics = str2double(get(handles.c_fuentes_total,'String'));

if fuentes*mics <12;
    set(handles.cumpleiso,'ForegroundColor',[1 0 0]);
    set(handles.cumpleiso,'Visible','On');
    
else
    set(handles.cumpleiso,'ForegroundColor',[ 0 1 0]);
    set(handles.cumpleiso,'Visible','On');
end
