function varargout = conf_procesamiento(varargin)
% CONF_PROCESAMIENTO MATLAB code for conf_procesamiento.fig
%      CONF_PROCESAMIENTO, by itself, creates a new CONF_PROCESAMIENTO or raises the existing
%      singleton*.
%
%      H = CONF_PROCESAMIENTO returns the handle to a new CONF_PROCESAMIENTO or the handle to
%      the existing singleton*.
%
%      CONF_PROCESAMIENTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONF_PROCESAMIENTO.M with the given input arguments.
%
%      CONF_PROCESAMIENTO('Property','Value',...) creates a new CONF_PROCESAMIENTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before conf_procesamiento_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to conf_procesamiento_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help conf_procesamiento

% Last Modified by GUIDE v2.5 14-Jun-2015 19:21:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @conf_procesamiento_OpeningFcn, ...
                   'gui_OutputFcn',  @conf_procesamiento_OutputFcn, ...
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


% --- Executes just before conf_procesamiento is made visible.
function conf_procesamiento_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to conf_procesamiento (see VARARGIN)
 bg_image = imread('app_data/icons/muestra_dimensiones.bmp');
% set(handles.muestra, 'CData', bg_image);
 axes(handles.muestra)
  imshow(bg_image);
set(handles.muestra,'box','on')
set(handles.muestra,'MinorGridLineStyle','none')
set(handles.muestra,'NextPlot','replacechildren')
set(handles.muestra,'XTick',[])
set(handles.muestra,'YTick',[])


% Choose default command line output for conf_procesamiento
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes conf_procesamiento wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = conf_procesamiento_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

escala = get(handles.medicion_escala,'Value');
if escala ==1
    escala = str2double(get(handles.f_escala,'String'));
else
    escala = 1;
end


temp = [str2double(get(handles.temp_t1,'String'))...
       str2double(get(handles.temp_t2,'String'))...
       str2double(get(handles.temp_t3,'String'))...
       str2double(get(handles.temp_t4,'String'))...
       str2double(get(handles.temp_t0,'String'))];

hum = [str2double(get(handles.hum_t1,'String'))...
       str2double(get(handles.hum_t2,'String'))...
       str2double(get(handles.hum_t3,'String'))...
       str2double(get(handles.hum_t4,'String'))...
       str2double(get(handles.hum_t0,'String'))];
    
abs_aire = get(handles.abs_aire,'Value');

octavas = get(handles.octavas_1,'Value');
if octavas == 0
    octavas = 3;
end

vol_camara = str2double(get(handles.vol,'String'));
sup_muestra = pi*str2double(get(handles.diam,'String'));
hmax_muestra = str2double(get(handles.hmax,'String'));

save('app_data/settings.mat','-v6','escala','-append');
save('app_data/current.mat','-v6','octavas','-append');
save('app_data/current.mat','-v6','temp','-append');
save('app_data/current.mat','-v6','abs_aire','-append');
save('app_data/current.mat','-v6','hum','-append');
save('app_data/current.mat','-v6','vol_camara','-append');
save('app_data/current.mat','-v6','hmax_muestra','-append');
save('app_data/current.mat','-v6','sup_muestra','-append');
procesar_ok = 1;
save('app_data/current.mat','-v6','procesar_ok','-append');
close
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function temp_t1_Callback(hObject, eventdata, handles)
% hObject    handle to temp_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_t1 as text
%        str2double(get(hObject,'String')) returns contents of temp_t1 as a double


% --- Executes during object creation, after setting all properties.
function temp_t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hum_t1_Callback(hObject, eventdata, handles)
% hObject    handle to humeeee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of humeeee as text
%        str2double(get(hObject,'String')) returns contents of humeeee as a double

% --- Executes during object creation, after setting all properties.
function hum_t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function humeeee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to humeeee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f_escala_Callback(hObject, eventdata, handles)
% hObject    handle to f_escala (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        escala = str2double(get(handles.f_escala,'String'));
        save('app_data/settings.mat','-v6','escala','-append')
        octavas = get(handles.octavas_1,'Value');
        if octavas == 0
            octavas = 3;
            max_freq = 20e3;
            freq_real = max_freq/escala;
            disp = strcat('Dado el factor de escala de ', ' ',num2str(escala),' , el procesamiento de los resultados entregará información útil hasta la banda de tercios de octava equivalente a ',num2str(freq_real),' Hz');
            set(handles.mensaje_medicion,'String',disp);
        else
            max_freq = 16e3;
            freq_real = max_freq/escala;
            disp = strcat('Dado el factor de escala de ',' ', num2str(escala),' , el procesamiento de los resultados entregará información útil hasta la banda de octava equivalente a ',num2str(freq_real),' Hz');
            set(handles.mensaje_medicion,'String',disp);
        end



% Hints: get(hObject,'String') returns contents of f_escala as text
%        str2double(get(hObject,'String')) returns contents of f_escala as a double


% --- Executes during object creation, after setting all properties.
function f_escala_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f_escala (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in abs_aire.
function abs_aire_Callback(hObject, eventdata, handles)
% hObject    handle to abs_aire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of abs_aire


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)

escala = get(handles.medicion_escala,'Value');
if escala ==1
        set(handles.f_escala,'Enable','On'); 
        escala = str2double(get(handles.f_escala,'String'));
        save('app_data/settings.mat','-v6','escala','-append')
        octavas = get(handles.octavas_1,'Value');
        if octavas == 0
            octavas = 3;
            max_freq = 20e3;
            freq_real = max_freq/escala;
            disp = strcat('Dado el factor de escala de ', num2str(escala),' , el procesamiento de los resultados entregará información útil hasta la banda de tercios de octava equivalente a ',num2str(freq_real),' Hz');
            set(handles.mensaje_medicion,'String',disp);
        else
            max_freq = 16e3;
            freq_real = max_freq/escala;
            disp = strcat('Dado el factor de escala de ', num2str(escala),' , el procesamiento de los resultados entregará información útil hasta la banda de octava equivalente a ',num2str(freq_real),' Hz');
            set(handles.mensaje_medicion,'String',disp);
        end
else
        set(handles.f_escala,'Enable','Off'); 
        escala = 1;
        save('app_data/settings.mat','-v6','escala','-append')
        set(handles.mensaje_medicion,'String',' ');
          octavas = get(handles.octavas_1,'Value');
        if octavas == 0
            octavas = 3;
            save('app_data/current.mat','-v6','octavas','-append');
        else
            save('app_data/current.mat','-v6','octavas','-append');
        end 
end




% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)

