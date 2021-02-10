%%%%%%%%%%%%%Estructura de medición

prioridad1 = get(handles.prioridad1,'Value');
prioridad2 = get(handles.prioridad2,'Value');

if prioridad1 == 1
    set(handles.luego1,'Value',0);
    set(handles.luego1,'Enable','Off');
    set(handles.luego2,'Enable','On');
    set(handles.luego2,'Value',1);
    set(handles.luego3,'Enable','On');
else
    if prioridad2 == 1
        set(handles.luego2,'Value',0);
        set(handles.luego2,'Enable','Off');
        set(handles.luego1,'Enable','On');
        set(handles.luego1,'Value',1);
        set(handles.luego3,'Enable','On');
    else
        set(handles.luego3,'Value',0);
        set(handles.luego3,'Enable','Off');
        set(handles.luego1,'Enable','On');
        set(handles.luego1,'Value',1);
        set(handles.luego2,'Enable','On');
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 