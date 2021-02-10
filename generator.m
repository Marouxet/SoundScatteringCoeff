function varargout = generator(varargin)
% GENERATOR MATLAB code for generator.fig
%      GENERATOR, by itself, creates a new GENERATOR or raises the existing
%      singleton*.
%
%      H = GENERATOR returns the handle to a new GENERATOR or the handle to
%      the existing singleton*.
%
%      GENERATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERATOR.M with the given input arguments.
%
%      GENERATOR('Property','Value',...) creates a new GENERATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before generator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to generator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help generator

% Last Modified by GUIDE v2.5 22-Feb-2015 11:37:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @generator_OpeningFcn, ...
                   'gui_OutputFcn',  @generator_OutputFcn, ...
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


% --- Executes just before generator is made visible.
function generator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to generator (see VARARGIN)

% Choose default command line output for generator
handles.output = hObject;
load('app_data/settings.mat','typesignal')
if strcmp(typesignal,'MLS')
    set(handles.sweep_f1,'Enable','Off')
    set(handles.sweep_f2,'Enable','Off')
    set(handles.sweep_duracion,'Enable','Off')
    set(handles.sweep_amplitud,'Enable','Off')
    set(handles.sweep_silencio,'Enable','Off')
    set(handles.sweep_ok,'Enable','Off')

    set(handles.MLS_orden,'Enable','On')
    set(handles.MLS_amplitud,'Enable','On')
    set(handles.MLS_OK,'Enable','On')
else
    set(handles.sweep_f1,'Enable','On')
    set(handles.sweep_f2,'Enable','On')
    set(handles.sweep_duracion,'Enable','On')
    set(handles.sweep_amplitud,'Enable','On')
    set(handles.sweep_silencio,'Enable','On')
    set(handles.sweep_ok,'Enable','On')

    set(handles.MLS_orden,'Enable','Off')
    set(handles.MLS_amplitud,'Enable','Off')
    set(handles.MLS_OK,'Enable','Off')
end
%load('app_data/settings.mat')
load('app_data/settings.mat','vel_rotacion');
vel = num2str(vel_rotacion);
text_vel = strcat('Velocidad Rotación: ', vel,' [rpm]' );
set(handles.tiempomesa_shown,'String',text_vel);

load('app_data/settings.mat','SampleRate');
SampleRate = num2str(SampleRate);
text_freq = strcat('Frec de Muestreo: ', SampleRate,' [Hz]' );
set(handles.fs_shown,'String',text_freq);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes generator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = generator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in toggle_sine.
function toggle_sine_Callback(hObject, eventdata, handles)
% hObject    handle to toggle_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.toggle_mls, 'Value',0);
position = get(handles.MLS_panel,'Position');
set(handles.MLS_panel,'Visible','off');
set(handles.sweep_panel,'Position',position);
set(handles.sweep_panel,'Visible','on')
% Hint: get(hObject,'Value') returns toggle state of toggle_sine


% --- Executes on button press in toggle_mls.
function toggle_mls_Callback(hObject, eventdata, handles)
% hObject    handle to toggle_mls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.toggle_sine, 'Value',0);
position = get(handles.sweep_panel,'Position');
set(handles.sweep_panel,'Visible','off');
set(handles.MLS_panel,'Position',position);
set(handles.MLS_panel,'Visible','on');
% Hint: get(hObject,'Value') returns toggle state of toggle_mls



function sweep_frec1_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_frec1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_frec1 as text
%        str2double(get(hObject,'String')) returns contents of sweep_frec1 as a double


% --- Executes during object creation, after setting all properties.
function sweep_frec1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_frec1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_frec2_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_frec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_frec2 as text
%        str2double(get(hObject,'String')) returns contents of sweep_frec2 as a double


% --- Executes during object creation, after setting all properties.
function sweep_frec2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_frec2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_duracion_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_duracion as text
%        str2double(get(hObject,'String')) returns contents of sweep_duracion as a double


% --- Executes during object creation, after setting all properties.
function sweep_duracion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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


