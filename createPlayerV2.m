function [Player] = createPlayerV2(pointer)


%Generar objetos dsp.AudioPlayer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%CARGAR VARIABLES CON LA INFORMACIÓN SOBRE LA MEDICION
load('app_data/orden.mat','orden');
load('app_data/orden.mat','nmedicion');
load('app_data/orden.mat','logico_ordenado');
load('app_data/settings.mat','ChannelMappingOut');
load('app_data/settings.mat','c_fuentes_total');
load('app_data/settings.mat','c_fuentes_simultaneo');
%Cargar variables de Seteo
load('app_data/settings.mat','DeviceName')
load('app_data/settings.mat','SampleRate')
load('app_data/settings.mat','nBits')
load('app_data/settings.mat','BufferSize')
load('app_data/settings.mat','QueueDuration')
load('app_data/settings.mat','mon')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UBICO "POINTER" DENTRO LA FUNCION "NMEDICION" Y OBTENGO LA POSICION
%en logico_ordenado, para saber cuando se cambia de fuente. Cambio el
%Channel Mapping en función de esa información.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Creo el objeto de reproducción

Player = dsp.AudioPlayer;
Player.DeviceName = DeviceName;
Player.SampleRate = SampleRate;

if nBits == 16
    Player.DeviceDataType = '16-bit integer';
   else
    Player.DeviceDataType = '24-bit integer';
end
Player.BufferSizeSource = 'Property';
Player.BufferSize = BufferSize;
Player.QueueDuration = QueueDuration;
Player.ChannelMappingSource = 'Property';

i = 1;
pos_actual = find(nmedicion{i}==pointer,1);
while(isempty(pos_actual))
i = i+1;
pos_actual = find(nmedicion{i}==pointer,1);
end

fila_orden_actual = i;
fuente_actual = logico_ordenado(fila_orden_actual,2);

if mon ==1
    for i = 1:length(ChannelMappingOut{fuente_actual})%Sumo 1 por la salida de monitoreo;
    ChannelMappingNum(i)= str2double(ChannelMappingOut{fuente_actual}{i}(end:end));
    end
else
    for i = 1:length(ChannelMappingOut{fuente_actual})
    ChannelMappingNum(i)= str2double(ChannelMappingOut{fuente_actual}{i}(end:end));
    end   
end

Player.ChannelMapping = ChannelMappingNum;
%save('app_data/current.mat','Player','-append');
end

