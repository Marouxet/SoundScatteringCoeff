function varargout = question_medicion(varargin)
% QUESTION_MEDICION MATLAB code for question_medicion.fig
%      QUESTION_MEDICION, by itself, creates a new QUESTION_MEDICION or raises the existing
%      singleton*.
%
%      H = QUESTION_MEDICION returns the handle to a new QUESTION_MEDICION or the handle to
%      the existing singleton*.
%
%      QUESTION_MEDICION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUESTION_MEDICION.M with the given input arguments.
%
%      QUESTION_MEDICION('Property','Value',...) creates a new QUESTION_MEDICION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before question_medicion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to question_medicion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help question_medicion

% Last Modified by GUIDE v2.5 24-Jun-2015 08:03:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @question_medicion_OpeningFcn, ...
                   'gui_OutputFcn',  @question_medicion_OutputFcn, ...
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


% --- Executes just before question_medicion is made visible.
function question_medicion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to question_medicion (see VARARGIN)
a = 0;
handles.a = 0;
guidata(hObject,handles)
% Choose default command line output for question_medicion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes question_medicion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = question_medicion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bot_nuevo.
function bot_nuevo_Callback(hObject, eventdata, handles)
previous_pointer = 1;
save('app_data/current.mat','previous_pointer','-append');
a = 1;
handles.a = a;
guidata(hObject,handles)
close
% hObject    handle to bot_nuevo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bot_seguir.
function bot_seguir_Callback(hObject, eventdata, handles)
load('app_data/current.mat','previous_pointer');
if previous_pointer ~= 1
previous_pointer = previous_pointer -1;
end
save('app_data/current.mat','previous_pointer','-append');
a = 1;
handles.a = a;
guidata(hObject,handles)
close


function num_Callback(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num as text
%        str2double(get(hObject,'String')) returns contents of num as a double


% --- Executes during object creation, after setting all properties.
function num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
load('app_data/current.mat','previous_pointer')
set(hObject,'String',previous_pointer);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bot_num.
function bot_num_Callback(hObject, eventdata, handles)
valor = get(handles.num,'String');
previous_pointer = str2double(valor);
save('app_data/current.mat','previous_pointer','-append');
a = 1;
handles.a = a;
guidata(hObject,handles)
close


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = handles.a;
if a ==0
    global flag_rec
    flag_rec =0;
end
% Hint: delete(hObject) closes the figure
delete(hObject);
