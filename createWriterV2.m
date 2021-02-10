function [ Writer ] = createWriterV2(pointer,corregido)
%Generar objetos dsp.AudioFileWriter. 
%Genera objetos dsp.AudioFileWriter en función de la cantidad de canales
%usados y el seteo, guardado en setting.mat. Todos los objetos se guardan
%en una estructura llamada Writer, para poder generarla dinámicamente
%Channel debe ser el canal  del dispositivo de entrada que está
%asociado a este objeto. 
%nmedicion es el numero de medicion que se va a hacer
%CORREGIDO es 1 para la medición corregida y 0 para el resto de las
%mediciones
%Cargar variables de Seteo
load('app_data/settings.mat','SampleRate')
load('app_data/settings.mat','nBits')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%CARGAR VARIABLES CON LA INFORMACIÓN SOBRE LA MEDICION
load('app_data/orden.mat','orden');
load('app_data/orden.mat','nmedicion');
load('app_data/orden.mat','angle');
load('app_data/settings.mat','objectName');
load('app_data/settings.mat','c_mics_simultaneo');
load('app_data/current.mat','path');
load('app_data/orden.mat','logico_ordenado');
load('app_data/current.mat','matriz_filename');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UBICO "POINTER" DENTRO LA FUNCION "NMEDICION" Y OBTENGO LA POSICION
%DE "ORDEN" Y DE "ANGLE". CON ESA INFORMACIÓN SE SABE QUÉ MEDICION SE 
%ESTÁ REALIZANDO Y SE ARMA EL NOMBRE DEL ARCHIVO. EN "OBJECTNAME" ESTÁ 
%EL NOMBRE DE LA POSICIÓN DE MICROFONO, QUE TAMBIÉN FORMA PARTE DEL NOMBRE 
%DEL ARCHIVO. SE GENERA UN OBJETO DSP.AUDIOFILEWRITER POR CADA MICROFONO
%USADO SIMULTANEAMENTE EN LA GRABACION.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 2
    corregido = 0;
end

switch corregido
    case 0
        i = 1;
        pos_actual = find(nmedicion{i}==pointer,1);
        while(isempty(pos_actual))
        i = i+1;
        pos_actual = find(nmedicion{i}==pointer,1);
        end

        fila_orden_actual = i;

        if length(angle{i}) == 1; %Caso de medición estática o de medición continua
                    x = angle{fila_orden_actual};
                if x == 0 %Caso de medición sin girar
             angulo_text = orden{i,4};       
                else %Caso de medición continua MLS
             angulo_text = 'Continua';  
                end
                clear x

        else %Caso de medicion girando un intervalo angular (SWEEP)
            angulo_text = strcat(orden{i,4},'_', num2str(angle{i}(pos_actual)));
        end

        mics_actual = logico_ordenado(fila_orden_actual,3);
        %objectName_actual = objectName(mics_actual);

        %objectName_actual = objectName((mics_actual-1)* c_mics_simultaneo + 1:mics_actual*c_mics_simultaneo);

        for i = 1:c_mics_simultaneo

        obj = dsp.AudioFileWriter;    
        Filename = strcat(path,orden{fila_orden_actual,1},'_',orden{fila_orden_actual,2},'_',objectName{mics_actual}{i},'_',orden{fila_orden_actual,3},'_',angulo_text,'.wav');
        Filename_1 =orden{fila_orden_actual,1};
        Filename_2 = orden{fila_orden_actual,2};
        Filename_3 = objectName{mics_actual}{i};
        Filename_4 = orden{fila_orden_actual,3};
        Filename_5 = strcat(angulo_text,'.wav');

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
        name = objectName{mics_actual}{i};
        Writer.(name) = obj;

        matriz_filename{size(matriz_filename,1) + 1,1} = Filename_1;
        matriz_filename{size(matriz_filename,1),2} = Filename_2;
        matriz_filename{size(matriz_filename,1),3} = Filename_3;
        matriz_filename{size(matriz_filename,1),4} = Filename_4;
        matriz_filename{size(matriz_filename,1),5} = Filename_5;

        end

        %Guardado de la estructuracon el agregado del nuevo objeto

        %save('app_data/current.mat','Writer','-append');
        save('app_data/current.mat','-v6','matriz_filename','-append');

    case 1
        i = 1;
        pos_actual = find(nmedicion{i}==pointer,1);
        while(isempty(pos_actual))
        i = i+1;
        pos_actual = find(nmedicion{i}==pointer,1);
        end

        fila_orden_actual = i;

        end_text = 'T0';  

        mics_actual = logico_ordenado(fila_orden_actual,3);

        %objectName_actual = objectName(mics_actual);

        %objectName_actual = objectName((mics_actual-1)* c_mics_simultaneo + 1:mics_actual*c_mics_simultaneo);

        for i = 1:c_mics_simultaneo

        n_fuente = logico_ordenado (fila_orden_actual,2); 
        fuente_TEXT = strcat('FNTE_',num2str(n_fuente));
        n_mics   = logico_ordenado (fila_orden_actual,3);
        mics_TEXT = strcat('MICS_',num2str(n_mics));

        obj = dsp.AudioFileWriter;    
        Filename = strcat(path,fuente_TEXT,'_',mics_TEXT,'_',objectName{mics_actual}{i},'_',end_text,'.wav');

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
        name = objectName{mics_actual}{i};
        Writer.(name) = obj;

        load('app_data/current.mat','corregido_filename')
        corregido_filename{size(corregido_filename,1) + 1,1} = Filename;
        save('app_data/current.mat','-v6','corregido_filename','-append');
        end


end

end

