function varargout = conf_mesa(varargin)
% CONF_MESA MATLAB code for conf_mesa.fig
%      CONF_MESA, by itself, creates a new CONF_MESA or raises the existing
%      singleton*.
%
%      H = CONF_MESA returns the handle to a new CONF_MESA or the handle to
%      the existing singleton*.
%
%      CONF_MESA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONF_MESA.M with the given input arguments.
%
%      CONF_MESA('Property','Value',...) creates a new CONF_MESA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before conf_mesa_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to conf_mesa_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help conf_mesa

% Last Modified by GUIDE v2.5 22-Feb-2015 09:11:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @conf_mesa_OpeningFcn, ...
                   'gui_OutputFcn',  @conf_mesa_OutputFcn, ...
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


% --- Executes just before conf_mesa is made visible.
function conf_mesa_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to conf_mesa (see VARARGIN)

% Choose default command line output for conf_mesa
handles.output = hObject;
%Cargo variables guardadas en Settings y lleno los campos de la GUI con las
%configuraciones
load('app_data/settings.mat','mesa_ip');
load('app_data/settings.mat','vel_rotacion');
set(handles.red_ip_mesa,'String',mesa_ip.ip_mesa);
set(handles.red_name,'String',mesa_ip.nombre_red);
set(handles.red_ip_pc,'String',mesa_ip.ip_pc);
set(handles.red_subred_pc,'String',mesa_ip.mask_pc);
set(handles.red_enlace_pc,'String',mesa_ip.enlace_pc);
set(handles.rpm_mesa,'String',vel_rotacion);
set(handles.vel_360,'String',fix(60/vel_rotacion));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes conf_mesa wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = conf_mesa_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function red_name_Callback(hObject, eventdata, handles)
% hObject    handle to red_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of red_name as text
%        str2double(get(hObject,'String')) returns contents of red_name as a double


% --- Executes during object creation, after setting all properties.
function red_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function red_ip_mesa_Callback(hObject, eventdata, handles)
% hObject    handle to red_ip_mesa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Cargo el IP de la mesa y le sumo uno para estar en la misma red pero con
%diferente IP
ip_mesa = get(handles.red_ip_mesa,'String');
%Advertencia si el usuario no completo todos los caracteres
if length(ip_mesa) ~=15
    errordlg('Por favor ingrese todos los números en el IP (Complete con 0)');
    return
end
ip_mesa_num = str2double(ip_mesa(end-2:end));
ip_pc_num = ip_mesa_num + 1;
ip_pc = strcat(ip_mesa(1:end-3),num2str(ip_pc_num));
set(handles.red_ip_pc,'String',ip_pc);

% Hints: get(hObject,'String') returns contents of red_ip_mesa as text
%        str2double(get(hObject,'String')) returns contents of red_ip_mesa as a double


% --- Executes during object creation, after setting all properties.
function red_ip_mesa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_ip_mesa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in red_configurar.
function red_configurar_Callback(hObject, eventdata, handles)
%Tomando Variables de los cuadros de texto
mesa_ip.ip_mesa = get(handles.red_ip_mesa,'String');
mesa_ip.nombre_red = get(handles.red_name,'String');
mesa_ip.ip_pc =  get(handles.red_ip_pc,'String');
mesa_ip.mask_pc = get(handles.red_subred_pc,'String');
mesa_ip.enlace_pc =  get(handles.red_enlace_pc,'String');

%Guardado de configuracion
save('app_data/settings.mat','mesa_ip','-append');

%Configuro la red usando CMD de windows

orden = strcat('netsh interface ip set address',{' '}, '"',mesa_ip.nombre_red,'"',{' '},...
    'static', {' '} , mesa_ip.ip_pc , {' '} ,mesa_ip.mask_pc, {' '} , mesa_ip.enlace_pc, {' '}, '1'); 
