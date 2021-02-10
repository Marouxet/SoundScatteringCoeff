function varargout = configuracion_proyecto(varargin)
% CONFIGURACION_PROYECTO MATLAB code for configuracion_proyecto.fig
%      CONFIGURACION_PROYECTO, by itself, creates a new CONFIGURACION_PROYECTO or raises the existing
%      singleton*.
%
%      H = CONFIGURACION_PROYECTO returns the handle to a new CONFIGURACION_PROYECTO or the handle to
%      the existing singleton*.
%
%      CONFIGURACION_PROYECTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGURACION_PROYECTO.M with the given input arguments.
%
%      CONFIGURACION_PROYECTO('Property','Value',...) creates a new CONFIGURACION_PROYECTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before configuracion_proyecto_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to configuracion_proyecto_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help configuracion_proyecto

% Last Modified by GUIDE v2.5 28-Jun-2015 13:56:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @configuracion_proyecto_OpeningFcn, ...
                   'gui_OutputFcn',  @configuracion_proyecto_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before configuracion_proyecto is made visible.
function configuracion_proyecto_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to configuracion_proyecto (see VARARGIN)

%New Proyect or Load Session
load('app_data/current.mat','new_proyect')
if new_proyect ~= 1
loadState(handles)
end

%Config_OK
Config_OK = 0;
save('app_data/current.mat','-v6','Config_OK','-append');

% Choose default command line output for configuracion_proyecto
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes configuracion_proyecto wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = configuracion_proyecto_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_mics_total_Callback(hObject, eventdata, handles)
% hObject    handle to c_mics_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_mics_simultaneos = str2num(get(handles.c_mics_simultaneas,'String'));
load('app_data/settings.mat','maxinp')
seleccionado = get(handles.audiodevice,'Value');
seleccionado = seleccionado - 1;
maxinp = maxinp(seleccionado);

if c_mics_simultaneos > maxinp
    errordlg('Ud ha escogido más micrófonos simultáneos que los canales de entrada de su interface','Error de Configuración');
    set(handles.c_mics_simultaneas,'String',maxinp);
end

    c_mics_total =  str2double(get(handles.c_mics_total,'String'));
    if c_mics_simultaneos > c_mics_total
    set (handles.c_mics_simultaneas,'String',c_mics_total)
    end
    
armado_tablas

% --- Executes during object creation, after setting all properties.
function c_mics_total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_mics_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_mics_simultaneas_Callback(hObject, eventdata, handles)
% hObject    handle to c_mics_simultaneas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_mics_simultaneas = str2double(get(hObject,'String'));

load('app_data/settings.mat','maxinp')
seleccionado = get(handles.audiodevice,'Value');
seleccionado = seleccionado - 1; 
maxinp = maxinp(seleccionado);

if c_mics_simultaneas > maxinp
   uiwait( errordlg('Ud ha escogido más micrófonos simultáneos que los canales de entrada de su interface. La cantidad de Micrófonos simultáneos será puesta igual a la cantidad de canales de entrada','Error de Configuración'));
    set(handles.c_mics_simultaneas,'String',maxinp);
end
    c_mics_total =  str2double(get(handles.c_mics_total,'String'));
    if c_mics_simultaneas > c_mics_total
    set (hObject,'String',c_mics_total)
    end
    armado_tablas
% Hints: get(hObject,'String') returns contents of c_mics_simultaneas as text
%        str2double(get(hObject,'String')) returns contents of c_mics_simultaneas as a double


