%%Medición corregida
global flag_rec
load('app_data/settings.mat','scat_corregido');
pointer = pointer -1;
if pointer == 0
    pointer = 1;
end
if scat_corregido == 1
A = questdlg('Se realizará la medición de T0, el tiempo de reverberación del recinto utilizado SIN la muestra y SIN la mesa giratoria. Vacio!. Por favor, seleccione "Continuar" si desea realizar la medición ahora, o "Postergar" si desea medir T0 una vez finalizadas el resto de las mediciones','Medición de T0 para Coef. Corregido','Continuar','Postergar','Continuar');
else
A = 'Continuar';    
end

switch A

                
                
    case 'Continuar'
        
            
                load('app_data/current.mat','corregido_filename')
                corregido_filename = cell(0,0);
                save('app_data/current.mat','-v6','corregido_filename','-append');
    %% Grabación
    load('app_data/orden.mat','orden');
    load('app_data/orden.mat','logico_ordenado');
    load('app_data/orden.mat','nmedicion');
    load('app_data/settings.mat','typesignal')

    k = 1;
    posi_actual = find(nmedicion{k}==pointer,1); %Vacio si nmedicion{i} no es igual a pointer, da el número en caso de q lo sea
    while(isempty(posi_actual))
    k = k+1;
    posi_actual = find(nmedicion{k}==pointer,1);
    end
    fila_actual= k;
    
    n_fuente = logico_ordenado (k,2); %Encuentro qué fuente/mic tengo en la actualidad, para comenzar por ellas
    n_mics   = logico_ordenado (k,3);
    
    if pointer == 1
        logico_ord = logico_ordenado(find(logico_ordenado(:,1) == 0),:); %Elimino una columna
        filas = 2:2:size(logico_ord,1);
        orden_corregido = logico_ord(filas,2:3); %Orden_corregido tiene el orden de fuente/mic que debe seguirse en la medicion
                                                  % corregida, siguiendo
                                                  % las preferencias del
                                                  % usuario
    else
        logico_ord = logico_ordenado(find(logico_ordenado(:,1) == 0),:); %Elimino una columna
        filas = 2:2:size(logico_ord,1);
        orden_corregido = flipud(logico_ord(filas,2:3));
    end
   save('app_data/current.mat','orden_corregido','-append')
    %%Cartel de aviso
    text = strcat('Se comienza con la Posición de fuente:',num2str(n_fuente),' y la combinación de micrófonos:', num2str(n_mics),'. Presione "Continuar cuando esté listo para medir');
    B = questdlg(text,'Medición de T0 para Coef. Corregido','Continuar','Continuar');
    switch B
    case 'Continuar'
        anterior = orden_corregido(1,:); %Cargo si es con o sin muestra, qué  fuente, que combinacion de mics

        for i =1:size(orden_corregido,1);
       %%  Chequeo si hay algún cambio en las posiciones
                    actual = orden_corregido(i,:);
                    cambio = find(actual - anterior ~= 0);

                    if isempty(cambio)

                    elseif cambio ==1;
                            n_fuente = orden_corregido (i,1); 
                            text = strcat('Por favor, cambie la posición de fuente. Posición siguiente: ', num2str(n_fuente),' Presione OK para continuar');
                            uiwait(msgbox(text,'Cambio de medición')); 
                    elseif cambio ==2;
                            n_mics = orden_corregido (i,2); 
                            text = strcat('Por favor, cambie la posición de Micrófono. Posición siguiente: ', num2str(n_mics),' Presione OK para continuar');
                            uiwait(msgbox(text,'Cambio de medición')); 
                    end
    
        %% Cargo Variables
                    load('app_data/current.mat','Nombre_signal')
                    load('app_data/settings.mat','SamplesPerFrame')
                    load('app_data/settings.mat','nBits');
                    load('app_data/settings.mat','ChannelMapping');
                    load('app_data/settings.mat','c_mics_simultaneo');
                    load('app_data/settings.mat','BufferSize');
                    load('app_data/settings.mat','QueueDuration');
                    load('app_data/settings.mat','DeviceName');
                    load('app_data/settings.mat','SampleRate');
                    load('app_data/settings.mat','nBits');
                    load('app_data/settings.mat','ChannelMappingOut');
                    load('app_data/settings.mat','c_fuentes_total');
                    load('app_data/settings.mat','c_fuentes_simultaneo');
                    load('app_data/settings.mat','mon')
                    load('app_data/settings.mat','objectName');
                    load('app_data/current.mat','path');
        %% Creo el Reader    

                    Reader = dsp.AudioFileReader;
                    Reader.Filename = Nombre_signal;
                    Reader.PlayCount = 1;

                    Reader.SamplesPerFrame = SamplesPerFrame;

                    if nBits == 16
                        Reader.OutputDataType = 'int16';
                    else
                        Reader.OutputDataType ='single';
                    end
        %% Creo el Recorder

                    mics_actual = orden_corregido(i,2);

                    for j = 1:c_mics_simultaneo
                    ChannelMappingNum(j)= str2double(ChannelMapping{mics_actual}{j}(end:end));
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
       %% Creo el Player

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


                    fuente_actual = orden_corregido(i,1);

                    if mon ==1
                        for j = 1:length(ChannelMappingOut{fuente_actual})%Sumo 1 por la salida de monitoreo;
                        ChannelMappingNum(j)= str2double(ChannelMappingOut{fuente_actual}{j}(end:end));
                        end
                    else
                        for j = 1:length(ChannelMappingOut{fuente_actual})
                        ChannelMappingNum(j)= str2double(ChannelMappingOut{fuente_actual}{j}(end:end));
                        end   
                    end

                    Player.ChannelMapping = ChannelMappingNum;
        %% Creo el Writer

                          end_text = 'T0';  
                          mics_actual = orden_corregido(i,2);

                 for j = 1:c_mics_simultaneo

                n_fuente = orden_corregido (i,1); 
                fuente_TEXT = strcat('FNTE_',num2str(n_fuente));
                n_mics   = orden_corregido (i,2);
                mics_TEXT = strcat('MICS_',num2str(n_mics));

                obj = dsp.AudioFileWriter;    
                Filename = strcat(path,fuente_TEXT,'_',mics_TEXT,'_',objectName{mics_actual}{j},'_',end_text,'.wav');
   
                Filename_1 = fuente_TEXT;
                Filename_2 = mics_TEXT;
                Filename_3 = objectName{mics_actual}{j};
                Filename_4 = strcat(end_text,'.wav');


        
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
                name = objectName{mics_actual}{j};
                Writer.(name) = obj;

                load('app_data/current.mat','corregido_filename')
                
                corregido_filename{size(corregido_filename,1) + 1,1} = Filename_1;
                corregido_filename{size(corregido_filename,1),2} = Filename_2;
                corregido_filename{size(corregido_filename,1),3} = Filename_3;
                corregido_filename{size(corregido_filename,1),4} = Filename_4;
                save('app_data/current.mat','-v6','corregido_filename','-append');
                 
                 
                end
                 
                 
                 %Limpiado de Variables
                clear previous_pointer
                clear fila_orden_actual
                clear muestra_actual
                clear nmedicion
                clear logico_ordenado
                clear orden
                clear pos_actual
                clear cambio
                clear Nombre_signal
                clear SamplesPerFrame
                clear nBits
                clear ChannelMapping
                clear c_mics_simultaneo
                clear DeviceName
                clear ChannelMappingOut
                clear c_fuentes_total
                clear c_fuentes_simultaneo
                clear mon
                clear objectName
                clear ChannelMappingNum
                clear Filename
                clear anterior
                clear corregido_filename
                clear end_text
                clear fuente_TEXT
                clear mcs_TEXT
                clear name
                clear obj
                clear text
       

    
    switch typesignal
        
            case 'MLS'
                             
            load('app_data/settings.mat','sec_factor');
            load('app_data/settings.mat','c_mics_simultaneo');
            load('app_data/settings.mat','objectName');
            load('app_data/current.mat','monitoreo');
            load('app_data/settings.mat','SamplesPerFrame');
            

