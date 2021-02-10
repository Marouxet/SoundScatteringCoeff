%%%Armado de la estructura "Medición"
tic;
c_mics_total = str2double(get(handles.c_mics_total,'String'));
c_mics_simultaneo = str2double(get(handles.c_mics_simultaneas,'String'));
c_fuentes_total = str2double(get(handles.c_fuentes_total,'String'));
c_fuentes_simultaneo = str2double(get(handles.c_fuentes_simultaneas,'String'));

p1 = get(handles.prioridad1,'Value');
p2 = get(handles.prioridad2,'Value');
p3 = get(handles.prioridad3,'Value'); 
l1 = get(handles.luego1,'Value');
l2 = get(handles.luego2,'Value');
l3 = get(handles.luego3,'Value');

if      p1 ==1 && l2 == 1   %Caso en el que se varía MAS los microfonos (con muestra cambiada UNA vez)
    mic = 3;
    muestra = 1;
    fuente = 2;
    
    C0 = 2;
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C1 = c_mics_total/c_mics_simultaneo;
    else
        C1 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    for i = 1:C1
        C1_text{i} = strcat('MICS_',num2str(i));
        C1_log(i) = i;
    end
    
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C2 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C2 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C2
        C2_text{i} = strcat('FNTE_',num2str(i));
        C2_log(i) = i;
    end
    
    C3 = 2;
    
    C3_text = {'SM', 'CM'};
    C3_log = [0 1];
elseif  p1 ==1 && l3 == 1   %Caso en el que se varía MAS la fuente (con muestra cambiada UNA vez)
    mic = 2;
    muestra = 1;
    fuente = 3;  
    
    C0 = 2;
    
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C1 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C1 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C1
        C1_text{i} = strcat('FNTE_',num2str(i));
        C1_log(i) = i;
    end
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C2 = c_mics_total/c_mics_simultaneo;
    else
        C2 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
     for i = 1:C1
        C2_text{i} = strcat('MICS_',num2str(i));
        C2_log(i) =  i;
    end
    
    C3 = 2;
    
    C3_text = {'SM', 'CM'};
    C3_log = [0 1];
elseif  p2 ==1 && l1 == 1   %Caso en el que se varía MÁS los microfonos (con fuente cambiada UNA vez)
    
    mic = 3;
    muestra = 2;
    fuente = 1;
    
    C0 = 2;
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C1 = c_mics_total/c_mics_simultaneo;
    else
        C1 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C1
        C1_text{i} = strcat('MICS_',num2str(i));
        C1_log(i) = i;
    end
    
    C2 = 2;
    
    C2_text = {'SM', 'CM'};
    C2_log = [0 1]; 
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C3 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C3 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('FNTE_',num2str(i));
        C3_log(i)= i;
    end
    
elseif  p2 ==1 && l3 == 1 %Caso en el que se varía MÄS la muestra (con la fuente cambiada UNA vez)
    
    mic = 2;
    muestra = 3;
    fuente = 1;
    
    C0 = 2;
     
    C1 = 2;
    
    C1_text = {'SM', 'CM'};
    C1_log = [0 1];
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C2 = c_mics_total/c_mics_simultaneo;
    else
        C2 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C1
        C2_text{i} = strcat('MICS_',num2str(i));
        C2_log(i) = i;
    end
        
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C3 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C3 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('FNTE_',num2str(i));
        C3_log(i) = i;
    end
    
elseif  p3 ==1 && l1 == 1  %Caso en el que se varía MAS la fuente (con los microfonos cambiado una vez)
    
        mic = 1;
    muestra = 2;
    fuente = 3;
    
    C0 = 2;
    
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C1 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C1 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C1
        C1_text{i} = strcat('FNTE_',num2str(i));
        C1_log(i)=i;
    end
    
    C2 = 2;
    
    C2_text = {'SM', 'CM'};
    C2_log = [0 1];
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C3 = c_mics_total/c_mics_simultaneo;
    else
        C3 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('MICS_',num2str(i));
        C3_log(i) = i;
    end
    
