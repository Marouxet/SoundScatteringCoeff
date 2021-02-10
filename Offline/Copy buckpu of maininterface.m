function varargout = maininterface(varargin)
% MAININTERFACE MATLAB code for maininterface.fig
%      MAININTERFACE, by itself, creates a new MAININTERFACE or raises the existing
%      singleton*.
%
%      H = MAININTERFACE returns the handle to a new MAININTERFACE or the handle to
%      the existing singleton*.
%
%      MAININTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAININTERFACE.M with the given input arguments.
%
%      MAININTERFACE('Property','Value',...) creates a new MAININTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maininterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maininterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maininterface

% Last Modified by GUIDE v2.5 05-Nov-2014 12:09:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maininterface_OpeningFcn, ...
                   'gui_OutputFcn',  @maininterface_OutputFcn, ...
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


% --- Executes just before maininterface is made visible.
function maininterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maininterface (see VARARGIN)

% Choose default command line output for maininterface
handles.output = hObject;
bg_image = imread('app_data/icons/up155.jpg');
set(handles.up, 'CData', bg_image);
bg_image = imread('app_data/icons/down155.jpg');
set(handles.down, 'CData', bg_image);


%Propiedades de gráficos
set(handles.ax_chan1,'Units','normalized');
set(handles.ax_chan2,'Units','normalized');
set(handles.ax_chan3,'Units','normalized');
set(handles.ax_chan4,'Units','normalized');
set(handles.ax_chan1,'Visible','Off');
set(handles.ax_chan2,'Visible','Off');
set(handles.ax_chan3,'Visible','Off');
set(handles.ax_chan4,'Visible','Off');
set(handles.panel_config_chan1,'Units','normalized');
set(handles.panel_config_chan2,'Units','normalized');
set(handles.panel_config_chan3,'Units','normalized');
set(handles.panel_config_chan4,'Units','normalized');
set(handles.panel_config_chan1,'Visible','Off');
set(handles.panel_config_chan2,'Visible','Off');
set(handles.panel_config_chan3,'Visible','Off');
set(handles.panel_config_chan4,'Visible','Off');
%set(handles.icon_record_chan1,'CData',bg_image)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes maininterface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = maininterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
out_config
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ax_chan1,'box','on')
set(handles.ax_chan1,'MinorGridLineStyle','none')
set(handles.ax_chan1,'NextPlot','replacechildren')
set(handles.ax_chan1,'XTick',[])
set(handles.ax_chan1,'YTick',[])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            VARIABLES ADENTRO DE LOS PANELES DE CADA    
%%%                            CANAL
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function c1_name_Callback(hObject, eventdata, handles)

function c1_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c2_name_Callback(hObject, eventdata, handles)

function c2_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c3_name_Callback(hObject, eventdata, handles)

function c3_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c4_name_Callback(hObject, eventdata, handles)

function c4_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c5_name_Callback(hObject, eventdata, handles)

function c5_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c6_name_Callback(hObject, eventdata, handles)

function c6_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c7_name_Callback(hObject, eventdata, handles)

function c7_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c8_name_Callback(hObject, eventdata, handles)

function c8_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function c1_canales_Callback(hObject, eventdata, handles)

function c1_canales_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c2_canales_Callback(hObject, eventdata, handles)

function c2_canales_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c3_canales_Callback(hObject, eventdata, handles)

function c3_canales_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c4_canales_Callback(hObject, eventdata, handles)

function c4_canales_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function icon_chan1_monitoreo_Callback(hObject, eventdata, handles)
canal = 1;
monitorear_canal;

% --- Executes on button press in icon_chan2_monitoreo.
function icon_chan2_monitoreo_Callback(hObject, eventdata, handles)
canal = 2;
monitorear_canal;

% --- Executes on button press in icon_chan3_monitoreo.
function icon_chan3_monitoreo_Callback(hObject, eventdata, handles)
canal = 3;
monitorear_canal;

% --- Executes on button press in icon_chan4_monitoreo.
function icon_chan4_monitoreo_Callback(hObject, eventdata, handles)
canal = 4;
monitorear_canal;




% --- Executes on button press in icon_chan7_monitoreo.
function icon_chan7_monitoreo_Callback(hObject, eventdata, handles)
canal = 7;
monitorear_canal;



function c7_futuro_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function c7_futuro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c7_futuro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c6_futuro_Callback(hObject, eventdata, handles)
% hObject    handle to c6_futuro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c6_futuro as text
%        str2double(get(hObject,'String')) returns contents of c6_futuro as a double


