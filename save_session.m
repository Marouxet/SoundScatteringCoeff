%Archivo para Guardar la Sesión
load('app_data/current.mat','path');
pathmain = path(1:end-6);
path2 = strcat(pathmain,'Data\');

     if exist(path2,'dir') == 0    
         %Create directory for measurement.
         mkdir(pathmain,'Data');
     end
     
copyfile('app_data/current.mat',path2,'f');
copyfile('app_data/settings.mat',path2,'f');
copyfile('app_data/orden.mat',path2,'f');