% --- Executes during object creation, after setting all properties.
function c_mics_simultaneas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_mics_simultaneas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in table_mics.
function table_mics_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_mics (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function table_mics_CreateFcn(hObject, eventdata, handles)



function c_fuentes_total_Callback(hObject, eventdata, handles)
% hObject    handle to c_fuentes_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    c_fuentes_simultaneas = str2double(get(handles.c_fuentes_simultaneas,'String'));
    c_fuentes_total =  str2double(get(handles.c_fuentes_total,'String'));
    if c_fuentes_simultaneas > c_fuentes_total
    set (handles.c_fuentes_simultaneas,'String',c_fuentes_total)
    end
    
armado_tablas
%cumple_ISO
% Hints: get(hObject,'String') returns contents of c_fuentes_total as text
%        str2double(get(hObject,'String')) returns contents of c_fuentes_total as a double


% --- Executes during object creation, after setting all properties.
function c_fuentes_total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_fuentes_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_fuentes_simultaneas_Callback(hObject, eventdata, handles)
% hObject    handle to c_fuentes_simultaneas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_fuentes_simultaneas = str2double(get(hObject,'String'));
c_fuentes_total = str2double(get(handles.c_fuentes_total,'String'));

load('app_data/settings.mat','maxout')
seleccionado = get(handles.audiodevice,'Value');
seleccionado = seleccionado -1 ;
maxout = maxout(seleccionado);

if c_fuentes_simultaneas > maxout
    uiwait(errordlg('Ud ha escogido más fuentes simultáneas que los canales de salida de su interface. La cantidad de fuentes simultaneas será puesta en el Máximo de canales de salida menos 1, dejando 1 canal libre para monitorear la grabación (Esto último es opcional)','Error de Configuración'));
    set(handles.c_fuentes_simultaneas,'String',maxout-1);
end

if c_fuentes_simultaneas > c_fuentes_total
    set (hObject,'String',c_fuentes_total)
end
armado_tablas
% Hints: get(hObject,'String') returns contents of c_fuentes_simultaneas as text
%        str2double(get(hObject,'String')) returns contents of c_fuentes_simultaneas as a double


% --- Executes during object creation, after setting all properties.
function c_fuentes_simultaneas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_fuentes_simultaneas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intervalo_angular_Callback(hObject, eventdata, handles)
% hObject    handle to intervalo_angular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intervalo_angular as text
%        str2double(get(hObject,'String')) returns contents of intervalo_angular as a double


% --- Executes during object creation, after setting all properties.
function intervalo_angular_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intervalo_angular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in configuracion_mesa.
function configuracion_mesa_Callback(hObject, eventdata, handles)
red = get(handles.mesa_outline_red,'Value');
if red ==1
    uiwait(conf_mesa);
end
    


% --- Executes on selection change in audiodevice.
function audiodevice_Callback(hObject, eventdata, handles)
% hObject    handle to audiodevice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

seleccionado = get(hObject,'Value');
if seleccionado ==1
    return
else
    seleccionado = seleccionado -1;
end

load('app_data/settings.mat','maxinp')
load('app_data/settings.mat','maxout')

set(handles.maxinput,'String',maxinp(seleccionado))
set(handles.maxout,'String',maxout(seleccionado))
set(handles.c_mics_simultaneas,'String',maxinp(seleccionado));
set(handles.c_mics_simultaneas,'Enable','On')
set(handles.c_mics_total,'String',maxinp(seleccionado));
set(handles.c_mics_total,'Enable','On')
set(handles.c_fuentes_simultaneas,'String','1');
set(handles.c_fuentes_simultaneas,'Enable','On')
set(handles.c_fuentes_total,'String','1');
set(handles.c_fuentes_total,'Enable','On')
armado_tablas
%set(handles.ver_estructura_medicion,'Enable','On')
load('app_data/current.mat','configuracion_ok')
configuracion_ok(1) = 1;
save('app_data/current.mat','-v6','configuracion_ok','-append');
estructura_medicion
% Hints: contents = cellstr(get(hObject,'String')) returns audiodevice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from audiodevice


% --- Executes during object creation, after setting all properties.
function audiodevice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to audiodevices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
[inputdevices, maxinp, maxout] = inputhardware();
save('app_data/settings.mat','inputdevices','maxinp','maxout','-append');
set(hObject,'String',inputdevices)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in buffer.
function buffer_Callback(hObject, eventdata, handles)
% hObject    handle to buffer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ioconfig
% Hints: contents = cellstr(get(hObject,'String')) returns buffer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from buffer


% --- Executes during object creation, after setting all properties.
function buffer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buffer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Queue_Callback(hObject, eventdata, handles)
% hObject    handle to Queue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ioconfig
% Hints: get(hObject,'String') returns contents of Queue as text
%        str2double(get(hObject,'String')) returns contents of Queue as a double


% --- Executes during object creation, after setting all properties.
function Queue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Queue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in fs.
function fs_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in fs 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
ioconfig


% --- Executes on selection change in salida_monitoreo.
function salida_monitoreo_Callback(hObject, eventdata, handles)
% hObject    handle to salida_monitoreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fuentes_grabacion = get(handles.table_fuentes,'Data');
fuentes_grabacion = fuentes_grabacion(:,2);
value = get(hObject,'Value');
string = get(hObject,'String');
if sum(strcmp(fuentes_grabacion(:),string(value)))
    ButtonName = questdlg('Ud ha escogido la misma Salida para monitorear que para una de las fuentes. ¿Desea usar una fuente SIMULTANEA menos o grabar sin Monitorear?','Incompatibilidad en la Configuración','Usar una fuente Simultánea menos','Grabar sin Monitorear','Usar una fuente Simultánea menos');
     switch ButtonName,
         case 'Usar una fuente Simultánea menos'
            A = str2double(get(handles.c_fuentes_simultaneas,'String'));
            set(handles.c_fuentes_simultaneas,'String',A-1);
            armado_tablas
         case 'Grabar sin Monitorear'
             set(hObject,'Value',1)
         case []
             set(hObject,'Value',1)
     end 
end
% Hints: contents = cellstr(get(hObject,'String')) returns salida_monitoreo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from salida_monitoreo


% --- Executes during object creation, after setting all properties.
function salida_monitoreo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to salida_monitoreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel20.
function uipanel20_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel20 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
estructura_medicion


% --- Executes on button press in ver_estructura_medicion.
function ver_estructura_medicion_Callback(hObject, eventdata, handles)
% hObject    handle to ver_estructura_medicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uipanel21.
function uipanel21_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel21 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%estructura_medicion_2
Armado_medicion_2;
saveState(handles)
close;


% --- Executes when selected object is changed in uipanel23.
function uipanel23_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel23 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
set(handles.mesa_outline_red,'Enable','On')
set(handles.configuracion_mesa,'Enable','On')


mls_on = get(handles.choose_mls,'Value');
if mls_on ==1
    set(handles.aviso_mls,'Visible','On');
    set(handles.medicion_continua,'Enable','On')
    set(handles.medicion_continua,'Value',1)
    set(handles.intervalo_angular_text,'Value',0);
    set(handles.intervalo_angular,'String','NO');
    set(handles.intervalo_angular_text,'Enable','Off');
    set(handles.intervalo_angular,'Enable','Off');
else
    set(handles.aviso_mls,'Visible','Off');
    set(handles.medicion_continua,'Value',0)
    set(handles.medicion_continua,'Enable','Off')
    set(handles.intervalo_angular_text,'Value',1);
    set(handles.intervalo_angular,'String','5');
    set(handles.intervalo_angular_text,'Enable','On');
    set(handles.intervalo_angular,'Enable','On');
end
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uipanel23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in generar_senial.
function generar_senial_Callback(hObject, eventdata, handles)
mls_on = get(handles.choose_mls,'Value');
if mls_on == 1
    typesignal = 'MLS';
else
    typesignal = 'SWEEP';
end
save('app_data/settings.mat','typesignal','-append')
uiwait(generator)
load('app_data/current.mat','configuracion_ok')
configuracion_ok(2) = 1;
save('app_data/current.mat','-v6','configuracion_ok','-append');
% hObject    handle to generar_senial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in dd.
function dd_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in dd 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

function saveState(handles)
%Session
session.audiodevice_string = get(handles.audiodevice,'String');
session.audiodevice_value = get(handles.audiodevice,'Value');
session.buffer_string = get(handles.buffer,'String');
session.buffer_value = get(handles.buffer,'Value');
session.Queue = get(handles.Queue,'String');
session.fs44100 = get(handles.fs44100,'Value');
session.fs48000 = get(handles.fs48000,'Value');
session.nbits16 = get(handles.nbits16,'Value');
session.nbits24 = get(handles.nbits24,'Value');
session.c_mics_total = get(handles.c_mics_total,'String');
session.c_mics_simultaneas = get(handles.c_mics_simultaneas,'String');
session.table_mics_data = get(handles.table_mics,'Data');
session.table_mics_row = get(handles.table_mics,'RowName');
session.table_mics_column = get(handles.table_mics,'ColumnName');
session.c_fuentes_total = get(handles.c_fuentes_total,'String');
session.c_fuentes_simultaneas =get(handles.c_fuentes_simultaneas,'String');
session.table_fuentes_data =get(handles.table_fuentes,'Data');
session.table_fuentes_row =get(handles.table_fuentes,'RowName');
session.table_fuentes_column =get(handles.table_fuentes,'ColumnName');
session.mls = get(handles.choose_mls,'Value');
session.sweep = get(handles.choose_sweep,'Value');
session.intervalo_angular_text = get(handles.intervalo_angular_text, 'Value');
session.intervalo_angular = get(handles.intervalo_angular, 'String');
session.salida_monitoreo_string = get(handles.salida_monitoreo, 'String');
session.salida_monitoreo_value = get(handles.salida_monitoreo, 'Value');
session.prioridad1 = get(handles.prioridad1, 'Value');
session.prioridad2 = get(handles.prioridad2, 'Value');
session.prioridad3 = get(handles.prioridad3, 'Value');
session.luego1 = get(handles.luego1, 'Value');
session.luego2 = get(handles.luego2, 'Value');
session.luego3 = get(handles.luego3, 'Value');
session.luego1_en = get(handles.luego1, 'Enable');
session.luego2_en = get(handles.luego2, 'Enable');
session.luego3_en = get(handles.luego3, 'Enable');
session.corregido_no = get(handles.corregido_no, 'Value');
session.corregido_end = get(handles.corregido_end, 'Value');
session.corregido_first = get(handles.corregido_first, 'Value');
session.con_difusor = get(handles.con_difusor, 'Value');
session.sin_difusor = get(handles.sin_difusor, 'Value');

save('app_data/current.mat','-v6','session','-append');

%New Proyect
load('app_data/current.mat','new_proyect')
if new_proyect == 1;
    new_proyect = 0;
end

save('app_data/current.mat','-v6','new_proyect','-append');

%Config_OK
Config_OK = 1;
save('app_data/current.mat','-v6','Config_OK','-append');


function loadState(handles)

load('app_data/current.mat','session')

set(handles.audiodevice,'String',session.audiodevice_string);
set(handles.audiodevice,'Value',session.audiodevice_value);
set(handles.buffer,'String',session.buffer_string);
set(handles.buffer,'Value',session.buffer_value);
set(handles.Queue,'String',session.Queue);
set(handles.fs44100,'Value',session.fs44100);
set(handles.fs48000,'Value',session.fs48000);
set(handles.nbits16,'Value',session.nbits16);
set(handles.nbits24,'Value',session.nbits24);
set(handles.c_mics_total,'String',session.c_mics_total);
set(handles.c_mics_total,'Enable', 'On');
set(handles.c_mics_simultaneas,'String',session.c_mics_simultaneas);
set(handles.c_mics_simultaneas, 'Enable', 'On');
set(handles.table_mics,'Data',session.table_mics_data);
set(handles.table_mics,'RowName',session.table_mics_row);
set(handles.table_mics,'ColumnName',session.table_mics_column);
set(handles.table_mics, 'Enable', 'On')
set(handles.c_fuentes_total,'String',session.c_fuentes_total);
set(handles.c_fuentes_total,'Enable', 'On');
set(handles.c_fuentes_simultaneas,'String',session.c_fuentes_simultaneas);
set(handles.c_fuentes_simultaneas,'Enable', 'On');
set(handles.table_fuentes,'Data',session.table_fuentes_data);
set(handles.table_fuentes,'RowName',session.table_fuentes_row);
set(handles.table_fuentes,'ColumnName',session.table_fuentes_column);
set(handles.table_fuentes, 'Enable', 'On')
set(handles.choose_mls,'Value',session.mls);
set(handles.choose_sweep,'Value',session.sweep);
set(handles.table_mics, 'Enable', 'On')

set(handles.intervalo_angular_text, 'Value', session.intervalo_angular_text);
set(handles.intervalo_angular, 'String', session.intervalo_angular);
set(handles.salida_monitoreo, 'String', session.salida_monitoreo_string);
set(handles.salida_monitoreo, 'Value', session.salida_monitoreo_value);
set(handles.prioridad1, 'Value',session.prioridad1);
set(handles.prioridad2, 'Value', session.prioridad2);
set(handles.prioridad3, 'Value', session.prioridad3);
set(handles.luego1, 'Value', session.luego1);
set(handles.luego2, 'Value', session.luego2);
set(handles.luego3, 'Value', session.luego3);
set(handles.luego1, 'Enable',session.luego1_en);
set(handles.luego2, 'Enable',session.luego2_en);
set(handles.luego3, 'Enable',session.luego3_en);

set(handles.corregido_no, 'Value',session.corregido_no);
set(handles.corregido_end, 'Value', session.corregido_end);
set(handles.corregido_first, 'Value',session.corregido_first);
set(handles.con_difusor, 'Value',session.con_difusor);
set(handles.sin_difusor, 'Value', session.sin_difusor);