escala = get(handles.medicion_escala,'Value');
if escala ==1
        octavas = get(handles.octavas_1,'Value');
        escala = str2double(get(handles.f_escala,'String'));
        if octavas == 0
            octavas = 3;
            save('app_data/current.mat','-v6','octavas','-append');
            max_freq = 20e3;
            freq_real = max_freq/escala;
            disp = strcat('Dado el factor de escala de ', num2str(escala),' , el procesamiento de los resultados entregará información útil hasta la banda de tercios de octava equivalente a ',num2str(freq_real),' Hz');
            set(handles.mensaje_medicion,'String',disp);
        else
            save('app_data/current.mat','-v6','octavas','-append');
            max_freq = 16e3;
            freq_real = max_freq/escala;
            disp = strcat('Dado el factor de escala de ', num2str(escala),' , el procesamiento de los resultados entregará información útil hasta la banda de octava equivalente a ',num2str(freq_real),' Hz');
            set(handles.mensaje_medicion,'String',disp);
        end
else
          escala = 1;
          set(handles.mensaje_medicion,'String',' ');
          octavas = get(handles.octavas_1,'Value');
        if octavas == 0
            octavas = 3;
            save('app_data/current.mat','-v6','octavas','-append');
        else
            save('app_data/current.mat','-v6','octavas','-append');
        end 
end

% escala = str2double(get(handles.f_escala,'String'));
% save('app_data/settings.mat','-v6','escala','-append');

% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



function diam_Callback(hObject, eventdata, handles)
% hObject    handle to diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diam as text
%        str2double(get(hObject,'String')) returns contents of diam as a double


% --- Executes during object creation, after setting all properties.
function diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hmax_Callback(hObject, eventdata, handles)
% hObject    handle to hmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hmax as text
%        str2double(get(hObject,'String')) returns contents of hmax as a double


% --- Executes during object creation, after setting all properties.
function hmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vol_Callback(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vol as text
%        str2double(get(hObject,'String')) returns contents of vol as a double


% --- Executes during object creation, after setting all properties.
function vol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vol as text
%        str2double(get(hObject,'String')) returns contents of vol as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_t2_Callback(hObject, eventdata, handles)
% hObject    handle to temp_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_t2 as text
%        str2double(get(hObject,'String')) returns contents of temp_t2 as a double


% --- Executes during object creation, after setting all properties.
function temp_t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_t3_Callback(hObject, eventdata, handles)
% hObject    handle to temp_t3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_t3 as text
%        str2double(get(hObject,'String')) returns contents of temp_t3 as a double


% --- Executes during object creation, after setting all properties.
function temp_t3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_t3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_t4_Callback(hObject, eventdata, handles)
% hObject    handle to temp_t4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_t4 as text
%        str2double(get(hObject,'String')) returns contents of temp_t4 as a double


% --- Executes during object creation, after setting all properties.
function temp_t4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_t4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hum_t2_Callback(hObject, eventdata, handles)
% hObject    handle to hum_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hum_t2 as text
%        str2double(get(hObject,'String')) returns contents of hum_t2 as a double


% --- Executes during object creation, after setting all properties.
function hum_t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hum_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hum_t3_Callback(hObject, eventdata, handles)
% hObject    handle to hum_t3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hum_t3 as text
%        str2double(get(hObject,'String')) returns contents of hum_t3 as a double


% --- Executes during object creation, after setting all properties.
function hum_t3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hum_t3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hum_t4_Callback(hObject, eventdata, handles)
% hObject    handle to hum_t4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hum_t4 as text
%        str2double(get(hObject,'String')) returns contents of hum_t4 as a double


% --- Executes during object creation, after setting all properties.
function hum_t4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hum_t4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_t0_Callback(hObject, eventdata, handles)
% hObject    handle to temp_t0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_t0 as text
%        str2double(get(hObject,'String')) returns contents of temp_t0 as a double


% --- Executes during object creation, after setting all properties.
function temp_t0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_t0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hum_t0_Callback(hObject, eventdata, handles)
% hObject    handle to hum_t0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hum_t0 as text
%        str2double(get(hObject,'String')) returns contents of hum_t0 as a double


% --- Executes during object creation, after setting all properties.
function hum_t0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hum_t0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
