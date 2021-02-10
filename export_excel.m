%%Exportar a Excel resultados de la medicion
load('app_data/current.mat','path');
path = path(1:end-6);

load('app_data/current.mat','octavas');
if octavas ==1
currentfile = 'app_data/Save_Data_Octava.xls';
name_file = strcat(path,'Save_Data_Octava.xls');
else
currentfile = 'app_data/Save_Data_Tercios.xls';
name_file = strcat(path,'Save_Data_Tercios.xls');
end

copyfile(currentfile,path)   

h = waitbar(0,'Exportando...');
%%Nombre de la muestra
load('app_data/current.mat','username');
username = {username};
xlswrite(name_file,username,'Resultados','E19:E19');
waitbar(1/9,h)
%%Descripción de la muestra
load('app_data/current.mat','userdescription');
userdescription = {userdescription};
xlswrite(name_file,userdescription,'Resultados','E21:E21');
waitbar(2/9,h)
%%Superficie de la muestra
load('app_data/current.mat','sup_muestra');
sup_muestra = round(sup_muestra*100)/100;
xlswrite(name_file,sup_muestra,'Resultados','G36:G36');
waitbar(3/9,h)
%%Diametro de la muestra
diam = round(sup_muestra/pi*100)/100;
xlswrite(name_file,diam,'Resultados','C36:C36');
waitbar(4/9,h)
%%Altura maxima de la muestra
load('app_data/current.mat','hmax_muestra');
xlswrite(name_file,hmax_muestra,'Resultados','C38:C38');
waitbar(5/9,h)
%%Volumen de la camara
load('app_data/current.mat','vol_camara');
xlswrite(name_file,vol_camara,'Resultados','N18:N18');
if octavas ==3
    load('app_data/current.mat','abs_eq_camara');
    xlswrite(name_file,abs_eq_camara(1:15)','Resultados','M25:M39');
    xlswrite(name_file,abs_eq_camara(16:30)','Resultados','O25:O39');
    waitbar(6/9,h)
else
    load('app_data/current.mat','abs_eq_camara');
    xlswrite(name_file,abs_eq_camara,'Resultados','M25:M34');
    waitbar(6/9,h)
end
%%Escala de la medicion
load('app_data/settings.mat','escala');
xlswrite(name_file,escala,'Resultados','W5:W5');
waitbar(7/9,h)
%%Coeficientes

if octavas ==3
    
  %  load('app_data/current.mat','coef_scattering');
    coef_scattering = Resultados{end}(16,:);
   % load('app_data/current.mat','coef_scattering_corregido');
   % load('app_data/current.mat','coef_absorcion');
    coef_absorcion = Resultados{end}(14,:);
    xlswrite(name_file,coef_absorcion','Resultados','X9:X38');
    waitbar(8/9,h)
    xlswrite(name_file,coef_scattering','Resultados','Y9:Y38');
  %  xlswrite(name_file,coef_scattering_corregido','Resultados','Y9:Y38');
else
    load('app_data/current.mat','coef_scattering');
    load('app_data/current.mat','coef_scattering_corregido');
    load('app_data/current.mat','coef_absorcion');
    xlswrite(name_file,coef_absorcion','Resultados','X9:W18');
    xlswrite(name_file,coef_scattering','Resultados','X9:X18');
    xlswrite(name_file,coef_scattering_corregido','Resultados','Y9:Y18');
    waitbar(8/9,h)
end
waitbar(9/9,h)
close(h)
winopen(name_file)