% --- Executes on selection change in MLS_orden.
function MLS_orden_Callback(hObject, eventdata, handles)
% hObject    handle to MLS_orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

seleccion = get(handles.MLS_orden,'Value'); %tomo el valor seleccionado en el Orden MLS

switch seleccion
    case 2 %2
    N = 2;
    mls_orden = '2';	
    case 3%3
    N = 3;
    mls_orden = '3';
    case 4%4
    N = 4;
    mls_orden = '4';
    case 5%5
    N = 5;
    mls_orden = '5';
    case 6%6
    N = 6;
    mls_orden = '6';
    case 7%7
    N = 7;
    mls_orden = '7';
    case 8%8
    N = 8;
    mls_orden = '8';
    case 9%9
    N = 9;
    mls_orden = '9';
    case 10%10
    N = 10;
    mls_orden = '10';
    case 11%22
    N = 11;
    mls_orden = '11';
    case 12%12A
    N = 12;
    mls_orden = '12A';
    case 13%12B
    N = 12;
    mls_orden = '12B';
    case 14%13
    N = 13;
    mls_orden = '13';
    case 15%14A
    N = 14;
    mls_orden = '14A';
    case 16%14B
    N = 14;
    mls_orden = '14B';
    case 17%15A
    N = 15;
    mls_orden = '15A';
    case 18%15B
    N = 15;
    mls_orden = '15B';
    case 19%16
    N = 16;
    mls_orden = '16';
    case 20%17A
    N = 17;
    mls_orden = '17A';
    case 21%17B
    N = 17;
    mls_orden = '17B';
    case 22 %18
    N = 18;
    mls_orden = '18';
    case 23%19
    N = 19;
    mls_orden = '19';
    case 24%20
    N = 20;
    mls_orden = '20';
    case 25%21
    N = 21;
    mls_orden = '21';
    case 26%22
    N = 22;
    mls_orden = '22';
    case 27%23
    N = 23;
    mls_orden = '23';
    case 28%24
    N = 24;
    mls_orden = '24';
end

if seleccion ~=1
    save('app_data/current.mat','-v6','mls_orden','-append');
    load('app_data/settings.mat','SampleRate')
    duracion = round(((2^N - 1)/SampleRate)*100)/100;
    duracion_text = num2str(duracion);
    texto =  strcat(duracion_text,' Segundos');
    set(handles.MLS_duracion,'String',texto);
    set(handles.MLS_duracion_string,'Visible','On');
    
    [angle_mls,repet_mls,duracion] = repeticiones_mls(N);
    mls_duracion = duracion+10;
    save('app_data/current.mat','-v6','mls_duracion','-append')
    save('app_data/current.mat','-v6','angle_mls','-append')
    save('app_data/current.mat','-v6','repet_mls','-append')
    set(handles.repeticiones,'String', repet_mls)
    set(handles.angulo,'String',angle_mls)
    set(handles.duracion,'String',duracion)
end
% Hints: contents = cellstr(get(hObject,'String')) returns MLS_orden contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MLS_orden


% --- Executes during object creation, after setting all properties.
function MLS_orden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLS_orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MLS_amplitud_Callback(hObject, eventdata, handles)
% hObject    handle to MLS_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MLS_amplitud as text
%        str2double(get(hObject,'String')) returns contents of MLS_amplitud as a double


% --- Executes during object creation, after setting all properties.
function MLS_amplitud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLS_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_f1_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_f1 as text
%        str2double(get(hObject,'String')) returns contents of sweep_f1 as a double


% --- Executes during object creation, after setting all properties.
function sweep_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_f2_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_f2 as text
%        str2double(get(hObject,'String')) returns contents of sweep_f2 as a double


% --- Executes during object creation, after setting all properties.
function sweep_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_duration_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_duracion as text
%        str2double(get(hObject,'String')) returns contents of sweep_duracion as a double


% --- Executes during object creation, after setting all properties.
function sweep_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_amplitud_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_amplitud as text
%        str2double(get(hObject,'String')) returns contents of sweep_amplitud as a double


