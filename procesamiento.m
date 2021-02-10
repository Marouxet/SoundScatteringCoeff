load('app_data/current.mat','path');
load('app_data/settings.mat','typesignal');
load('app_data/settings.mat','c_fuentes_total');
load('app_data/orden.mat','logico_ordenado');
            %% CASO DE BARRIDOS SENODILAES
            if strcmp(typesignal,'SWEEP')
                
                %Preparo grabación en disco
            
                 %Guardado de las Respuestas Sweep en la carpeta temporal
                 temp_folder = strcat(path,'temp\');
                 save('app_data/current.mat','temp_folder','-append');
                 load('app_data/current.mat','username');
                 file_location = strcat(temp_folder,username,'\');
                 if exist(file_location,'dir') == 0    
                     %Create directory for measurement.
                     mkdir(temp_folder,username);
                 end
                    %To get the filter bank back.
                 file_loc = strcat(file_location,username,'_');
                 save('app_data/current.mat','file_loc','-append');
                 file_name = strcat(file_location,username,'_','Sweeps','.mat');
                 Respuestas = cell(0,0);
                 save(file_name,'Respuestas','-v7.3')
                 respuestas = matfile(file_name,'Writable',true);
                    
                
            %PRIMERO: re-organización de los archivos de audio y promediado de los sweeps que corresponden a mediciones GIRANDO la
            %muestra. 
            
            load('app_data/current.mat','Nombre_signal');
            load('app_data/current.mat','matriz_filename');
            load('app_data/orden.mat','nmedicion');
            load('app_data/settings.mat','objectName');
            load('app_data/settings.mat','c_mics_simultaneo');
            load('app_data/settings.mat','c_mics_total');
%            load('app_data/current.mat','SampleRate')
            load('app_data/current.mat','Nombre_filtroinverso');
            load('app_data/current.mat','octavas');

            SweepOrig = audioread(Nombre_signal); %Leo el sweep original, que lo uso para sincronizar los audios grabados

            l = 0; %Variable usada en un loop
            puntero_rta = 0; %Variable para indexar el vector de salida con los sweeps promediados
            o = 0;
            for i = 1:length(objectName) %ObjectName indica cuántos micrófonos fueron usado a la vez
                for j = 1:length(objectName{1})%Necesario porque objectName tiene un formato de Celdas 
                   puntero_rta = o*length(nmedicion)/ceil(c_mics_total/c_mics_simultaneo);
                    for k = 1:size(matriz_filename,1)%Recorro la matriz con los archivos de audio grabados
                    if strcmp(matriz_filename{k,3}, objectName{i}(j)) %Busco en la matriz aquellos archivos correspondientes a una posicion de mic
                        l = l + 1;
                        sub_matrix{l,1} =matriz_filename{k,1};          %   
                        sub_matrix{l,2} =matriz_filename{k,2};          %    Rearmo una matriz que tiene SOLO       
                        sub_matrix{l,3} =matriz_filename{k,3};          %    los audios de esa posicion de microfono  
                        sub_matrix{l,4} =matriz_filename{k,4};          %
                        sub_matrix{l,5} =matriz_filename{k,5};          %

                    end
                    end
                    
                    
                    sub_matrix2 = cell(0,0);
                    sub_matrix3 = cell(0,0);

                    for ft=1:c_fuentes_total; %size(sub_matrix,1)/4 %Cantidad de fuentes
                        for ft2 = 1:size(sub_matrix,1)
                      if strcmp(sub_matrix(1,2),sub_matrix(ft2,2))
                        sub_matrix2(size(sub_matrix2,1)+1,:) = sub_matrix(ft2,:);
                      else
                          sub_matrix3(size(sub_matrix3,1)+1,:) = sub_matrix(ft2,:);
                      end
                        end
                      sub_matrix = sub_matrix3;
                      sub_matrix3 = cell(0,0);
                    end
                    
                    % Ordeno por posiciones de fuente
                    
              sub_matrix = sub_matrix2;
              clear sub_matrix2
              clear sub_matrix3
              
              
                for n = 1:size(sub_matrix,1) %Usando la matriz construyo los nombres de los archivos de auido (la misma forma se usa en createWriterV2
                filename{n} = strcat(path,sub_matrix{n,1},'_',sub_matrix{n,2}, '_',sub_matrix{n,3},'_',sub_matrix{n,4},'_',sub_matrix{n,5});
                end        

                h = waitbar(0,strcat('Promediando Sweeps.  ', num2str(o+1), ' de',' '  ,num2str(length(objectName)*length(objectName{1}))));

                            for m = 1:length(nmedicion)/ceil(c_mics_total/c_mics_simultaneo); 

                                puntero_rta =  puntero_rta + 1;
                                 medicion = nmedicion{m};    %Medicion va de1 a un número depediendo del intervalo angulo

                                if length(medicion)==1      %Caso de la medicion SIN GIRAR
                                    Sweep = audioread(filename{medicion}); %Leo el archivo de audio actual

                                            %Elimino el LAG inicial, para que los impulsos sean
                                            %comparables. Uso una parte dela función
                                            %PromediosV2.m donde mediante la xcorrelacion con
                                            %el sweep original eleimino el silencio original
                                           [corr, lag]=xcorr(Sweep,SweepOrig);
                                            [~,I] = max(abs(corr));
                                            lagDiff = lag(I);
                                            if lagDiff<0
                                                lagDiff = - lagDiff;
                                            end
                                            Sweep = Sweep(lagDiff:end);

                                    respuestas.Respuestas(puntero_rta,2) = {Sweep}; %Lo guardo en una celda de Respuestas
                                    respuestas.Respuestas(puntero_rta,1) = {filename{medicion}}; %La celda de al lado indica qué archivo es

                                elseif length(medicion)~=1  %Caso de las mediciones GIRANDO
                                    suma = 0;               %En suma se van a ir sumando las mediciones de un mismo giro    
                                    registro = 1;
                                    for n_registro = medicion(1):medicion(end)
                                        Sweep = audioread(filename{n_registro}); %Leo el archivo de audio actual
                                        suma = PromediosV2(Sweep,SweepOrig,registro,suma); %Ajusto delay y polaridad segun CorrelacionCruzada y fase de FFT. Sumo
                                   registro = registro + 1;
                                    end
                                    respuestas.Respuestas(puntero_rta,2)={suma/length(nmedicion)}; %Promedio: divido la suma por la cantidad de mediciones
                                    %Respuestas (:,1) contiene la direccion del
                                    %archivo, para saber cuál es cual
                                    respuestas.Respuestas(puntero_rta,1)= {strcat(path,sub_matrix{medicion(1),1},'_' ,sub_matrix{medicion(1),2},'_' ,sub_matrix{medicion(1),3},'_',sub_matrix{medicion(1),4},'_','G','.wav')};
                                end
                                waitbar(m/(length(nmedicion)/ceil(c_mics_total/c_mics_simultaneo)),h)
                         end
                            o = o +1;

            clear sub_matrix %Reinicio sub_matrix, ya que va a ser llenada con los archivos de otra posicion de microfono
            clear filename   %Reinicio filename, por la misma razon
            l = 0;           %Vuelvo el contador a cero
            close(h)
                end
            end

%%%%%Ordeno logico_ordenado de igual manera que los cambios en la lista de archivos

 logico_ordenado_1 = zeros(size(logico_ordenado));
[~,a] = sort(logico_ordenado(:,2));
for i =1:length(logico_ordenado)
logico_ordenado_1(i,:) = logico_ordenado(a(i),:);
end
logico_ordenado_11 = zeros(size(logico_ordenado));
[~,b] = sort(logico_ordenado_1(:,3));
for i =1:length(logico_ordenado)
logico_ordenado_11(i,:) = logico_ordenado_1(b(i),:);
end
            
            
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %Guardado de las Respuestas Sweep en la carpeta temporal
%             %     load('app_data/settings.mat','temp_folder');
%                 temp_folder = strcat(path,'temp\');
%                 save('app_data/current.mat','temp_folder','-append');
%                  load('app_data/current.mat','username');
%                  file_location = strcat(temp_folder,username,'\');
%                  if exist(file_location,'dir') == 0    
%                      %Create directory for measurement.
%                      mkdir(temp_folder,username);
%                  end
%                     %To get the filter bank back.
%                  file_loc = strcat(file_location,username,'_');
%                  save('app_data/current.mat','file_loc','-append');
%                  file_name = strcat(file_location,username,'_','Sweeps','.mat');
%                  save(file_name,'Respuestas')
% 
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Deconvolución
                        %Deconvolución
                 Irs = cell(0,0);
                 load('app_data/current.mat','temp_folder');
                 load('app_data/current.mat','username');
                 file_location = strcat(temp_folder,username,'/');
                 if exist(file_location,'dir') == 0    
                     %Create directory for measurement.
                     mkdir(temp_folder,username);
                 end
                    %To get the filter bank back.
                 file_loc = strcat(file_location,username,'_');
                 save('app_data/current.mat','file_loc','-append');
                 file_name = strcat(file_location,username,'_','Irs','.mat');
                 save(file_name,'Irs','-v7.3')
                 irs = matfile(file_name,'Writable',true);
                 clear Irs
                 
            load(Nombre_filtroinverso);
            
            %Determino tamaño de "respuestas"
            [nrows,ncols] = size(respuestas,'Respuestas');
            
            h = waitbar(0,'Aplicando Filtro Inverso...');
           % Irs = cell(size(Respuestas));
            for i = 1:nrows
                current_Respuesta = respuestas.Respuestas(i,2);
                current_Respuesta = current_Respuesta{:};
                irLin = extractIRfromSweep(current_Respuesta, inversefiltersweepfft);
                irs.Irs(i,2) = {irLin};
                irs.Irs(i,1) = respuestas.Respuestas(i,1);
                %Irs{i,2} = irLin;
                waitbar(i/nrows,h)
            end
           % Irs(:,1) = Respuestas(:,1);
         close(h)
%%
            else
%% CASO DE SEÑALES MLS
            %PRIMERO: re-organización de los archivos de audio y promediado de los sweeps que corresponden a mediciones GIRANDO la
            %muestra. 
            
            %Preparo grabación en disco
            
            %Guardado de las Respuestas Sweep en la carpeta temporal
                temp_folder = strcat(path,'temp\');
                save('app_data/current.mat','temp_folder','-append');
                 load('app_data/current.mat','username');
                 file_location = strcat(temp_folder,username,'\');
                 if exist(file_location,'dir') == 0    
                     %Create directory for measurement.
                     mkdir(temp_folder,username);
                 end
                    %To get the filter bank back.
                 file_loc = strcat(file_location,username,'_');
                 save('app_data/current.mat','file_loc','-append');
                 file_name = strcat(file_location,username,'_','MLS','.mat');
                 Respuestas = cell(0,0);
                 save(file_name,'Respuestas','-v7.3')
                 respuestas = matfile(file_name,'Writable',true);
            %Comienzo procesamiento
            load('app_data/current.mat','Nombre_signal');
            load('app_data/current.mat','matriz_filename');
            load('app_data/orden.mat','nmedicion');
            load('app_data/settings.mat','objectName');
            load('app_data/settings.mat','c_mics_simultaneo');
            load('app_data/settings.mat','c_mics_total');
            load('app_data/settings.mat','SampleRate')
            load('app_data/current.mat','octavas');

 
            l = 0; %Variable usada en un loop
            puntero_rta = 0; %Variable para indexar el vector de salida con los sweeps promediados
            o = 0;
            for i = 1:length(objectName) %ObjectName indica cuántos micrófonos fueron usado a la vez
                for j = 1:length(objectName{1})%Necesario porque objectName tiene un formato de Celdas 
                   puntero_rta = o*length(nmedicion)/ceil(c_mics_total/c_mics_simultaneo);

                   % Ordeno por posiciones de micrófono
                    for k = 1:size(matriz_filename,1)%Recorro la matriz con los archivos de audio grabados
                    if strcmp(matriz_filename{k,3}, objectName{i}(j)) %Busco en la matriz aquellos archivos correspondientes a una posicion de mic
                        l = l + 1;
                        sub_matrix{l,1} =matriz_filename{k,1};          %   
                        sub_matrix{l,2} =matriz_filename{k,2};          %    Rearmo una matriz que tiene SOLO       
                        sub_matrix{l,3} =matriz_filename{k,3};          %    los audios de esa posicion de microfono  
                        sub_matrix{l,4} =matriz_filename{k,4};          %
                        sub_matrix{l,5} =matriz_filename{k,5};          %

                    end
                    end
                    sub_matrix2 = cell(0,0);
                    sub_matrix3 = cell(0,0);

                    for ft=1:size(sub_matrix,1)/4 %Cantidad de fuentes
                        for ft2 = 1:size(sub_matrix,1)
                      if strcmp(sub_matrix(1,2),sub_matrix(ft2,2))
                        sub_matrix2(size(sub_matrix2,1)+1,:) = sub_matrix(ft2,:);
                      else
                          sub_matrix3(size(sub_matrix3,1)+1,:) = sub_matrix(ft2,:);
                      end
                        end
                      sub_matrix = sub_matrix3;
                      sub_matrix3 = cell(0,0);
                    end
                    
                    % Ordeno por posiciones de fuente
                    
              sub_matrix = sub_matrix2;
              clear sub_matrix2
              clear sub_matrix3
              
                for n = 1:size(sub_matrix,1) %Usando la matriz construyo los nombres de los archivos de auido (la misma forma se usa en createWriterV2
                filename{n} = strcat(path,sub_matrix{n,1},'_',sub_matrix{n,2}, '_',sub_matrix{n,3},'_',sub_matrix{n,4},'_',sub_matrix{n,5});
                end        

                h = waitbar(0,strcat('Promediando Secuencia MLS.  ', num2str(o+1), ' de',' '  ,num2str(length(objectName)*length(objectName{1}))));

                            for m = 1:length(nmedicion)/ceil(c_mics_total/c_mics_simultaneo); 

                                    puntero_rta =  puntero_rta + 1;
                                    medicion = nmedicion{m};    %Medicion va de1 a un número depediendo del intervalo angulo
                                    MLS = audioread(filename{medicion}); %Leo el archivo de audio actual
                                    respuestas.Respuestas(puntero_rta,2) = {MLS}; %Lo guardo en una celda de Respuestas dentro de la variable en disco!
                                    respuestas.Respuestas(puntero_rta,1) = {filename{medicion}}; %La celda de al lado indica qué archivo es
                                    waitbar(m/(length(nmedicion)/ceil(c_mics_total/c_mics_simultaneo)),h)

                            end
                            o = o +1;

            clear sub_matrix %Reinicio sub_matrix, ya que va a ser llenada con los archivos de otra posicion de microfono
            clear filename   %Reinicio filename, por la misma razon
            l = 0;           %Vuelvo el contador a cero
            close(h)
                end
            end
%              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             %Guardado de las Respuestas Sweep en la carpeta temporal
%             %     load('app_data/settings.mat','temp_folder');
%                 temp_folder = strcat(path,'temp\');
%                 save('app_data/current.mat','temp_folder','-append');
%                  load('app_data/current.mat','username');
%                  file_location = strcat(temp_folder,username,'\');
%                  if exist(file_location,'dir') == 0    
%                      %Create directory for measurement.
%                      mkdir(temp_folder,username);
%                  end
%                     %To get the filter bank back.
%                  file_loc = strcat(file_location,username,'_');
%                  save('app_data/current.mat','file_loc','-append');
%                  file_name = strcat(file_location,username,'_','MLS','.mat');
%                  save(file_name,'Respuestas')

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            
            
            clear Respuestas
            

            %Deconvolución
            Irs = cell(0,0);
            
                 load('app_data/current.mat','temp_folder');
                 load('app_data/current.mat','username');
                 file_location = strcat(temp_folder,username,'/');
                 if exist(file_location,'dir') == 0    
                     %Create directory for measurement.
                     mkdir(temp_folder,username);
                 end
                    %To get the filter bank back.
                 file_loc = strcat(file_location,username,'_');
                 save('app_data/current.mat','file_loc','-append');
                 file_name = strcat(file_location,username,'_','Irs','.mat');
                 save(file_name,'Irs','-v7.3')
                 
                 irs = matfile(file_name,'Writable',true);
                 clear Irs
                 
            load('app_data/current.mat','mls_orden');
            load('app_data/current.mat','repet_mls');
            h = waitbar(0,'Deconvolucionando Señal MLS...');
            %Irs = cell(size(Respuestas));
            
                        %Determino tamaño de "respuestas"
            [nrows,ncols] = size(respuestas,'Respuestas');
            
            for i = 1:nrows
                current_Respuesta = respuestas.Respuestas(i,2);
                current_Respuesta = current_Respuesta{:};
                ir = AnalyseMLSSequence(current_Respuesta,mls_orden,repet_mls);
                irs.Irs(i,2) = {ir};
                irs.Irs(i,1) = respuestas.Respuestas(i,1);
                waitbar(i/nrows,h)
            end
      %      Irs(:,1) = Respuestas(:,1);
            close(h)    
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A PARTIR DE ACÁ EL PROGRAMA ES IGUAL YA SEA PARA SWEEPS O PARA MLS. SE GUARDAN LOS IMPULSOS, SE FILTRA Y SE PROCESA


% %Guardado de las Respuestas Al impulso en la carpeta temporal
%      load('app_data/current.mat','temp_folder');
%      load('app_data/current.mat','username');
%      file_location = strcat(temp_folder,username,'/');
%      if exist(file_location,'dir') == 0    
%          %Create directory for measurement.
%          mkdir(temp_folder,username);
%      end
%         %To get the filter bank back.
%      file_loc = strcat(file_location,username,'_');
%      save('app_data/current.mat','file_loc','-append');
%      file_name = strcat(file_location,username,'_','Irs','.mat');
%      save(file_name,'Irs')
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Filtrado
w_filters = waitbar(0,'Filtrando respuestas al impulso. Por favor, espere');

if octavas == 1
    bands = 10;
elseif octavas ==3
    bands = 30;
end   
load(file_name,'Irs')
for i = 1:bands
    apply_filters(Irs(:,2),i);
    waitbar (i/bands,w_filters);
end
close(w_filters)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bands = 10;
% octavas = 1;
%Calculo de la integral de Schroeder 
%Algortimo de Lundebys para encontrar el punto de corte entre IR y ruido

%Hay que importar al workspace alguna banda de mapf. Que es el resultado
%del filtrado.
%bands = 30;
     load('app_data/current.mat','path');
     load('app_data/current.mat','temp_folder');
     load('app_data/current.mat','username');
     load('app_data/settings.mat','SampleRate');
     load('app_data/filtros.mat','fc_octava');
     load('app_data/filtros.mat','fc_tercios');

     file_location = strcat(temp_folder,username,'/');
     w_sch = waitbar(0,'Calculando Integral de Schroeder...');
for i = 1:bands
    if octavas ==1
            fc_num = num2str(round(fc_octava(i)));
            file_name = strcat(file_location,username,'_','IRs','_',fc_num,'.mat'); %File name
            load(file_name,'map_f')
    elseif octavas ==3
            fc_num = num2str(round(fc_tercios(i)));
            file_name = strcat(file_location,username,'_','IRs','_',fc_num,'.mat'); %File name
            load(file_name,'map_f')
    end
            for j = 1:length(map_f)
                %[p,C] = lundeby(map_f{j},SampleRate);
                %sch{j} = 10*log10(flipud(cumsum(flipud(map_f{j}(1:p).^2)))/max(flipud(cumsum(flipud(map_f{j}(1:p).^2))))) + C;
                schkk = 10*log10((cumsum(flipud(map_f{j}.^2))));
                schkk = schkk-max(schkk);
                p2 = length(schkk) - find(schkk>-40,1);
                sch{j} = 10*log10(flipud(cumsum(flipud(map_f{j}(1:p2).^2))));
            end

             file_name = strcat(file_location,username,'_','SCH','_',fc_num,'.mat'); %File name
             save(file_name,'sch')
             nombres_sch{i} = {file_name};
             waitbar (i/bands,w_sch);
end
close(w_sch)
save('app_data\current.mat','nombres_sch','-append');
%Calculo del Tiempo de Reverberación
%load('app_data/orden.mat','logico_ordenado')
%tipo_medicion = [logico_ordenado(:,1) logico_ordenado(:,4)]; %estas dos columnas me dicen si es con o sin muestra, con o sin rotacion

    w_tr = waitbar(0,'Calculando Tiempo de Reverberacion...');
for i = 1:bands
    if octavas ==1
            fc_num = num2str(round(fc_octava(i)));
            file_name = strcat(file_location,username,'_','SCH','_',fc_num,'.mat'); %File name
            load(file_name,'sch')
    elseif octavas ==3
            fc_num = num2str(round(fc_tercios(i)));
            file_name = strcat(file_location,username,'_','SCH','_',fc_num,'.mat'); %File name
            load(file_name,'sch')
    end

sch_filtrado_actual = sch;

 TR_actual = cell(length(sch_filtrado_actual),1);
 
 logico_ordenado2 = zeros(length(sch_filtrado_actual),4);
 for ii = 1:c_mics_total*c_fuentes_total
     logico_ordenado2((ii-1)*length(logico_ordenado_11)+1:ii*length(logico_ordenado_11),:) = logico_ordenado_11(:,:);
 end
 
for j = 1:length(sch_filtrado_actual) %El largo de sch_filtrado_actual siempre es un múltiplo de 4.
    A = fix((j-1)/4);
   actual = sch_filtrado_actual{j}-max(sch_filtrado_actual{j}); %Normalizo en dB
   actual = actual(length(actual) - find(flipud(actual) >= -1) : end); %Revierto en tiempo para encontrar cuando llega a -1 dB. No me impota perder info porque para el TR tengo que ir desde -5 a -25. Corto de ahi al final
    
   ini = find(actual < -5,1); %Inicio de la regresión
   if logico_ordenado2(j,4) == 0; %Se trata de una medición SIN GIRAR-->Calculo de t20
       %fin_t20 = find(actual < -25,1); %Fin de la regresion
       fin_t20 = find(actual < -25,1);
       time = 1:length(actual); %Vector temporal de la regresion
       P_t20= polyfit(time(ini:fin_t20)',actual(ini:fin_t20),1); %Cuadrados minimos de la curva entre -5 y -25 dB
       recta_t20 = polyval(P_t20,time); %Evaluacion de la curva en el vector temporal
       
    if logico_ordenado2(j,1) == 0  % Se trata de medicion Sin muestra --> es T1
               if  ~isempty(fin_t20)
                 TR_actual {4*A+1} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*A+1} = 'StN';
               end
    else                                  % Se trata de medicion Con muestra --> es T2
               if  ~isempty(fin_t20)
                  TR_actual {4*A+2} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*A+1} = 'StN';
              end
    end
        
     sch_actual{j} = actual;
     recta_actual{j} = recta_t20;
     time_actual{j} = time;
     
   elseif logico_ordenado2(j,4) == 1; %%Se trata de una medición GIRANDO --> Calculo de t15
       %Para verificar que T15 es calculado sobre una sola pendiente,
       %calculo varias rectas con distintos intervalos de integración y
       %comparo el valor de las pendientes
       
       %fin_t08 = find(actual < -13,1);
       %fin_t10 = find(actual < -15,1);
       %fin_t12 = find(actual < -12,1);
       fin_t15 = find(actual < -20,1);
      % fin_t20 = find(actual < -25,1); 
       time = 1:length(actual);%Vector temporal de la regresio
       
        %Evaluo cada recta
        %P_t08= polyfit(time(ini:fin_t08)',actual(ini:fin_t08),1);
        %P_t10= polyfit(time(ini:fin_t10)',actual(ini:fin_t10),1);
        %P_t12= polyfit(time(ini:fin_t12)',actual(ini:fin_t12),1);
       P_t15= polyfit(time(ini:fin_t15)',actual(ini:fin_t15),1);
      % P_t20= polyfit(time(ini:fin_t20)',actual(ini:fin_t20),1); 
        %verificación de que la T15 incluye una sola pendiente
       % promedio = (P_t10 + P_t12 )/2;
        
%         if P_t15/promedio >1.2;
%         T15_actual {j} = 'Inconsistente';
%         
%         elseif P_t15/promedio<0.8;
%         T15_actual {j} = 'Inconsistente';      
%         else
        recta_t15= polyval(P_t15,time);
        recta_t20= polyval(P_t20,time);
         if logico_ordenado2(j,1) == 0  % Se trata de medicion Sin muestra --> es T3
               if  ~isempty(fin_t15)
                 TR_actual {4*A+3} =  (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate; 
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*A+3} = 'StN';
               end
%                if  ~isempty(fin_t15)
%                  TR_actual {4*A+3} =  (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate; 
%                else
%                  %no hay suficiente relacion señal a ruido
%                  TR_actual {4*A+3} = 'StN';
%                end
    else                                  % Se trata de medicion Con muestra --> es T4
               if  ~isempty(fin_t15)
                  TR_actual {4*A+4} = (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate;
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*A+4} = 'StN';
              end
         end
    
   end
   

end

TR{i} = TR_actual;
clear T20_actual

waitbar (i/bands,w_tr);
end
close(w_tr)


file_name = strcat(file_location,username,'_','TR','.mat'); %File name
save(file_name,'TR')


%procesamiento_corregido


%Pase de TR a Matriz Numérica
%w_coef = waitbar(0,'Calculando Coeficientes...');
%%Calculo de coeficientes de Absorcion de aire y Velocidad del Sonido
load('app_data/settings.mat','c_fuentes_total');
load('app_data/current.mat','temp')
vel_son = 343.2*sqrt((273.15+temp)/293.15);
load('app_data/current.mat','abs_aire')
load('app_data/current.mat','hum')

%Coeficientes = cell(size(TR));

%Momentaneo
T0 = cell(size(TR));

for i = 1:length(T0)
    T0{i} = cell(size(TR{1}));
end

clear i

   TR_num = zeros(length(TR{1}),length(TR));
    for i = 1:size(TR_num,2)
    for j = 1:size(TR_num,1)
        if isempty (TR{i}{j})
            TR_num(j,i) = 0;
        else
    TR_num(j,i) = TR{i}{j};
        end
    end
    end
    
   T0_num = zeros(length(T0{1}),length(T0));
    for i = 1:size(T0_num,2)
    for j = 1:size(T0_num,1)
         if isempty (T0{i}{j})
             T0_num(j,i) = 0;
         else
        T0_num(j,i) = T0{i}{j};
         end
    end
    end
    
clear i
clear j



X=length(TR{1})/4; % Combinaciones total de fuentes y mics
Resultados = cell(1,X);

for i= 1:X
     Resultados{i}(1:4,:) = TR_num((i-1)*4+1:4*i,:);
     Resultados{i}(5,:) = T0_num((i-1)*4+1,:);
end


if octavas ==1
    mf = cell(1,10);
    velocidad = cell(1,10);
    fc = fc_octava;
else
    mf = cell(1,30);
    velocidad = cell(1,10);
    fc = fc_tercios;
end

if octavas ==1
    mf = cell(1,10);
    velocidad = cell(1,10);
    fc = fc_octava;
else
    mf = cell(1,30);
    velocidad = cell(1,10);
    fc = fc_tercios;
end

for j = 1:length(Resultados)
          
    for i = 1:length(fc)

        if abs_aire ==1
            m1 = air_absorption(fc(i),temp(1),hum(1),1)/4.343;
            c1 = 343.2*sqrt((273.15+temp(1))/293.15);
            m2 = air_absorption(fc(i),temp(2),hum(2),1)/4.343;
            c2 = 343.2*sqrt((273.15+temp(2))/293.15);
            m3 = air_absorption(fc(i),temp(3),hum(3),1)/4.343;
            c3 = 343.2*sqrt((273.15+temp(3))/293.15);
            m4 = air_absorption(fc(i),temp(4),hum(4),1)/4.343;
            c4 = 343.2*sqrt((273.15+temp(4))/293.15);
        else
            m1 = 0;
            c1 = 343.2*sqrt((273.15+temp(1))/293.15);
            m2 = 0;
            c2 = 343.2*sqrt((273.15+temp(2))/293.15);
            m3 = 0;
            c3 = 343.2*sqrt((273.15+temp(3))/293.15);
            m4 = 0;
            c4 = 343.2*sqrt((273.15+temp(4))/293.15);
        end

Resultados{j}(6,i) = m1;
Resultados{j}(7,i) = m2;
Resultados{j}(8,i) = m3;
Resultados{j}(9,i) = m4;
Resultados{j}(10,i) = c1;
Resultados{j}(11,i) = c2;
Resultados{j}(12,i) = c3;
Resultados{j}(13,i) = c4;
                
    end      
end
        

load('app_data/current.mat','vol_camara');
load('app_data/current.mat','sup_muestra');

%Calculo de Coeficientes (Alpha_s -  Alpha_spec - S -
%- Splate - Alpha_plate - Scorreg)

%Resultados = Resultados;


for j =  1:length(Resultados)
    
    
    R = Resultados{j};
    
    %Alpha_S es Resultados 14
            R(14,:) =   55.3*vol_camara/sup_muestra.*...
                        (1./(R(11,:).*R(2,:))-1./(R(10,:).*R(1,:)))-...
                        4*vol_camara/sup_muestra.*(R(7,:)-R(6,:));
        
    %Alpha_Spec es Resultados 15
            R(15,:) =   55.3*vol_camara/sup_muestra.*...
                        (1./(R(13,:).*R(4,:))-1./(R(12,:).*R(3,:)))-...
                        4*vol_camara/sup_muestra.*(R(9,:)-R(8,:)); 
                    
    %  S  es Resultados 16      
    
            R(16,:) = (R(15,:)-R(14,:))./(1-R(14,:));
   
     % S_plate es Resultados 17  
            R(17,:) =   55.3*vol_camara/sup_muestra.*...
                        (1./(R(12,:).*R(3,:))-1./(R(10,:).*R(1,:)))-...
                        4*vol_camara/sup_muestra.*(R(8,:)-R(6,:)); 
            
    %Alpha_plate es Resultados 18
    
    
    %Scorr es Resultados 19

Resultados{j} = R;
clear R
%waitbar (i/bands,w_coef);
end

%Truncamiento de valores cero, conservacion de 2 decimales y promediado


        for i = 1:length(Resultados)
            for j = 1:5
                
                for k  = 1:size(Resultados{1},2)
                
                    if Resultados{i}(j,k)<0
                        Resultados{i}(j,k) = 0.00;
                    else
                        Resultados{i}(j,k) = round(Resultados{i}(j,k)*100)/100;
                    end
                    
                end
            end
                
            for j = 10:size(Resultados{1},1)
                
                for k  = 1:size(Resultados{1},2)
                
                    if Resultados{i}(j,k)<0
                        Resultados{i}(j,k) = 0.00;
                    else
                       Resultados{i}(j,k) = round(Resultados{i}(j,k)*100)/100;
                    end
                    
                end
                
                
            end
        end

Resultados = [Resultados cell(1,1)];

Resultados{length(Resultados)}=zeros(size(Resultados{1}));       
for i = 1:length(Resultados)-1
    
    for j = 1:size(Resultados{1}, 1)
        for k = 1:size(Resultados{1},2)
            
            Resultados{length(Resultados)}(j,k) = Resultados{length(Resultados)}(j,k) + Resultados{i}(j,k);
        end
    end  
    
    
end
Resultados{length(Resultados)}=Resultados{length(Resultados)}./(length(Resultados)-1);
        
         file_name = strcat(file_location,username,'_','Coeficientes','.mat'); 
         save(file_name,'Resultados');
         save('app_data\current.mat','file_name','-append');

%   close(w_coef)
export_excel               
