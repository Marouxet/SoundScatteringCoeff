tic;
load('app_data/current.mat','path');
load('app_data/settings.mat','typesignal');

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
            load('app_data/current.mat','SampleRate')
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
                waitbar(i/length(Respuestas),h)
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
    waitbar (i/length(Irs),w_filters);
end
close(w_filters)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bands = 10;
octavas = 1;
%Calculo de la integral de Schroeder y otras yerbas
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
                [p,C] = lundeby(map_f{j},SampleRate);
                sch{j} = 10*log10(flipud(cumsum(flipud(map_f{j}(1:p).^2)))/max(flipud(cumsum(flipud(map_f{j}(1:p).^2))))) + C;
            end

             file_name = strcat(file_location,username,'_','SCH','_',fc_num,'.mat'); %File name
             save(file_name,'sch')
end


%Calculo del Tiempo de Reverberación
load('app_data/orden.mat','logico_ordenado')
%tipo_medicion = [logico_ordenado(:,1) logico_ordenado(:,4)]; %estas dos columnas me dicen si es con o sin muestra, con o sin rotacion

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
for j = 1:length(sch_filtrado_actual) %El largo de sch_filtrado_actual siempre es un múltiplo de 4.
  
%%   
   1   
   %Comparo el valor de j con 4 (calculo el resto de la division) para
   %saber qué tipo de medición es
   % A la vez uso A como variable para indezar los TR, luego en el archivo
   % guardado
%    
%    Modo de funcionamiento:
%    
%    Primero defino "a",que la hago valer
%    0 si j es 1, 2, 3, o 4. 
%    1 si j es 5, 6, 7, 8
%    2 si j es 9 10, 11, 12
%    etc.
%    
%    Luego, usando "verificar" detecto si debo calcular T20 o T15 
%    (medicion sin girar o girando). Además, verifico si te trata de una medicion
%    con muestra o sin muestra
%    
%        %los TR de acuerdo a la siguiente tabla:
%        % T1 ---> Sin Muestra y Sin Girar
%        % T2 ---> Con Muestra y Sin Girar
%        % T3 ---> Sin Muestra y Girando
%        % T4 ---> Con Muestra y Girando
%        
%        indexo usando "a" haciendo:
%        
%        4* a + T
%        
%        donde T vale 1,2, 3, o 4 en función de si es T1 T2 T3 o T4.
%        
%        
%%   
    a = fix(j/4);
   switch mod(j,4)
       case 1
           verificar = 1;    
       case 2
           verificar = 2;
       case 3
           verificar = 3;
       case 0
           verificar = 4;
            a= a - 1;
   end

   
   actual = sch_filtrado_actual{j}-max(sch_filtrado_actual{j}); %Normalizo en dB
   actual = actual(length(actual) - find(flipud(actual) >= -1) : end); %Revierto en tiempo para encontrar cuando llega a -1 dB. No me impota perder info porque para el TR tengo que ir desde -5 a -25. Corto de ahi al final
    
   ini = find(actual < -5,1); %Inicio de la regresión
   if logico_ordenado(verificar,4) == 0; %Se trata de una medición SIN GIRAR-->Calculo de t20
       fin_t20 = find(actual < -25,1); %Fin de la regresion
       time = 1:length(actual); %Vector temporal de la regresion
       P_t20= polyfit(time(ini:fin_t20)',actual(ini:fin_t20),1); %Cuadrados minimos de la curva entre -5 y -25 dB
       recta_t20 = polyval(P_t20,time); %Evaluacion de la curva en el vector temporal
       
    if logico_ordenado(verificar,1) == 0  % Se trata de medicion Sin muestra --> es T1
               if  ~isempty(fin_t20)
                 TR_actual {4*a + 1} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*a + 1} = 'StN';
               end
    else                                  % Se trata de medicion Con muestra --> es T2
               if  ~isempty(fin_t20)
                  TR_actual {4*a + 2} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*a + 2} = 'StN';
              end
    end
        
       
