function [Record] = createRecordV2(pointer)

%%%Usando Pointer obtengo de ChannelMapping y de objectName todo lo que
%%%necesito para armar los nombres y los objetos de grabacion. Uso como
%%%referencia las variables logico_ordenado y nmedicion.

load('app_data/settings.mat','ChannelMapping');
load('app_data/orden.mat','logico_ordenado');
load('app_data/orden.mat','nmedicion');
load('app_data/settings.mat','c_mics_simultaneo');


load('app_data/settings.mat','BufferSize');
load('app_data/settings.mat','QueueDuration');
load('app_data/settings.mat','DeviceName');
load('app_data/settings.mat','SampleRate');
load('app_data/settings.mat','nBits');
load('app_data/settings.mat','SamplesPerFrame');
i = 1;
pos_actual = find(nmedicion{i}==pointer,1);
while(isempty(pos_actual))
i = i+1;
pos_actual = find(nmedicion{i}==pointer,1);
end
fila_orden_actual = i;

mics_actual = logico_ordenado(fila_orden_actual,3);



for i = 1:c_mics_simultaneo
ChannelMappingNum(i)= str2double(ChannelMapping{mics_actual}{i}(end:end));
end


Record = dsp.AudioRecorder;
Record.BufferSizeSource = 'Property';
Record.BufferSize = BufferSize;
Record.QueueDuration = QueueDuration;
Record.ChannelMappingSource = 'Property';
Record.ChannelMapping = ChannelMappingNum;
Record.DeviceName = DeviceName;
Record.SampleRate = SampleRate;
if nBits == 16
    Record.OutputDataType = 'int16';
    Record.DeviceDataType = '16-bit integer';
else
    Record.OutputDataType = 'int32';
    Record.DeviceDataType = '24-bit integer';
end
Record.SamplesPerFrame = SamplesPerFrame;
%save('app_data/current.mat','-v6','Record','-append');
end