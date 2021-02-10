%BufferSize

buf_string = get(handles.buffer,'String');
buf_value = get(handles.buffer,'Value');
BufferSize = str2double(buf_string(buf_value));

%QueueDuration
QueueDuration = str2double(get(handles.Queue,'String'));

%SamplesPerFrame
SamplesPerFrame = BufferSize;

%SampleRate
fs48000 = get(handles.fs48000,'Value');
if fs48000 ==1;
    SampleRate = 48000;
else
    SampleRate =44100;
end

%nBits
nbits16 = get(handles.nbits16,'Value');
if nbits16 ==1;
    nBits = 16;
else
    nBits =24;
end

%Nombre del Dispositivo seleccionado
devices = get(handles.audiodevice,'String');
selected = get(handles.audiodevice,'Value');
DeviceName = devices{selected};

%Cantidad de entradas que tiene el hardware
maxinput = str2double(get(handles.maxinput,'String')); 

Canales = 1:maxinput;

%Cálculo y muestra de latencia
latency_samples = QueueDuration*SampleRate + 2 * BufferSize ;
latency_time =num2str(latency_samples/SampleRate);
latency_text = strcat(latency_time,' segundos');
set(handles.latency_text,'String',latency_text)

%Salida de grabación
maxout = str2double(get(handles.maxout,'String')); 
%salida_grabacion = str2double ( get(handles.salida_grabacion,'String'));

%if salida_grabacion <= maxout
%    save('app_data/settings.mat','salida_grabacion','-append');
%else
%    errordlg('La salida de grabación no fue elegida correctamente', 'Error');
%    break
%end

%Salida de monitoreo
maxout = str2double(get(handles.maxout,'String')); 
%salida_monitoreo = str2double ( get(handles.salida_monitoreo,'String'));

%if salida_monitoreo <= maxout && salida_monitoreo ~= salida_grabacion 
%    save('app_data/settings.mat','salida_monitoreo','-append');
%else
%    errordlg('La salida de monitoreo no fue elegida correctamente', 'Error');
%    break
%end

maxinp = str2double(get(handles.maxinput,'String'));
save('app_data/settings.mat','maxout','maxinp','BufferSize','Canales','nBits','SampleRate','SamplesPerFrame','QueueDuration','DeviceName','-append');
