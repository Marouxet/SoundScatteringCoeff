function varargout = resultados(varargin)
% RESULTADOS MATLAB code for resultados.fig
%      RESULTADOS, by itself, creates a new RESULTADOS or raises the existing
%      singleton*.
%
%      H = RESULTADOS returns the handle to a new RESULTADOS or the handle to
%      the existing singleton*.
%
%      RESULTADOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTADOS.M with the given input arguments.
%
%      RESULTADOS('Property','Value',...) creates a new RESULTADOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resultados_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resultados_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resultados

% Last Modified by GUIDE v2.5 26-Oct-2015 23:49:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resultados_OpeningFcn, ...
                   'gui_OutputFcn',  @resultados_OutputFcn, ...
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


% --- Executes just before resultados is made visible.
function resultados_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resultados (see VARARGIN)
load('app_data\current.mat','file_name');
load('app_data/current.mat','octavas');
load('app_data/settings.mat','escala');
load('app_data/current.mat','nombres_sch');
handles.nombres_sch = nombres_sch;
handles.escala = escala;
handles.octavas = octavas;

if octavas ==1
       load('app_data/filtros.mat','fc_octavas');
    handles.freq = fc_octavas./handles.escala;
elseif octavas ==3
       load('app_data/filtros.mat','fc_tercios');
    handles.freq = fc_tercios./handles.escala;
end
load(file_name);
handles.Resultados = Resultados;
indice = 1:length(Resultados);
set(handles.graficos_seleccion, 'String',indice);
handles.seleccion = 1;

% Choose default command line output for resultados
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resultados wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = resultados_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in graficos_seleccion.
function graficos_seleccion_Callback(hObject, eventdata, handles)
% hObject    handle to graficos_seleccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coeficientes = handles.seleccion;

    freq_ini = find(handles.freq>100,1)-1;

    if handles.octavas ==3;
        freq_fin = freq_ini+17;
    else
        freq_fin = freq_ini+6;
    end
    
if coeficientes == 1;
    Resultados = handles.Resultados{get(hObject, 'Value')};
    axes(handles.grafico_resultados)
    ylim([0 1])
    xlim([100 5000])
    cla
    semilogx(handles.freq(freq_ini:freq_fin),Resultados(14,freq_ini:freq_fin),'b--o')
    hold on
    semilogx(handles.freq(freq_ini:freq_fin),Resultados(15,freq_ini:freq_fin),'r-.x')
    semilogx(handles.freq(freq_ini:freq_fin),Resultados(16,freq_ini:freq_fin),'g-h')
    semilogx(handles.freq(freq_ini:freq_fin),Resultados(17,freq_ini:freq_fin),'m--p')
    set(handles.grafico_resultados,'XTick',[125 250 500 1000 2000 4000] )
    legend('Coeficiente de Absorción','Coeficiente de Absorción especular', 'Coeficiente de Scattering', 'Scattering de la mesa giratoria')
    
elseif coeficientes ==2

   a2 = length(get(hObject, 'String')); 
   a = get(hObject, 'Value'); 
    
     if a ==a2
     b = get(handles.frecuencia_seleccion,'Value');

  sch = 0; %Solo porque da error sino
  load(handles.nombres_sch{b}{:});
  
  %Cálculo de vector temporal para gráficos
  largo = 0;
  fs = 4110;
  for i = 1:length(sch)
      if largo <length(sch{i})
          largo = length(sch{i});
      end
  end
  time = 1:largo;
  time = time/fs;
    cla
      for i = 1:a-1;
      plot(time(1:length(sch{4*(i-1)+1})),sch{4*(i-1)+1}-max(sch{4*(i-1)+1}),'b')
      plot(time(1:length(sch{4*(i-1)+2})),sch{4*(i-1)+2}-max(sch{4*(i-1)+2}),'r')
      plot(time(1:length(sch{4*(i-1)+3})),sch{4*(i-1)+3}-max(sch{4*(i-1)+3}),'g')
      plot(time(1:length(sch{4*(i-1)+4})),sch{4*(i-1)+4}-max(sch{4*(i-1)+4}),'m')
      hold on
      end
      xlim([0 largo/fs])
      ylim([-60 0])
   %   ticks = 1:fix(largo/44110);
   %   set(handles.grafico_resultados,'XScale','linear','XTick',ticks)
      legend('Sin Muestra - Estático','Sin Muestra - Rotando', 'Con Muestra - Estático', 'Con Muestra - Rotando') 
    
     else
        
  b = get(handles.frecuencia_seleccion,'Value');
  sch = 0; %Solo porque da error sino
  load(handles.nombres_sch{b}{:});
  
  %Cálculo de vector temporal para gráficos
  largo = 0;
  fs = 4110;
  for i = 1:length(sch)
      if largo <length(sch{i})
          largo = length(sch{i});
      end
  end
  time = 1:largo;
  time = time/fs;
  
  a = get(hObject, 'Value'); 
  axes(handles.grafico_resultados)
  cla
  plot(time(1:length(sch{4*(a-1)+1})),sch{4*(a-1)+1}-max(sch{4*(a-1)+1}),'b')
  hold on
  plot(time(1:length(sch{4*(a-1)+2})),sch{4*(a-1)+2}-max(sch{4*(a-1)+2}),'r')
  plot(time(1:length(sch{4*(a-1)+3})),sch{4*(a-1)+3}-max(sch{4*(a-1)+3}),'g')
  plot(time(1:length(sch{4*(a-1)+4})),sch{4*(a-1)+4}-max(sch{4*(a-1)+4}),'m')
  xlim([0 largo/fs])
  ylim([-60 0])
