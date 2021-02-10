%Generar objetos dsp.AudioPlayer. 


%Cargar variables de Seteo
load('app_data/settings.mat','DeviceName')
load('app_data/settings.mat','SampleRate')
load('app_data/settings.mat','nBits')
load('app_data/settings.mat','BufferSize')
load('app_data/settings.mat','QueueDuration')
load('app_data/settings.mat','salida_grabacion');
load('app_data/settings.mat','salida_monitoreo');

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

Player.ChannelMapping = [salida_grabacion salida_monitoreo];

%Guardado de la estructuracon el agregado del nuevo objeto

save('app_data/current.mat','Player_grabacion','-append');