% --- Executes during object creation, after setting all properties.
function c6_futuro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c6_futuro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in icon_chan6_monitoreo.
function icon_chan6_monitoreo_Callback(hObject, eventdata, handles)
% hObject    handle to icon_chan6_monitoreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
canal = 6;
monitorear_canal;





% --- Executes on button press in icon_chan5_monitoreo.
function icon_chan5_monitoreo_Callback(hObject, eventdata, handles)
% hObject    handle to icon_chan5_monitoreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
canal = 5;
monitorear_canal;

function c1_futuro_Callback(hObject, eventdata, handles)

function c1_futuro_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c2_futuro_Callback(hObject, eventdata, handles)

function c2_futuro_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c3_futuro_Callback(hObject, eventdata, handles)

function c3_futuro_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c4_futuro_Callback(hObject, eventdata, handles)

function c4_futuro_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c5_futuro_Callback(hObject, eventdata, handles)

function c5_futuro_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on button press in icon_chan8_monitoreo.
function icon_chan8_monitoreo_Callback(hObject, eventdata, handles)
% hObject    handle to icon_chan8_monitoreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
canal = 8;
monitorear_canal;


function c8_futuro_Callback(hObject, eventdata, handles)
% hObject    handle to c8_futuro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c8_futuro as text
%        str2double(get(hObject,'String')) returns contents of c8_futuro as a double


% --- Executes during object creation, after setting all properties.
function c8_futuro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c8_futuro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                           MENÚ
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------
function m_generar_Callback(hObject, eventdata, handles)
% hObject    handle to m_generar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_generar_secuencia_Callback(hObject, eventdata, handles)

uiwait(generator)

load('app_data/current.mat','Nombre_signal');

map = audioread(Nombre_signal);

load('app_data/settings.mat','QueueDuration')
load('app_data/settings.mat','BufferSize');
load('app_data/settings.mat','sec_factor');
load('app_data/settings.mat','SampleRate');
latency = (QueueDuration * SampleRate + 2 * BufferSize) + sec_factor * SampleRate;  

xlimites = [1 length(map)+latency];
tiempo = 0:length(map)-1;
tiempo = tiempo./SampleRate;

max = fix((length(map)+latency -1)./SampleRate )/10;

transport = [1 2 3 4 5 6 7 8 9 10] * max;
transport = num2cell(transport);
 data = cell(1,11);
for i = 1:10
    data(i) = transport(i);
end
data(11) = '';
%transport = {num2cell(transport) '' '' };
save('app_data/current.mat','tiempo','-append')
%save('app_data/current.mat','file','-append')
save('app_data/current.mat','xlimites','-append')
save('app_data/current.mat','transport','-append')

%set(handles.uitable1,'Visible','On')
%set(handles.uitable1,'Data',data)
plot(handles.ax_chan0,map)
xlim(handles.ax_chan0,xlimites)




% --------------------------------------------------------------------
function m_dispositivos_Callback(hObject, eventdata, handles)
% hObject    handle to m_dispositivos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_dispositivos_configuracion_Callback(hObject, eventdata, handles)
 [inputdevices, maxinp, maxout] = inputhardware();
 save('app_data/settings.mat','inputdevices','-append')
 save('app_data/settings.mat','maxinp','-append')
 save('app_data/settings.mat','maxout','-append')
%iosetup
uiwait(configuracion_proyecto)
newchannelV2
set(handles.up,'Enable','On');
set(handles.down,'Enable','On');