elseif  p3 ==1 && l2 == 1   %caso en el que se varía MAS la muestra (con los microfonos cambiado una vez)
    
        mic = 1;
    muestra = 3;
    fuente = 2;
   
    C0 = 2;
     
    C1 = 2;
    
    C1_text = {'SM', 'CM'};
    C1_log = [0 1];
   
    if mod(c_fuentes_total,c_fuentes_simultaneo) == 0
        C2 = c_fuentes_total/c_fuentes_simultaneo;
    else
        C2 = fix(c_fuentes_total/c_fuentes_simultaneo) +1;
    end
    
    for i = 1:C2
        C2_text{i} = strcat('FNTE_',num2str(i));
        C2_log(i) = i;
    end
    
    if mod(c_mics_total,c_mics_simultaneo) == 0
        C3 = c_mics_total/c_mics_simultaneo;
    else
        C3 = fix(c_mics_total/c_mics_simultaneo) +1;
    end
    
    for i = 1:C3
        C3_text{i} = strcat('MICS_',num2str(i));
        C3_log(i) = i;
    end
    
end
mediciones = C1*C2*C3*C0;
medicion = cell(mediciones,4);
logico = zeros(mediciones,4);
i_C1 = 1;
i_C2 = 1;
i_C3 = 1;
for i =1:mediciones
    if mod(i,2)==0;
        medicion{i,4} = 'G';
        logico(i,4)=1;
    else
        medicion{i,4} = 'SG';
        logico(i,4)=0;
    end
    
    
    medicion(i,3) = C1_text(i_C1);
    logico(i,3) = C1_log(i_C1);
    if mod(i,C0) == 0 
            i_C1 = i_C1 + 1;
    end
            
    if i_C1 == C1+1;
        i_C1 = 1;
    end
        
     medicion(i,2) = C2_text(i_C2);
     logico(i,2) = C2_log(i_C2);
    if mod(i,C0*C1) == 0 
            i_C2 = i_C2 + 1;
    end
            
    if i_C2 == C2+1;
        i_C2 = 1;
    end
    
    medicion(i,1) = C3_text(i_C3);
    logico(i,1) = C3_log(i_C3);
    if mod(i,C0*C1*C2) == 0 
            i_C3 = i_C3 + 1;
    end
            
    if i_C3 == C3+1;
        i_C3 = 1;
    end
end

orden = medicion;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TABLA LOGICA PARA GUIAR LOS DISTINTOS BUCLES AL ARMAR NOMBRES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ESTRUCTURA:
%
%    MESA GIRATORIA   |  FUENTE    | MICS      |  GIRAR O NO 
%
%   MESA GIRATORIA: 1 SIGNIFICA CON, 0 ES SIN
%   FUENTE: 1, 2, 3, ..., N. PARA MENCIONAR LAS DISTINTAS COMBINACIONES
%   MICS: 1, 2, 3....N. Para mencionar las distintas combinaciones. OJO,
%   combinaciones, NO POSICIONES. Cada combinacion puede incluir mas de un
%   microfono.
%   GIRAR O NO: 1 es girando, 0 es sin girar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%El punto de Partida es la Matrix logico, pero debo re-ordenarla acorde a
%la estructura de arriba
logico_ordenado = zeros(size(logico));

logico_ordenado(:,4) = logico(:,4);%Siempre al final está girando o sin girar
logico_ordenado(:,3) = logico(:,mic);
logico_ordenado(:,2) = logico(:,fuente);
logico_ordenado(:,1) = logico(:,muestra);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%CARGADO DE DATOS DE LA GUIDE CONFIGURACION_PROYECTO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%DeviceName
devices = get(handles.audiodevice,'String');
selected = get(handles.audiodevice,'Value');
DeviceName = devices{selected};

%ChannelMapping
mics_simultaneos = str2double(get(handles.c_mics_simultaneas,'String'));
mics_total = str2double(get(handles.c_mics_total,'String'));
data_mics = get(handles.table_mics,'Data');

data_canales = data_mics(:,2);
data_nombres = data_mics(:,1);
if mod(mics_total,mics_simultaneos)==0
    R = mics_total/mics_simultaneos;
    for i = 1:R
    ChannelMapping{i} = data_canales (mics_simultaneos*(i-1)+1:mics_simultaneos*i);
    objectName{i} = data_nombres(mics_simultaneos*(i-1)+1:mics_simultaneos*i);
    end
else
    R = fix(mics_total/mics_simultaneos);
    for i = 1:R
    ChannelMapping{i} = data_canales (mics_simultaneos*(i-1)+1:mics_simultaneos*i);
    objectName{i} = data_nombres(mics_simultaneos*(i-1)+1:mics_simultaneos*i);
    end
    ChannelMapping{R+1}=data_canales(mics_simultaneos*i+1:end);
    objectName{R+1} = data_nombres(mics_simultaneos*i+1:end);
end

%Campo "pointer". Cuenta la cantidad de mediciones realizadas correctamente
pointer = 0;