[s , w] =dos(orden{:});
if s ==1
    errordlg(strcat('Mensaje de Error proveniente del CMD de windows:', w));
    set(handles.red_resultado,'String','No se pudo establecer la RED');
    set(handles.red_resultado,'ForegroundColor',[1 0 0]);
    set(handles.red_resultado,'Enable','On'); 
    set(handles.red_resultado,'Visible','On');
    return
else
    msgbox('Windows no retornó errores al hacer la configuración de la red. Por favor, verifique si la mesa responde haciendo Clic en "Test!"');
    set(handles.red_resultado,'String','RED OK - Verificar haciendo clic en Test!');
    set(handles.red_resultado,'ForegroundColor',[0.7 0.7 .3]);
    set(handles.red_resultado,'Enable','On');    
    set(handles.red_resultado,'Visible','On');
end

function red_resultado_Callback(hObject, eventdata, handles)
% hObject    handle to red_resultado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of red_resultado as text
%        str2double(get(hObject,'String')) returns contents of red_resultado as a double


% --- Executes during object creation, after setting all properties.
function red_resultado_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_resultado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in red_test.
function red_test_Callback(hObject, eventdata, handles)
[angle,x ] = ET250_3D('set', 15);
angle_current = ET250_3D('get', 0);
while angle_current ~= 15
tic 
while toc < 1; 
end; 
angle_current = ET250_3D('get', 0);
end

test_ans = questdlg('¿El ángulo de la Mesa es 15 grados?','Verificación de la configuración','Sí','No','Cancelar','Si');

switch test_ans
     case 'Sí',
    set(handles.red_resultado,'String','RED OK - Verificada');
    set(handles.red_resultado,'ForegroundColor',[.1 .9 .1]);
    set(handles.red_resultado,'Enable','On');    
    set(handles.red_resultado,'Visible','On');    
    [angle,x ] = ET250_3D('set', 0);
     case 'No',
      return
      case 'Cancelar',
      return
  
end 
% hObject    handle to red_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function red_ip_pc_Callback(hObject, eventdata, handles)
% hObject    handle to red_ip_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of red_ip_pc as text
%        str2double(get(hObject,'String')) returns contents of red_ip_pc as a double


% --- Executes during object creation, after setting all properties.
function red_ip_pc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_ip_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function red_subred_pc_Callback(hObject, eventdata, handles)
% hObject    handle to red_subred_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of red_subred_pc as text
%        str2double(get(hObject,'String')) returns contents of red_subred_pc as a double


% --- Executes during object creation, after setting all properties.
function red_subred_pc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_subred_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function red_enlace_pc_Callback(hObject, eventdata, handles)
% hObject    handle to red_enlace_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of red_enlace_pc as text
%        str2double(get(hObject,'String')) returns contents of red_enlace_pc as a double


% --- Executes during object creation, after setting all properties.
function red_enlace_pc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_enlace_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in red_ok.
function red_ok_Callback(hObject, eventdata, handles)
close



function vel_360_Callback(hObject, eventdata, handles)
% hObject    handle to vel_360 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vel_rotacion = 60/str2double(get(hObject,'String'));
set(handles.rpm_mesa,'String',round(vel_rotacion*100)/100);
save('app_data/settings.mat','vel_rotacion','-append');

% Hints: get(hObject,'String') returns contents of vel_360 as text
%        str2double(get(hObject,'String')) returns contents of vel_360 as a double


% --- Executes during object creation, after setting all properties.
function vel_360_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vel_360 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rpm_mesa_Callback(hObject, eventdata, handles)
% hObject    handle to rpm_mesa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vel_rotacion = str2double(get(hObject,'String'));
vel = fix(60/vel_rotacion);
set(handles.vel_360,'String',vel);
save('app_data/settings.mat','vel_rotacion','-append');
% Hints: get(hObject,'String') returns contents of rpm_mesa as text
%        str2double(get(hObject,'String')) returns contents of rpm_mesa as a double


% --- Executes during object creation, after setting all properties.
function rpm_mesa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rpm_mesa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