%        if  ~isempty(fin_t20)
%             T20_actual {j} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
%        else
%             %no hay suficiente relacion señal a ruido
%             T20_actual {j} = 'StN';
%        end
     sch_actual{verificar} = actual;
     recta_actual{verificar} = recta_t20;
     time_actual{verificar} = time;
     
   elseif logico_ordenado(verificar,4) == 1; %%Se trata de una medición GIRANDO --> Calculo de t15
       %Para verificar que T15 es calculado sobre una sola pendiente,
       %calculo varias rectas con distintos intervalos de integración y
       %comparo el valor de las pendientes
       
       fin_t08 = find(actual < -13,1);
       fin_t10 = find(actual < -15,1);
       fin_t12 = find(actual < -12,1);
       fin_t15 = find(actual < -20,1);
       
       time = 1:length(actual);%Vector temporal de la regresio
       
        %Evaluo cada recta
        P_t08= polyfit(time(ini:fin_t08)',actual(ini:fin_t08),1);
        P_t10= polyfit(time(ini:fin_t10)',actual(ini:fin_t10),1);
        P_t12= polyfit(time(ini:fin_t12)',actual(ini:fin_t12),1);
        P_t15= polyfit(time(ini:fin_t15)',actual(ini:fin_t15),1);
        
        %verificación de que la T15 incluye una sola pendiente
        promedio = (P_t10 + P_t12 )/2;
        
%         if P_t15/promedio >1.2;
%         T15_actual {j} = 'Inconsistente';
%         
%         elseif P_t15/promedio<0.8;
%         T15_actual {j} = 'Inconsistente';      
%         else
        recta_t15= polyval(P_t15,time);
        
         if logico_ordenado(verificar,1) == 0  % Se trata de medicion Sin muestra --> es T3
               if  ~isempty(fin_t15)
                 TR_actual {4*a + 3} =  (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate; 
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*a + 3} = 'StN';
               end
    else                                  % Se trata de medicion Con muestra --> es T4
               if  ~isempty(fin_t15)
                  TR_actual {4*a + 4} = (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate;
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {4*a + 4} = 'StN';
              end
         end
    
        
%          
%         T15_actual {j} = (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate;
% %         end
%         sch_actual{verificar} = actual;
%         recta_actual{verificar} = recta_t15;
%         time_actual{verificar} = time;     
   end
   
%    fin_t08 = find(actual < -13,1);
%    fin_t10 = find(actual < -15,1);
%    fin_t12 = find(actual < -12,1);
%    fin_t15 = find(actual < -20,1);
%    fin_t20 = find(actual < -25,1);
%    fin_t30 = find(actual < -35,1);
%    time = 1:length(actual);
%  
%         P_t08= polyfit(time(ini:fin_t08)',actual(ini:fin_t08),1);
%         P_t10= polyfit(time(ini:fin_t10)',actual(ini:fin_t10),1);
%         P_t12= polyfit(time(ini:fin_t12)',actual(ini:fin_t12),1);
%         P_t15= polyfit(time(ini:fin_t15)',actual(ini:fin_t15),1);
% 
%         %verificación de que la T15 incluye una sola pendiente
%         promedio = (P_t08 + P_t10 + P_t12 )/3;
%         
%         if P_t15/promedio >1.15;
%         T15_actual {j} = 'Inconsistente';    
%         elseif P_t15/promedio<0.85;
%         T15_actual {j} = 'Inconsistente';      
%         else
%         recta_t15= polyval(P_t15,time);
%         T15_actual {j} = (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate;
%         end
%         
%    P_t20= polyfit(time(ini:fin_t20)',actual(ini:fin_t20),1);
%    recta_t20 = polyval(P_t20,time);
%    P_t30= polyfit(time(ini:fin_t30)',actual(ini:fin_t30),1);
%    recta_t30 = polyval(P_t30,time);
%    
%    
%    if  ~isempty(fin_t20)
%    T20_actual {j} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;
%    else
%    T20_actual {j} = 'StN';
%    end
%    
%    if ~isempty(fin_t30)
%    T30_actual {j} = (find(recta_t30 <= -35,1) - find(recta_t30 <=-5,1))* 2/SampleRate;
%    else
%    T30_actual {j} = 'StN';
%    end
%    


end



% switch verificar
%     case 1
% subplot(2,2,1)
% plot(actual)
% hold on
% plot(time,recta_t20,'r')
% drawnow
%     case 2
% subplot(2,2,2)
% plot(actual)
% hold on
% plot(time,recta_t15,'g')
% drawnow
%     case 3
% subplot(2,2,3)
% plot(actual)
% hold on
% plot(time,recta_t20,'k')
% drawnow
%     case 4
% subplot(2,2,4)
% plot(actual)
% hold on
% plot(time,recta_t15,'m')
% drawnow
% pause
% end

% T15{i} =T15_actual;
% clear T15_actual;
TR{i} = TR_actual;
clear T20_actual
% T30{i} = T30_actual;
% clear T30_actual;

end
        file_name = strcat(file_location,username,'_','TR','.mat'); %File name
        save(file_name,'TR')
 
%%Calculo de coeficientes de Absorcion de aire y Velocidad del Sonido
load('app_data/settings.mat','c_fuentes_total');
load('app_data/current.mat','temp')
vel_son = 343.2*sqrt((273.15+temp)/293.15);
load('app_data/current.mat','abs_aire')
load('app_data/current.mat','hum')

c_mediciones = 4*c_mics_total*c_fuentes_total;

if octavas ==1
    mf = cell(1,10);
    velocidad = cell(1,10);
    fc = fc_octava;
else
    mf = cell(1,30);
    velocidad = cell(1,10);
    fc = fc_tercios;
end
if abs_aire == 1
        for i = 1:length(mf)

                m1 = air_absorption(fc(i),temp(1),hum(1),1)/4.343;
                c1 = 343.2*sqrt((273.15+temp(1))/293.15);
                m2 = air_absorption(fc(i),temp(2),hum(2),1)/4.343;
                c2 = 343.2*sqrt((273.15+temp(2))/293.15);
                m3 = air_absorption(fc(i),temp(3),hum(3),1)/4.343;
                c3 = 343.2*sqrt((273.15+temp(3))/293.15);
                m4 = air_absorption(fc(i),temp(4),hum(4),1)/4.343;
                c4 = 343.2*sqrt((273.15+temp(4))/293.15);
                m = [m1; m2 ;m3 ;m4];
                c = [c1; c2 ;c3 ;c4];
                ms = m;
                cs = c;
                for j= 1:c_mediciones/4-1;
                    ms = [ms ;m];
                    cs = [cs; c];
                 %   ms = {ms};
                end
             mf(i) = {ms};
             velocidad (i) = {cs};
        end
else
            for i = 1:length(mf)

                m1 = 0;
                c1 = 343.2*sqrt((273.15+temp(1))/293.15);
                m2 = 0;
                c2 = 343.2*sqrt((273.15+temp(2))/293.15);
                m3 = 0;
                c3 = 343.2*sqrt((273.15+temp(3))/293.15);
                m4 = 0;
                c4 = 343.2*sqrt((273.15+temp(4))/293.15);
                m = [m1; m2 ;m3 ;m4];
                c = [c1; c2 ;c3 ;c4];
                ms = m;
                cs = c;
                for j= 1:c_mediciones/4-1;
                    ms = [ms ;m];
                    cs = [cs; c];
                 %   ms = {ms};
                end
             mf(i) = {ms};
             velocidad (i) = {cs};
        end
    
end
load('app_data/current.mat','vol_camara');
load('app_data/current.mat','sup_muestra');
toc
%Calculo de Coeficientes (Alpha_s -  Alpha_spec - Splate - S - Scorreg)
        for i = 1:length(fc)
            
            TR_actual = TR{i}; 
            mf_actual = mf{i};
            velocidad_actual = velocidad{i};
            
            for j = 1:c_mediciones/4;
            alpha_s(j) =55.3*vol_camara/sup_muestra*...
            (1/(velocidad_actual(4*j-4+2)*TR_actual{4*j-4+2})-1/(velocidad_actual(4*j-4+1)*TR_actual{4*j-4+1}))-...
            4*vol_camara/sup_muestra*(mf_actual(4*j-4+2)-mf_actual(4*j-4+1)); 
        
            alpha_spec(j) =55.3*vol_camara/sup_muestra*...
            (1/(velocidad_actual(4*j-4+4)*TR_actual{4*j-4+4})-1/(velocidad_actual(4*j-4+3)*TR_actual{4*j-4+3}))-...
            4*vol_camara/sup_muestra*(mf_actual(4*j-4+4)-mf_actual(4*j-4+3)); 
        
            S_plate(j) = 55.3*vol_camara/sup_muestra*...
            (1/(velocidad_actual(4*j-4+3)*TR_actual{4*j-4+3})-1/(velocidad_actual(4*j-4+1)*TR_actual{4*j-4+1}))-...
            4*vol_camara/sup_muestra*(mf_actual(4*j-4+3)-mf_actual(4*j-4+1));
        
            s(j) = (alpha_spec(j)-alpha_s(j))/(1-alpha_s(j));
               
            end
            
            
            alpha_S(i) = {alpha_s};
            alpha_SPEC(i) = {alpha_spec};
            S_PLATE (i) = {S_plate};
            S(i) = {s};
            
            clear alpha_s
            clear alpha_spec
            clear S_plate
            
        end
        

        file_name = strcat(file_location,username,'_','Coeficientes','.mat'); %File name
        save(file_name,'alpha_S','alpha_SPEC','S_PLATE','S')

        
        %%% Armado de Variables para Guardar
        
for i = 1:length(S)
coef_scattering(i) = mean(S{i});
Alpha_SPEC_end(i) = mean(alpha_SPEC{i});
coef_absorcion(i) = mean(alpha_S{i});
coef_scattering_corregido(i) = mean(S{i});
end

save('app_data/current.mat','-V6','coef_scattering','coef_scattering_corregido','coef_absorcion','-append');
export_excel