function varargout = mostrar_estructura_medicion(varargin)
% MOSTRAR_ESTRUCTURA_MEDICION MATLAB code for mostrar_estructura_medicion.fig
%      MOSTRAR_ESTRUCTURA_MEDICION, by itself, creates a new MOSTRAR_ESTRUCTURA_MEDICION or raises the existing
%      singleton*.
%
%      H = MOSTRAR_ESTRUCTURA_MEDICION returns the handle to a new MOSTRAR_ESTRUCTURA_MEDICION or the handle to
%      the existing singleton*.
%
%      MOSTRAR_ESTRUCTURA_MEDICION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOSTRAR_ESTRUCTURA_MEDICION.M with the given input arguments.
%
%      MOSTRAR_ESTRUCTURA_MEDICION('Property','Value',...) creates a new MOSTRAR_ESTRUCTURA_MEDICION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mostrar_estructura_medicion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mostrar_estructura_medicion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mostrar_estructura_medicion

% Last Modified by GUIDE v2.5 27-Oct-2014 15:38:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mostrar_estructura_medicion_OpeningFcn, ...
                   'gui_OutputFcn',  @mostrar_estructura_medicion_OutputFcn, ...
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


% --- Executes just before mostrar_estructura_medicion is made visible.
function mostrar_estructura_medicion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mostrar_estructura_medicion (see VARARGIN)

% Choose default command line output for mostrar_estructura_medicion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mostrar_estructura_medicion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mostrar_estructura_medicion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
load('app_data/current.mat','orden');

set(hObject,'Data',orden);

% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
