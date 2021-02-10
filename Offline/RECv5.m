%Grabador multicanal usando los dispostivos creados por createRecord, 
%createWriter, createrPlayer y createrReader. Versión beta

load('app_data/current.mat','active_chan')
switch active_chan
    case 1
%Cargo el objeto de lectura
load('app_data/current.mat','Reader');
%Cargo el objeto de grabación
load('app_data/current.mat','Record');
%Cargo los objetos de escritura
load('app_data/current.mat','Writer');
load('app_data/settings.mat','objectName');
%Cargo el flag record
load('app_data/current.mat','flag_rec');
%Cargo el objeto de Reproduccion de grabación
load('app_data/current.mat','Player_grabacion');
Player_grabacion.ChannelMapping = [salida_grabacion salida_monitoreo];
load('app_data/settings.mat','salida_grabacion');
load('app_data/settings.mat','salida_monitoreo');
%Cargo los graficos
load('app_data/current.mat','ax_chan1');

%% Gráficos
%Cargo data relativa a graficar
load('app_data/settings.mat','SamplesPerFrame');
load('app_data/settings.mat','SampleRate');
load('app_data/current.mat','xlimites');

int_plot = 64;
t_de_plot = 2;

set(handles.ax_chan1,'XLim',[0 xlimites(2)/int_plot]);
n = SamplesPerFrame / int_plot ; %Cantidad de muestras que son ploteadas en cada FRAME
cant = round(t_de_plot * SampleRate / SamplesPerFrame);
k = cant*n;

%buf_plot = zeros(n,length(Record.ChannelMapping));


j = cant-1; %j es la cantidad de frames que se van grabando
m = 0; %cantidad de pasos de graficacion
x = 1;
ploteo1 = plot(ax_chan1,nan);

%% Grabación, Reproducción y Gráficación
memory = zeros(Record.BufferSize,length(Record.ChannelMapping));
tictoc = zeros(1,2000);
buf_plot = zeros(k,length(Record.ChannelMapping));
Player_grabacion.ChannelMapping = [salida_grabacion salida_monitoreo];
load('app_data/settings.mat','QueueDuration')
load('app_data/current.mat','monitoreo');
silencio = zeros(Record.BufferSize,1);
while  flag_rec ==1 
    % i es la cantdad de canales q grabo simultáneamente
    memory = step(Record);
    if monitoreo ==0
    play = step(Reader);
    play = [play silencio];
    else
    play =step(Reader);
    play = [play memory(:,monitoreo)];
    end
     step(Player_grabacion, play);

         for i = 1:length(objectName)
            name = char(objectName{i});
            step(Writer.(name), memory(:,i));
         end
     graph3      
     
     
    %Cargo nuevamente el flag record, por si el usuario presionó STOP      
    load('app_data/current.mat','flag_rec');
    %Cargo nuevamente el flag monitoreado, por si el usuario cambio el canal que quiere monitorear 
    load('app_data/current.mat','monitoreo');
end

release(Record);
release(Player_grabacion);
release(Reader);
for i =1:length(objectName)
name = char(objectName{i});

release(Writer.(name));
end

    case 2
 
        
end