%  ticks = 1:fix(largo/44110);
%  set(handles.grafico_resultados,'XScale','linear','XTick',ticks)
  legend('Sin Muestra - Estático','Sin Muestra - Rotando', 'Con Muestra - Estático', 'Con Muestra - Rotando')
 end

end
% Hints: contents = cellstr(get(hObject,'String')) returns graficos_seleccion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from graficos_seleccion


% --- Executes during object creation, after setting all properties.
function graficos_seleccion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graficos_seleccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ver_coeficientes.
function ver_coeficientes_Callback(hObject, eventdata, handles)
% hObject    handle to ver_coeficientes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor = get(hObject, 'Value');
if valor == 1;
    set(handles.frecuencia_seleccion, 'Enable', 'Off')
    set(handles.ver_decay, 'Value', 0)
    set(handles.ver_tr, 'Value',0)
    handles.seleccion = 1;
    guidata(hObject, handles);
    
    if handles.octavas ==1
       load('app_data/filtros.mat','fc_octavas');
    handles.freq = fc_octavas./handles.escala;
    elseif handles.octavas ==3
       load('app_data/filtros.mat','fc_tercios');
    handles.freq = fc_tercios./handles.escala;
    end
load('app_data\current.mat','file_name');
load(file_name);
handles.Resultados = Resultados;
indice = 1:length(Resultados);
set(handles.graficos_seleccion, 'Value', 1);
set(handles.graficos_seleccion, 'String',indice);


axis(handles.grafico_resultados)
cla
set(handles.grafico_resultados, 'XScale','log')
set(handles.grafico_resultados,'XTickMode', 'Manual')
set(handles.grafico_resultados,'XTick',[])
else
    set(hObject,'Value',1)
    
end
% Hint: get(hObject,'Value') returns toggle state of ver_coeficientes


% --- Executes on button press in ver_decay.
function ver_decay_Callback(hObject, eventdata, handles)
% hObject    handle to ver_decay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor = get(hObject, 'Value');
if valor == 1;
    set(handles.frecuencia_seleccion, 'Enable', 'On')
    set(handles.ver_coeficientes, 'Value', 0)
    set(handles.ver_tr, 'Value',0)
    
    handles.seleccion = 2;
    guidata(hObject, handles);
       
    
     freq_ini = find(handles.freq>100,1)-1;

    if handles.octavas ==3;
        freq_fin = freq_ini+17;
    else
        freq_fin = freq_ini+6;
    end
    valor = handles.freq(freq_ini:freq_fin);
    

set(handles.frecuencia_seleccion, 'String',valor);
set(handles.frecuencia_seleccion, 'Value', 1);     
    
axis(handles.grafico_resultados)
cla
set(handles.grafico_resultados, 'XScale','linear')

set(handles.grafico_resultados,'XTickMode', 'Auto')
set(handles.grafico_resultados,'XTick',[])
else
    set(hObject,'Value',1)
    set(handles.frecuencia_seleccion, 'Enable', 'Off')
end
% Hint: get(hObject,'Value') returns toggle state of ver_decay


