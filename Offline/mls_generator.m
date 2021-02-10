function varargout = mls_generator(varargin)
% MLS_GENERATOR M-file for mls_generator.fig
%      MLS_GENERATOR, by itself, creates a new MLS_GENERATOR or raises the existing
%      singleton*.
%
%      H = MLS_GENERATOR returns the handle to a new MLS_GENERATOR or the handle to
%      the existing singleton*.
%
%      MLS_GENERATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MLS_GENERATOR.M with the given input arguments.
%
%      MLS_GENERATOR('Property','Value',...) creates a new MLS_GENERATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mls_generator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mls_generator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mls_generator

% Last Modified by GUIDE v2.5 27-Apr-2014 12:30:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mls_generator_OpeningFcn, ...
                   'gui_OutputFcn',  @mls_generator_OutputFcn, ...
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


% --- Executes just before mls_generator is made visible.
function mls_generator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mls_generator (see VARARGIN)

% Choose default command line output for mls_generator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mls_generator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mls_generator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in mls_ok.
function mls_ok_Callback(hObject, eventdata, handles)
seleccion = get(handles.mls_orden,'Value'); %tomo el valor seleccionado en el Orden MLS
switch seleccion
    case 2
    N = 2;
    taps = [2 1];
    case 3
    N = 3;
    taps = [3 1];
    case 4
    N = 4;
    taps = [4 1];
    case 5
    N = 5;
    taps = [5 2];
    case 6
    N = 6;
    taps = [6 1];  
    case 7
    N = 7;
    taps = [7 1];
    case 8
    N = 8;
    taps = [8 6 5 1];
    case 9
    N = 9;
    taps = [9 4];
    case 10
    N = 10;
    taps = [10 7];
    case 11
    N = 11;
    taps = [11 2];
    case 12
    N = 12;
    taps = [12 11 10 2];
    case 13
    N = 12;
    taps = [12 7 4 3];
    case 14
    N = 13;
    taps = [13 4 3 1];
    case 15
    N = 13;
    taps = [13 12 11 9 6 5 2 1];
    case 16
    N = 14;
    taps = [14 13 12 2];
    case 17
    N = 14;
    taps = [14 12 11 1];
    case 18
    N = 14;
    taps = [14 12 10 9 7 5 3 1];
    case 19
    N = 15;
    taps = [15 14];
    case 20
    N = 15;
    taps = [15 11];
    case 21
    N = 15;
    taps = [15 8];
    case 22 
    N = 15;
    taps = [15 12 11 8 7 6 4 2];
    case 23
    N = 16;
    taps = [16 5 3 2];
    case 24
    N = 16;
    taps = [16 12 11 10 7 4 3 2];
    case 25
    N = 17;
    taps = [17 3];
    case 26
    N = 17;
    taps = [17 14 13 9];
    case 27
    N = 17;
    taps = [17 14 11 9 6 5];
    case 28
    N = 17;
    taps = [17 15 13 11 10 9 8 4 2 1];
    case 29
    N = 18;
    taps = [18 7];
    case 30
    N = 19;
    taps = [19 6 5 1];
    case 31
    N = 20;
    taps = [20 3];
    case 32
    N = 21;
    taps = [21 2];
    case 33
    N = 22;
    taps = [22 1];
    case 34
    N = 23;
    taps = [23 5];
    case 35
    N = 24;
    taps = [24 4 3 1];
end
mls = mls_gen( N,taps );
% [S, P1] = permutar( mls, N );
assignin('base','mls',mls)
% assignin('base','S',S)
% assignin('base','P1',P1)
%
% --- Executes on selection change in mls_orden.
function mls_orden_Callback(hObject, eventdata, handles)
% hObject    handle to mls_orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mls_orden contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mls_orden


% --- Executes during object creation, after setting all properties.
function mls_orden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mls_orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mls_amplitud_Callback(hObject, eventdata, handles)
% hObject    handle to mls_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mls_amplitud as text
%        str2double(get(hObject,'String')) returns contents of mls_amplitud as a double


% --- Executes during object creation, after setting all properties.
function mls_amplitud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mls_amplitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mls_nbits_Callback(hObject, eventdata, handles)
% hObject    handle to mls_nbits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mls_nbits as text
%        str2double(get(hObject,'String')) returns contents of mls_nbits as a double


% --- Executes during object creation, after setting all properties.
function mls_nbits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mls_nbits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
