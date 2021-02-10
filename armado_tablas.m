% %Armado de tablas
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Tabla MICS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%load('app_data/settings.mat','Canales');

c_mics_total=str2double(get(handles.c_mics_total,'String'));
load('app_data/settings.mat','maxinp')
load('app_data/settings.mat','maxout')
seleccionado = get(handles.audiodevice,'Value');
seleccionado = seleccionado - 1;
maxinp = maxinp(seleccionado);
maxout = maxout(seleccionado);

Canales = 1:maxinp;

for j = 1:maxinp
    Canales_str{j} = strcat('Input ',num2str(Canales(j)));
end

data_previa = cell(c_mics_total,3);
j = 0;
for i = 1:c_mics_total
RowName{i}=strcat('Posicion#',num2str(i));
NombrePosicion{i}=strcat('Posicion_',num2str(i));
NombreArchivo{i}=strcat('P',num2str(i));
    j = j + 1;
    data_previa(i,2) = Canales_str(j); 
    if j == maxinp
       j = 0;
    end
end

set(handles.table_mics,'Data',data_previa);
set(handles.table_mics,'ColumnFormat',{'char',Canales_str,'char'});

set(handles.table_mics,'RowName',RowName')

data_mics = get(handles.table_mics,'Data');
data_mics(:,1) = NombrePosicion';
data_mics(:,3) = NombreArchivo';

set(handles.table_mics,'Enable','On');
set(handles.table_mics,'Data',data_mics);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tabla FUENTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c_fuentes_total=str2double(get(handles.c_fuentes_total,'String'));
c_fuentes_simultaneas=str2double(get(handles.c_fuentes_simultaneas,'String'));
Canales_out_mon = 1:c_fuentes_simultaneas;


for j = 1:c_fuentes_simultaneas
    CanalesOut_str_mon{j} = strcat('Output ',num2str(Canales_out_mon(j)));
end

data_previa_fuentes = cell(c_fuentes_total,3);
j = 0;
for i = 1:c_fuentes_total
RowName_fuentes{i}=strcat('Fuente#',num2str(i));
NombreFuente{i}=strcat('Fuente_',num2str(i));
NombreArchivo_f{i}=strcat('F',num2str(i));
    j = j + 1;
    data_previa_fuentes(i,2) = CanalesOut_str_mon(j); 
    if j == c_fuentes_simultaneas
       j = 0;
    end
end

set(handles.table_fuentes,'Data',data_previa_fuentes);
set(handles.table_fuentes,'ColumnFormat',{'char',CanalesOut_str_mon,'char'});

set(handles.table_fuentes,'RowName',RowName_fuentes')

data_fuentes = get(handles.table_fuentes,'Data');
data_fuentes(:,1) = NombreFuente';
data_fuentes(:,3) = NombreArchivo_f';

set(handles.table_fuentes,'Enable','On');
set(handles.table_fuentes,'Data',data_fuentes);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Salida de Monitoreo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c_fuentes_simultaneas = str2double(get(handles.c_fuentes_simultaneas,'String'));
Canales_out_mon = 1:maxout;


for j = 1:maxout
    CanalesOut_str_mon{j} = strcat('Output ',num2str(Canales_out_mon(j)));
end

data_monitoreo = ['Desactivado' CanalesOut_str_mon];
set(handles.salida_monitoreo,'String',data_monitoreo);

if c_fuentes_simultaneas+2 <= length(data_monitoreo)
    set(handles.salida_monitoreo,'Value',c_fuentes_simultaneas+2)
else
    set(handles.salida_monitoreo,'Value',1)
end