% --- Executes on button press in ver_tr.
function ver_tr_Callback(hObject, eventdata, handles)
% hObject    handle to ver_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor = get(hObject, 'Value');
if valor == 1;
    set(handles.ver_coeficientes, 'Value', 0)
    set(handles.ver_decay, 'Value',0)
    handles.seleccion = 3;
    guidata(hObject, handles);
else
    set(hObject,'Value',1)
end
% Hint: get(hObject,'Value') returns toggle state of ver_tr


% --- Executes during object creation, after setting all properties.
function ver_coeficientes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ver_coeficientes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in plot_zoom.
function plot_zoom_Callback(hObject, eventdata, handles)
% hObject    handle to plot_zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor = get(hObject, 'Value');
if valor ==1
    set(handles.plot_pan, 'Value', 0)
    zoom on
else
    zoom off
end

% --- Executes on button press in plot_pan.
function plot_pan_Callback(hObject, eventdata, handles)
% hObject    handle to plot_pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
valor = get(hObject, 'Value');
if valor ==1
    set(handles.plot_zoom, 'Value', 0)
    pan on
else
    pan off
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in frecuencia_seleccion.
function frecuencia_seleccion_Callback(hObject, eventdata, handles)
% hObject    handle to frecuencia_seleccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   a2 = length(get(handles.graficos_seleccion, 'String')); 
   a = get(handles.graficos_seleccion, 'Value'); 
    
     if a ==a2
     b = get(handles.frecuencia_seleccion,'Value');

       sch = 0; %Solo porque da error sino
  load(handles.nombres_sch{b}{:});
  
  %Cálculo de vector temporal para gráficos
  largo = 0;
  fs = 4110;
  for i = 1:length(sch)
      if largo <length(sch{i})
          largo = length(sch{i});
      end
  end
  time = 1:largo;
  time = time/fs;
cla
      for i = 1:a-1;
      plot(time(1:length(sch{4*(i-1)+1})),sch{4*(i-1)+1}-max(sch{4*(i-1)+1}),'b')
      plot(time(1:length(sch{4*(i-1)+2})),sch{4*(i-1)+2}-max(sch{4*(i-1)+2}),'r')
      plot(time(1:length(sch{4*(i-1)+3})),sch{4*(i-1)+3}-max(sch{4*(i-1)+3}),'g')
      plot(time(1:length(sch{4*(i-1)+4})),sch{4*(i-1)+4}-max(sch{4*(i-1)+4}),'m')
      hold on
      end
      xlim([0 largo/fs])
      ylim([-60 0])
   %   ticks = 1:fix(largo/44110);
   %   set(handles.grafico_resultados,'XScale','linear','XTick',ticks)
      legend('Sin Muestra - Estático','Sin Muestra - Rotando', 'Con Muestra - Estático', 'Con Muestra - Rotando') 
    
     else
        
  b = get(handles.frecuencia_seleccion,'Value');
  sch = 0; %Solo porque da error sino
  load(handles.nombres_sch{b}{:});
  
  %Cálculo de vector temporal para gráficos
  largo = 0;
  fs = 4110;
  for i = 1:length(sch)
      if largo <length(sch{i})
          largo = length(sch{i});
      end
  end
  time = 1:largo;
  time = time/fs;
  
  a = get(handles.graficos_seleccion, 'Value'); 
  axes(handles.grafico_resultados)
  cla
  plot(time(1:length(sch{4*(a-1)+1})),sch{4*(a-1)+1}-max(sch{4*(a-1)+1}),'b')
  hold on
  plot(time(1:length(sch{4*(a-1)+2})),sch{4*(a-1)+2}-max(sch{4*(a-1)+2}),'r')
  plot(time(1:length(sch{4*(a-1)+3})),sch{4*(a-1)+3}-max(sch{4*(a-1)+3}),'g')
  plot(time(1:length(sch{4*(a-1)+4})),sch{4*(a-1)+4}-max(sch{4*(a-1)+4}),'m')
  xlim([0 largo/fs])
  ylim([-60 0])
 % ticks = 1:fix(largo/44110);
 % set(handles.grafico_resultados,'XScale','linear','XTick',ticks)
  legend('Sin Muestra - Estático','Sin Muestra - Rotando', 'Con Muestra - Estático', 'Con Muestra - Rotando')
        end


% Hints: contents = cellstr(get(hObject,'String')) returns frecuencia_seleccion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frecuencia_seleccion


% --- Executes during object creation, after setting all properties.
function frecuencia_seleccion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frecuencia_seleccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