% --- Executes during object creation, after setting all properties.
function sweep_amplitud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sweep_silencio_Callback(hObject, eventdata, handles)
% hObject    handle to sweep_silencio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweep_silencio as text
%        str2double(get(hObject,'String')) returns contents of sweep_silencio as a double


% --- Executes during object creation, after setting all properties.
function sweep_silencio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweep_silencio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MLS_repeticiones_Callback(hObject, eventdata, handles)
% hObject    handle to MLS_repeticiones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MLS_repeticiones as text
%        str2double(get(hObject,'String')) returns contents of MLS_repeticiones as a double


% --- Executes during object creation, after setting all properties.
function MLS_repeticiones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLS_repeticiones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to MLS_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MLS_amplitud as text
%        str2double(get(hObject,'String')) returns contents of MLS_amplitud as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLS_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MLS_orden.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to MLS_orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MLS_orden contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MLS_orden


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MLS_orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MLS_OK.
function MLS_OK_Callback(hObject, eventdata, handles)
% hObject    handle to MLS_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA

%%%Cartel de espera...

myicon(:,:,1) = [0 1; 0 1];
myicon(:,:,2) = [.8 1; 0 .3];
myicon(:,:,3) = [.3 0; .9 .5];
h=msgbox('Por favor espere...','Trabajando','custom',myicon);

%Variables de Entrada
MLSamplitud = str2double(get(handles.MLS_amplitud,'String'));
save('app_data/current.mat','-v6','MLSamplitud','-append');
load('app_data/current.mat','mls_orden')
load('app_data/current.mat','repet_mls')

%Generación de la secuencia
mls = GenerateMLS(mls_orden,repet_mls,MLSamplitud);

%Guardado como audio
secuence2audio(mls)
close(h)
y = msgbox('Operación completa','Listo!','custom',myicon);
uiwait(y)
close


% --- Executes when MLS_panel is resized.
function MLS_panel_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to MLS_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sweep_ok.
function sweep_ok_Callback(hObject, eventdata, handles)
%%%Cartel de espera...

myicon(:,:,1) = [0 1; 0 1];
myicon(:,:,2) = [.8 1; 0 .3];
myicon(:,:,3) = [.3 0; .9 .5];
h=msgbox('Por favor espere...','Trabajando','custom',myicon);


load('app_data/settings.mat','SampleRate');
sweep_duracion=str2double(get(handles.sweep_duracion,'String'));
sweep_f1=str2double(get(handles.sweep_f1,'String'));
sweep_f2=str2double(get(handles.sweep_f2,'String'));
sweep_silencio=str2double(get(handles.sweep_silencio,'String'));
sweep_amplitud = str2double(get(handles.sweep_amplitud,'String'));

save('app_data/current.mat','sweep_duracion','sweep_f1','sweep_f2','sweep_silencio','sweep_amplitud','-append');

[sweep ,inversefiltersweepfft] = synthSweep(sweep_duracion,SampleRate,sweep_f1,sweep_f2,sweep_amplitud,sweep_silencio);
save('app_data/current.mat','inversefiltersweepfft','-append');
secuence2audio(sweep)
close(h)

y = msgbox('Operación completa. Se ha guardado una copia de seguridad del filtro inverso del sweep en la carpeta de Audio','Listo!','custom',myicon);
uiwait(y)
close



function repeticiones_Callback(hObject, eventdata, handles)
% hObject    handle to repeticiones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of repeticiones as text
%        str2double(get(hObject,'String')) returns contents of repeticiones as a double


% --- Executes during object creation, after setting all properties.
function repeticiones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to repeticiones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function angulo_Callback(hObject, eventdata, handles)
% hObject    handle to angulo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angulo as text
%        str2double(get(hObject,'String')) returns contents of angulo as a double


% --- Executes during object creation, after setting all properties.
function angulo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angulo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function duracion_Callback(hObject, eventdata, handles)
% hObject    handle to duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duracion as text
%        str2double(get(hObject,'String')) returns contents of duracion as a double


% --- Executes during object creation, after setting all properties.
function duracion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
