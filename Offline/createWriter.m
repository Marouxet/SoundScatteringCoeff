function [ Writer ] = createWriter(Channel,Filename)
%Generar objetos dsp.AudioFileWriter. 
%Genera objetos dsp.AudioFileWriter en función de la cantidad de canales
%usados y el seteo, guardado en setting.mat. Todos los objetos se guardan
%en una estructura llamada Writer, para poder generarla dinámicamente
%Channel debe ser el canal  del dispositivo de entrada que está
%asociado a este objeto. 
%nmedicion es el numero de medicion que se va a hacer
%Cargar variables de Seteo
load('app_data/settings.mat','SampleRate')
load('app_data/settings.mat','nBits')
load('app_data/settings.mat','objectName')
load('app_data/current.mat','Writer')

%Nombre de Archivo
load('app_data/current.mat','path');
load('app_data/current.mat','ChannelsNames');
load('app_data/current.mat','TipodeMedicion');
load('app_data/settings.mat','intervalo_angular');

obj = dsp.AudioFileWriter;
obj.Filename = Filename;
obj.FileFormat = 'WAV';
obj.SampleRate = SampleRate;
obj.Compressor = 'None (uncompressed)';
if nBits == 16
    obj.DataType = 'int16';
else
    obj.DataType ='int24';
end

%Creación del nombre
name = char(objectName{Channel});
Writer.(name) = obj;

%Guardado de la estructuracon el agregado del nuevo objeto

save('app_data/current.mat','Writer','-append');


end

