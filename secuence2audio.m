function [ ] = secuence2audio(secuencia)
%secuence2audio Guarda el archivo de audio generado, expecificando el
%nombre y las características que tiene.
%   Secuencia es la señal generada (ya lista para ser guardada), tipo es
%  0 para "MLS" o 1 para "SWEEP"

load('app_data/settings.mat','typesignal');
load('app_data/current.mat','path');

switch typesignal
    case 'MLS'
load('app_data/settings.mat','nBits');
load('app_data/settings.mat','SampleRate');
load('app_data/current.mat','MLSamplitud');
load('app_data/current.mat','mls_orden');
load('app_data/current.mat','repet_mls');

MLSrepeticiones = num2str(repet_mls);

Nombre =  strcat(path,'MLS',mls_orden,'-',MLSrepeticiones,'Repeticiones','-', date,'.wav');
audiowrite(Nombre,secuencia,SampleRate,'BitsPerSample',nBits);
Nombre_signal = Nombre;
save('app_data/current.mat','Nombre_signal','-append');

    case 'SWEEP'

load('app_data/settings.mat','nBits');
load('app_data/settings.mat','SampleRate');
load('app_data/current.mat','sweep_duracion');
load('app_data/current.mat','sweep_f1');
load('app_data/current.mat','sweep_f2');
load('app_data/current.mat','sweep_silencio');
load('app_data/current.mat','sweep_amplitud');
load('app_data/current.mat','inversefiltersweepfft');
sweep_duracion = num2str(sweep_duracion);
sweep_f1 = num2str(sweep_f1);
sweep_f2 = num2str(sweep_f2);
sweep_silencio = num2str(sweep_silencio);
sweep_amplitud = num2str(sweep_amplitud);


Nombre =  strcat(path,'Sweep',sweep_f1,'-',sweep_f2,'-',sweep_duracion,'Seg','-',sweep_silencio,'-','Silenc', date,'.wav');
audiowrite(Nombre,secuencia,SampleRate,'BitsPerSample',nBits);
Nombre_signal = Nombre;
save('app_data/current.mat','Nombre_signal','-append');
Nombre_filtroinverso = strcat(path,'Sweep',sweep_f1,'-',sweep_f2,'-',sweep_duracion,'Seg','-',sweep_silencio,'-','Silenc', date,'_','Filtro_Inverso_FFT','.mat');

save(Nombre_filtroinverso,'inversefiltersweepfft');
save('app_data/current.mat','Nombre_filtroinverso','-append');
end
end