%Campo "intervalo_angular". Indica cada cuanto debe girar la mesa.
intervalo_angular = str2double(get(handles.intervalo_angular,'String'));
%medicion.intervalo_angular = intervalo_angular;

%Campo "nmedicion". Indica el número que corresponde a cada medición, en
%función de medicion.orden. Para hacerlo comparo el string con dos filtros,
%y encuentro si deben realizarse 1 (en el caso de no girar) o
%c_medicion_girando (en el caso de girar) mediciones. Luego genero 4 celdas
%que numeran la medición. Sirve para luego ser comprarada con Pointer.

c_medicion_girando = 360/intervalo_angular;
s1 = 'SG';

tf(1) = strcmp(s1,orden{1,4});
if tf(1) == 1
    nmedicion{1} = 1;
else
    nmedicion{1} = 1:c_medicion_girando;
end

for i = 2:length(orden)
    tf(i) = strcmp(s1,orden{i,4});
    if tf(i) == 1
nmedicion{i} = 1+max(nmedicion{i-1});
    else
nmedicion{i} = (1:c_medicion_girando)+max(nmedicion{i-1});
    end
end



%Campo "angle". Se corresponde con el ángulo de giro de cada medicion

 for i = 1:length(orden)
    if tf(i) == 1
angle{i} = 0;
 
     else
angle{i} = (0:c_medicion_girando-1)*intervalo_angular;
     end
 end
 
 
 %ChannelMappingOut
fuentes_simultaneas = str2double(get(handles.c_fuentes_simultaneas,'String'));
fuentes_total = str2double(get(handles.c_fuentes_total,'String'));
data_fuentes = get(handles.table_fuentes,'Data');
data_canales = data_fuentes(:,2);
data_mon = get(handles.salida_monitoreo,'String');
data_mon_selec = get(handles.salida_monitoreo,'Value');
data_mon = data_mon (data_mon_selec);
if mod(fuentes_total,fuentes_simultaneas)==0
    R = fuentes_total/fuentes_simultaneas;
    for i = 1:R
        ChannelMappingOut{i} = data_canales (fuentes_simultaneas*(i-1)+1:fuentes_simultaneas*i);
        if ~strcmp(data_mon,'Desactivado')
        ChannelMappingOut{i} = [ChannelMappingOut{i} ; data_mon];
        end
    end
else
    R = fix(fuentes_total/fuentes_simultaneas);
    for i = 1:R
        ChannelMappingOut{i} = data_canales (fuentes_simultaneas*(i-1)+1:fuentes_simultaneas*i);
        if ~strcmp(data_mon,'Desactivado')
        ChannelMappingOut{i} = [ChannelMappingOut{i} ; data_mon];
        end
    end
    ChannelMappingOut{R+1}=data_canales(fuentes_simultaneas*i+1:end);
    if ~strcmp(data_mon,'Desactivado')
    ChannelMappingOut{R+1}=[ ChannelMappingOut{R+1}  ; data_mon];
    end  
end 

if ~strcmp(data_mon,'Desactivado')
    mon = 1;
else
    mon = 0;
end


toc;



%%%%%%%%%%%%%%
%Prueba serializando
% intervalo_angular = getByteStreamFromArray(intervalo_angular);
% mon = getByteStreamFromArray(mon);
% ChannelMappingOut = getByteStreamFromArray(ChannelMappingOut);
% objectName = getByteStreamFromArray(objectName);
% c_mics_total = getByteStreamFromArray(c_mics_total);
% c_mics_simultaneo = getByteStreamFromArray(c_mics_simultaneo);
% c_fuentes_total = getByteStreamFromArray(c_fuentes_total);
% c_fuentes_simultaneo = getByteStreamFromArray(c_fuentes_simultaneo);
% BufferSize = getByteStreamFromArray(BufferSize);
% QueueDuration = getByteStreamFromArray(QueueDuration);
% SamplesPerFrame = getByteStreamFromArray(SamplesPerFrame);
% SampleRate = getByteStreamFromArray(SampleRate);
% nBits= getByteStreamFromArray(nBits);
% DeviceName = getByteStreamFromArray(DeviceName);
% ChannelMapping = getByteStreamFromArray(ChannelMapping);

save('app_data/settings.mat','intervalo_angular','mon','ChannelMappingOut','objectName','c_mics_total','c_mics_simultaneo','c_fuentes_total','c_fuentes_simultaneo','BufferSize','QueueDuration','SamplesPerFrame','SampleRate','nBits','DeviceName','ChannelMapping','-append')

save('app_data/current.mat','logico_ordenado','orden','nmedicion','angle','-append');