memory = zeros(Record.BufferSize,length(Record.ChannelMapping));
silencio = zeros(Record.BufferSize,1);
latency = (QueueDuration * SampleRate + 2 * BufferSize)/SampleRate;

release(handles.hts)
while  flag_rec ==1 
   
    if ~isDone(Reader)
        
        if monitoreo ==0
        play = [step(Reader) silencio];
        else
        play =[step(Reader) memory(:,monitoreo)];
        end
        
        step(Player, play);
        memory = step(Record);  
        
         for j = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{j};
            step(Writer.(name), memory(:,j));
         end
  
  
    else
        fin_grabacion = tic;
        while toc(fin_grabacion)<latency + sec_factor
        
             if monitoreo ==0
        play = [step(Reader) silencio];
             else
        play =[step(Reader) memory(:,monitoreo)];
             end

            step(Player, play);
          memory = step(Record); 
        
            for i = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{i};
            step(Writer.(name), memory(:,i));
            end
            
        switch c_mics_simultaneo 
             case 1
                     step(handles.hts,memory(:,1))
             case 2
                     step(handles.hts,memory(:,1), memory(:,2))
             case 3
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3))
             case 4
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3), memory(:,4))
         end

        end
            flag_rec = 0;
        
    end

end

flag_rec = 1;
%%%%%Libero los objetos!