% --------------------------------------------------------------------
function m_canales_Callback(hObject, eventdata, handles)
% hObject    handle to m_canales (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_canales_nuevo_Callback(hObject, eventdata, handles)
%newchannel
% hObject    handle to m_canales_nuevo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              TRANSPORT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function transport_rec_Callback(hObject, eventdata, handles)
axes(handles.axes25)
set(cla,'Visible','Off')
load('app_data/current.mat','angle');
load('app_data/settings.mat','intervalo_angular');  
load('app_data/current.mat','nmedicion')
load('app_data/current.mat','orden');
load('app_data/current.mat','logico_ordenado');
anterior = logico_ordenado(1,(1:3));
%chan5_plot = handles.ax_chan5;
    time = timer('BusyMode','drop','ExecutionMode','fixedSpacing','Period',1.5,'TimerFcn','ejec_timer(handles,buf_plot)','StartDelay',1);

for pointer = 1:max(nmedicion{end})  
    %%%%Timer para Plotear

    stop(time)
    delete(time)
    time = timer('BusyMode','drop','ExecutionMode','fixedSpacing','Period',1.5,'TimerFcn','ejec_timer(handles,buf_plot)','StartDelay',1);
    start(time)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GRAFICA Y
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VARIABLES%%%%%%%%%%%%%%%%%%%%%%%
    
    %Encuentro la medicion actual dentro de las variables
    i = 1;
    pos_actual = find(nmedicion{i}==pointer,1);
    while(isempty(pos_actual))
    i = i+1;
    pos_actual = find(nmedicion{i}==pointer,1);
    end
    fila_orden_actual= i;

    %Chequeo si hay algún cambio en las posiciones
    actual = logico_ordenado(fila_orden_actual,(1:3));
    cambio = find(actual - anterior ~= 0);
    
    if isempty(cambio)
        
    elseif cambio ==1;
            uiwait(msgbox('Por favor, cambie la muestra','Cambio de medición')); 
    elseif cambio ==2;
            uiwait(msgbox('Por favor, cambie la fuente','Cambio de medición'));
    elseif cambio ==3;
            uiwait(msgbox('Por favor, cambie los microfonos','Cambio de medición'));
    elseif cambio ==4;
            
    end
    %Defino qué muestra, fuente, mics y mesa tengo para la actual medicion
        
    muestra_actual =logico_ordenado(fila_orden_actual,1);   
    fuente_actual = logico_ordenado(fila_orden_actual,2);
    mics_actual = logico_ordenado(fila_orden_actual,3);
    gira_actual = logico_ordenado(fila_orden_actual,4);

    anterior = actual;
    
    %Angulos
    if length(angle{fila_orden_actual}) == 1;
       
        axes(handles.axes25)
        set(cla,'Visible','Off')
        angulo_text = 'Sin Girar';
        
    else
        angulo_text = angle{i}(pos_actual);
        angulo = angulo_text*pi/180;
        axes(handles.axes25)
        set(cla,'Visible','On');
        compass(1*exp(1i*angulo));

    end 
    
    %Escribo en los textos las condiciones actuales
    set(handles.n_pointer,'String',pointer);
    set(handles.mics_actual,'String',mics_actual);
    set(handles.fuente_actual,'String',fuente_actual);
    set(handles.disp_angulo,'String',angulo_text);
    
    if muestra_actual == 1;
            set(handles.muestra_actual,'String','Con Muestra');
    else
            set(handles.muestra_actual,'String','Sin Muestra');
    end
    drawnow

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %grabación!
    buf_plot = medicionV2(pointer, handles);
    
end







function transport_play_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
%  Player = createPlayerV2(1);
%  Reader = createReaderV2();


load('app_data/settings.mat','BufferSize')
load('app_data/settings.mat','QueueDuration')
load('app_data/settings.mat','SampleRate');
load('app_data/settings.mat','sec_factor');
load('app_data/settings.mat','objectName');
%load('app_data/current.mat','flag_rec')


silencio = zeros(BufferSize,1);
latency = (QueueDuration * SampleRate + 2 * BufferSize)/SampleRate;
flag_rec = 1;
i = 0;
while flag_rec == 1;

%         if ~isDone(Reader)
%                 play = [step(Reader) silencio];
%                 step(Player, play);
%                 tic;
%         end
% 
%     a = get(handles.transport_stop,'Value');
%     if a ==1
%     flag_rec = 0;
%     end
i = i + 1 
flag_rec = ~get(handles.transport_stop,'Value');

end

%release(Player);
%release(Reader);
end

function transport_stop_Callback(hObject, eventdata, handles)
%set(handles.transport_play,'Value',0)
%flag_rec = 0;
%save('app_data/current.mat','flag_rec','-append');
% cla(handles.ax_chan1)
% cla(handles.ax_chan2)
% cla(handles.ax_chan3)
% cla(handles.ax_chan4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function up_Callback(hObject, eventdata, handles)
load ('app_data/settings.mat','c_mics_simultaneo');
 load('app_data/settings.mat','slider_prev_value');

 slider_prev_value  = slider_prev_value + 0.1;
 
 if slider_prev_value <= 1
     
 ax1_pos = get(handles.ax_chan1,'Position');
 ax2_pos = get(handles.ax_chan2,'Position');
 ax3_pos = get(handles.ax_chan3,'Position');
 ax4_pos = get(handles.ax_chan4,'Position'); 
 ax5_pos = get(handles.ax_chan5,'Position');
 ax6_pos = get(handles.ax_chan6,'Position');
 ax7_pos = get(handles.ax_chan7,'Position');
 ax8_pos = get(handles.ax_chan8,'Position');
 panel1_pos = get(handles.panel_config_chan1,'Position');
 panel2_pos = get(handles.panel_config_chan2,'Position');
 panel3_pos = get(handles.panel_config_chan3,'Position');
 panel4_pos = get(handles.panel_config_chan4,'Position');
 panel5_pos = get(handles.panel_config_chan5,'Position');
 panel6_pos = get(handles.panel_config_chan6,'Position');
 panel7_pos = get(handles.panel_config_chan7,'Position');
 panel8_pos = get(handles.panel_config_chan8,'Position'); 
  
     ax1_pos(2)=ax1_pos(2)-0.25;
     ax2_pos(2)=ax2_pos(2)-0.25;
     ax3_pos(2)=ax3_pos(2)-0.25;
     ax4_pos(2)=ax4_pos(2)-0.25;    
     ax5_pos(2)=ax5_pos(2)-0.25;
     ax6_pos(2)=ax6_pos(2)-0.25;
     ax7_pos(2)=ax7_pos(2)-0.25;
     ax8_pos(2)=ax8_pos(2)-0.25;
     panel1_pos(2) = panel1_pos(2)-0.25;
     panel2_pos(2) = panel2_pos(2)-0.25;
     panel3_pos(2) = panel3_pos(2)-0.25;
     panel4_pos(2) = panel4_pos(2)-0.25;
     panel5_pos(2) = panel5_pos(2)-0.25;
     panel6_pos(2) = panel6_pos(2)-0.25;
     panel7_pos(2) = panel7_pos(2)-0.25;
     panel8_pos(2) = panel8_pos(2)-0.25;     
 
 if panel1_pos(2) + panel1_pos(4) > 1
    set(handles.panel_config_chan1,'Visible','Off'); 
 elseif c_mics_simultaneo >=5;
    set(handles.panel_config_chan1,'Visible','On');  
 end
 if panel2_pos(2) + panel2_pos(4) > 1
    set(handles.panel_config_chan2,'Visible','Off');
 elseif c_mics_simultaneo >=6;
    set(handles.panel_config_chan2,'Visible','On'); 
 end
 if panel3_pos(2) + panel3_pos(4) > 1
    set(handles.panel_config_chan3,'Visible','Off');
 elseif c_mics_simultaneo >=7;
    set(handles.panel_config_chan3,'Visible','On'); 
 end
 if panel4_pos(2) + panel4_pos(4) > 1
    set(handles.panel_config_chan4,'Visible','Off'); 
 elseif c_mics_simultaneo >=8;
    set(handles.panel_config_chan4,'Visible','On');     
 end
 if panel5_pos(2) + panel5_pos(4) > 1
    set(handles.panel_config_chan5,'Visible','Off');   
 elseif c_mics_simultaneo >=1;
    set(handles.panel_config_chan5,'Visible','On'); 
 end
 if panel6_pos(2) + panel6_pos(4) > 1
    set(handles.panel_config_chan6,'Visible','Off'); 
 elseif c_mics_simultaneo >=2;
    set(handles.panel_config_chan6,'Visible','On');    
 end
 if panel7_pos(2) + panel7_pos(4) > 1
    set(handles.panel_config_chan7,'Visible','Off');    
 elseif c_mics_simultaneo >=3;
    set(handles.panel_config_chan7,'Visible','On'); 
 end
 if panel8_pos(2) + panel8_pos(4) > 1
    set(handles.panel_config_chan8,'Visible','Off');    
 elseif c_mics_simultaneo >=4;
    set(handles.panel_config_chan8,'Visible','On'); 
 end
 
 set(handles.ax_chan1,'Position',ax1_pos);
 set(handles.ax_chan2,'Position',ax2_pos);
 set(handles.ax_chan3,'Position',ax3_pos);
 set(handles.ax_chan4,'Position',ax4_pos);
 set(handles.ax_chan5,'Position',ax5_pos);
 set(handles.ax_chan6,'Position',ax6_pos);
 set(handles.ax_chan7,'Position',ax7_pos);
 set(handles.ax_chan8,'Position',ax8_pos);
 set(handles.panel_config_chan1,'Position',panel1_pos);
 set(handles.panel_config_chan2,'Position',panel2_pos);
 set(handles.panel_config_chan3,'Position',panel3_pos);
 set(handles.panel_config_chan4,'Position',panel4_pos);
 set(handles.panel_config_chan5,'Position',panel5_pos);
 set(handles.panel_config_chan6,'Position',panel6_pos);
 set(handles.panel_config_chan7,'Position',panel7_pos);
 set(handles.panel_config_chan8,'Position',panel8_pos);
 
 save('app_data/settings.mat','slider_prev_value','-append')

 else


  slider_prev_value  = slider_prev_value - 0.1;
 save('app_data/settings.mat','slider_prev_value','-append')
 end

function down_Callback(hObject, eventdata, handles)
 load('app_data/settings.mat','slider_prev_value')
 load('app_data/settings.mat','c_mics_simultaneo')
slider_prev_value = slider_prev_value - 0.1;

if slider_prev_value>0.3
 ax1_pos = get(handles.ax_chan1,'Position');
 ax2_pos = get(handles.ax_chan2,'Position');
 ax3_pos = get(handles.ax_chan3,'Position');
 ax4_pos = get(handles.ax_chan4,'Position'); 
 ax5_pos = get(handles.ax_chan5,'Position');
 ax6_pos = get(handles.ax_chan6,'Position');
 ax7_pos = get(handles.ax_chan7,'Position');
 ax8_pos = get(handles.ax_chan8,'Position');
 panel1_pos = get(handles.panel_config_chan1,'Position');
 panel2_pos = get(handles.panel_config_chan2,'Position');
 panel3_pos = get(handles.panel_config_chan3,'Position');
 panel4_pos = get(handles.panel_config_chan4,'Position');
 panel5_pos = get(handles.panel_config_chan5,'Position');
 panel6_pos = get(handles.panel_config_chan6,'Position');
 panel7_pos = get(handles.panel_config_chan7,'Position');
 panel8_pos = get(handles.panel_config_chan8,'Position');
   

     ax1_pos(2)=ax1_pos(2)+0.25;
     ax2_pos(2)=ax2_pos(2)+0.25;
     ax3_pos(2)=ax3_pos(2)+0.25;
     ax4_pos(2)=ax4_pos(2)+0.25;
     ax5_pos(2)=ax5_pos(2)+0.25;
     ax6_pos(2)=ax6_pos(2)+0.25;
     ax7_pos(2)=ax7_pos(2)+0.25;
     ax8_pos(2)=ax8_pos(2)+0.25;
    panel1_pos(2) = panel1_pos(2)+0.25;
    panel2_pos(2) = panel2_pos(2)+0.25;
    panel3_pos(2) = panel3_pos(2)+0.25;
    panel4_pos(2) = panel4_pos(2)+0.25;
    panel5_pos(2) = panel5_pos(2)+0.25;
    panel6_pos(2) = panel6_pos(2)+0.25;
    panel7_pos(2) = panel7_pos(2)+0.25;
    panel8_pos(2) = panel8_pos(2)+0.25;
    
 if panel1_pos(2) + panel1_pos(4) > 1
    set(handles.panel_config_chan1,'Visible','Off'); 
 elseif c_mics_simultaneo >=5;
    set(handles.panel_config_chan1,'Visible','On');  
 end
 if panel2_pos(2) + panel2_pos(4) > 1
    set(handles.panel_config_chan2,'Visible','Off');
 elseif c_mics_simultaneo >=6;
    set(handles.panel_config_chan2,'Visible','On'); 
 end
 if panel3_pos(2) + panel3_pos(4) > 1
    set(handles.panel_config_chan3,'Visible','Off');
 elseif c_mics_simultaneo >=7;
    set(handles.panel_config_chan3,'Visible','On'); 
 end
 if panel4_pos(2) + panel4_pos(4) > 1
    set(handles.panel_config_chan4,'Visible','Off'); 
 elseif c_mics_simultaneo >=8;
    set(handles.panel_config_chan4,'Visible','On');     
 end
 if panel5_pos(2) + panel5_pos(4) > 1
    set(handles.panel_config_chan5,'Visible','Off');   
 elseif c_mics_simultaneo >=1;
    set(handles.panel_config_chan5,'Visible','On'); 
 end
 if panel6_pos(2) + panel6_pos(4) > 1
    set(handles.panel_config_chan6,'Visible','Off'); 
 elseif c_mics_simultaneo >=2;
    set(handles.panel_config_chan6,'Visible','On');    
 end
 if panel7_pos(2) + panel7_pos(4) > 1
    set(handles.panel_config_chan7,'Visible','Off');    
 elseif c_mics_simultaneo >=3;
    set(handles.panel_config_chan7,'Visible','On'); 
 end
 if panel8_pos(2) + panel8_pos(4) > 1
    set(handles.panel_config_chan8,'Visible','Off');    
 elseif c_mics_simultaneo >=4;
    set(handles.panel_config_chan8,'Visible','On'); 
 end
 
 set(handles.ax_chan1,'Position',ax1_pos);
 set(handles.ax_chan2,'Position',ax2_pos);
 set(handles.ax_chan3,'Position',ax3_pos);
 set(handles.ax_chan4,'Position',ax4_pos);
 set(handles.ax_chan5,'Position',ax5_pos);
 set(handles.ax_chan6,'Position',ax6_pos);
 set(handles.ax_chan7,'Position',ax7_pos);
 set(handles.ax_chan8,'Position',ax8_pos);
 set(handles.panel_config_chan1,'Position',panel1_pos);
 set(handles.panel_config_chan2,'Position',panel2_pos);
 set(handles.panel_config_chan3,'Position',panel3_pos);
 set(handles.panel_config_chan4,'Position',panel4_pos);
 set(handles.panel_config_chan5,'Position',panel5_pos);
 set(handles.panel_config_chan6,'Position',panel6_pos);
 set(handles.panel_config_chan7,'Position',panel7_pos);
 set(handles.panel_config_chan8,'Position',panel8_pos);
 
 save('app_data/settings.mat','slider_prev_value','-append')

else

slider_prev_value = slider_prev_value + 0.1;
save('app_data/settings.mat','slider_prev_value','-append')
end

function up_CreateFcn(hObject, eventdata, handles)
slider_prev_value = 1;
 save('app_data/settings.mat','slider_prev_value','-append')









function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to c5_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c5_name as text
%        str2double(get(hObject,'String')) returns contents of c5_name as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c5_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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






function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to c5_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c5_name as text
%        str2double(get(hObject,'String')) returns contents of c5_name as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c5_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to c7_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c7_name as text
%        str2double(get(hObject,'String')) returns contents of c7_name as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c7_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to c6_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c6_name as text
%        str2double(get(hObject,'String')) returns contents of c6_name as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c6_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to c8_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c8_name as text
%        str2double(get(hObject,'String')) returns contents of c8_name as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c8_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                           GRAFICOS
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes during object creation, after setting all properties.
function ax_chan1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns 

% --- Executes during object creation, after setting all properties.
function ax_chan2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function ax_chan3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function ax_chan4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function ax_chan5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function ax_chan6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function ax_chan7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function ax_chan8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_chan5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes25


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes25)
    Ha=allchild(cla);
    set(Ha,'visible','off');
    
for i = 1:350; 
    pointer = i; 
    a = graphCurrentAngle(pointer,handles.axes25); 
    drawnow;
    tic;
    set(handles.disp_angulo,'String',a);
    while toc<0.5
    end
    
end



function disp_angulo_Callback(hObject, eventdata, handles)
% hObject    handle to disp_angulo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_angulo as text
%        str2double(get(hObject,'String')) returns contents of disp_angulo as a double


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over transport_play.
function transport_play_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to transport_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function fuente_actual_Callback(hObject, eventdata, handles)
% hObject    handle to fuente_actual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fuente_actual as text
%        str2double(get(hObject,'String')) returns contents of fuente_actual as a double


% --- Executes during object creation, after setting all properties.
function fuente_actual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fuente_actual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mics_actual_Callback(hObject, eventdata, handles)
% hObject    handle to mics_actual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mics_actual as text
%        str2double(get(hObject,'String')) returns contents of mics_actual as a double


% --- Executes during object creation, after setting all properties.
function mics_actual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mics_actual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function muestra_actual_Callback(hObject, eventdata, handles)
% hObject    handle to muestra_actual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of muestra_actual as text
%        str2double(get(hObject,'String')) returns contents of muestra_actual as a double


% --- Executes during object creation, after setting all properties.
function muestra_actual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to muestra_actual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_pointer_Callback(hObject, eventdata, handles)
% hObject    handle to n_pointer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_pointer as text
%        str2double(get(hObject,'String')) returns contents of n_pointer as a double


% --- Executes during object creation, after setting all properties.
function n_pointer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_pointer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
