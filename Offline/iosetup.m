function varargout = iosetup(varargin)
% IOSETUP MATLAB code for iosetup.fig
%      IOSETUP, by itself, creates a new IOSETUP or raises the existing
%      singleton*.
%
%      H = IOSETUP returns the handle to a new IOSETUP or the handle to
%      the existing singleton*.
%
%      IOSETUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IOSETUP.M with the given input arguments.
%
%      IOSETUP('Property','Value',...) creates a new IOSETUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iosetup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iosetup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iosetup

% Last Modified by GUIDE v2.5 04-Aug-2014 15:10:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iosetup_OpeningFcn, ...
                   'gui_OutputFcn',  @iosetup_OutputFcn, ...
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


% --- Executes just before iosetup is made visible.
function iosetup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iosetup (see VARARGIN)

% Choose default command line output for iosetup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes iosetup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = iosetup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in audiodevice.
function audiodevice_Callback(hObject, eventdata, handles)
seleccionado = get(hObject,'Value');
load('app_data/settings.mat','maxinp')
load('app_data/settings.mat','maxout')
set(handles.maxinput,'String',maxinp(seleccionado))
set(handles.maxout,'String',maxout(seleccionado))



% --- Executes during object creation, after setting all properties.
function audiodevice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to audiodevice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load('app_data/settings.mat','inputdevices')
set(hObject,'String',inputdevices)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function maxinput_CreateFcn(hObject, eventdata, handles)
%load('app_data/settings.mat','maxinp')
%set(hObject,'String',maxinp)



% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
ioconfig
close


% --- Executes when selected object is changed in fs.
function fs_SelectionChangeFcn(hObject, eventdata, handles)
ioconfig
% hObject    handle to the selected object in fs 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in buffer.
function buffer_Callback(hObject, eventdata, handles)
ioconfig
% hObject    handle to buffer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
ioconfig
% hObject    handle to Queue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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



function salida_grabacion_Callback(hObject, eventdata, handles)
% hObject    handle to salida_grabacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of salida_grabacion as text
%        str2double(get(hObject,'String')) returns contents of salida_grabacion as a double


% --- Executes during object creation, after setting all properties.
function salida_grabacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to salida_grabacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function salida_monitoreo_Callback(hObject, eventdata, handles)
% hObject    handle to salida_monitoreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of salida_monitoreo as text
%        str2double(get(hObject,'String')) returns contents of salida_monitoreo as a double


% --- Executes during object creation, after setting all properties.
function salida_monitoreo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to salida_monitoreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