release(Record);
release(Player);
release(Reader);

for i =1:c_mics_simultaneo;
name = objectName{mics_actual}{i};
release(Writer.(name));
end

anterior = actual;

            case 'SWEEP'
                             
load('app_data/settings.mat','sec_factor');
load('app_data/settings.mat','c_mics_simultaneo');
load('app_data/settings.mat','objectName');
load('app_data/current.mat','monitoreo');
load('app_data/settings.mat','SamplesPerFrame');

memory = zeros(Record.BufferSize,length(Record.ChannelMapping));
silencio = zeros(Record.BufferSize,1);
latency = (QueueDuration * SampleRate + 2 * BufferSize)/SampleRate;

release(handles.hts)
while  flag_rec ==1 
   
    if ~isDone(Reader)
        
        if monitoreo ==0
        play = [step(Reader) silencio];
        else
        play =[step(Reader) memory(:,monitoreo)];
        end
        
        step(Player, play);
        memory = step(Record);  
        
         for j = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{j};
            step(Writer.(name), memory(:,j));
         end
  
         switch c_mics_simultaneo 
             case 1
                     step(handles.hts,memory(:,1))
             case 2
                     step(handles.hts,memory(:,1), memory(:,2))
             case 3
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3))
             case 4
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3), memory(:,4))
         end
                
    else
        fin_grabacion = tic;
        while toc(fin_grabacion)<latency + sec_factor
        
             if monitoreo ==0
        play = [step(Reader) silencio];
             else
        play =[step(Reader) memory(:,monitoreo)];
             end

            step(Player, play);
          memory = step(Record); 
        
            for i = 1:c_mics_simultaneo;
            name = objectName{mics_actual}{i};
            step(Writer.(name), memory(:,i));
            end
            
                switch c_mics_simultaneo 
             case 1
                     step(handles.hts,memory(:,1))
             case 2
                     step(handles.hts,memory(:,1), memory(:,2))
             case 3
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3))
             case 4
                     step(handles.hts,memory(:,1), memory(:,2), memory(:,3), memory(:,4))
                 end

        end
            flag_rec = 0;
        
    end

end

flag_rec = 1;
%%%%%Libero los objetos!

release(Record);
release(Player);
release(Reader);

for i =1:c_mics_simultaneo;
name = objectName{mics_actual}{i};
release(Writer.(name));
end

anterior = actual;
    end
        
 end
    %%
    
    
    case 'Cancelar'
    end
    case 'Postergar'
    scat_corregido = 2; %Medición de T0 al final
    save('app_data/settings.mat','-v6','scat_corregido','-append');
    clear scat_corregido
end


    