            load('app_data/current.mat','Nombre_signal');
            load('app_data/current.mat','matriz_filename');
            load('app_data/orden.mat','nmedicion');
            load('app_data/settings.mat','objectName');
            load('app_data/settings.mat','c_mics_simultaneo');
            load('app_data/settings.mat','c_mics_total');
            load('app_data/current.mat','SampleRate')
            load('app_data/current.mat','Nombre_filtroinverso');
            load('app_data/current.mat','octavas'); 
            load('app_data/settings.mat','c_fuentes_total');
            load('app_data/current.mat','orden_corregido');
             load('app_data/current.mat','corregido_filename');
            
       %     corregido_filename_ord = cell(size(corregido_filename));
            
[~,b] = sort(orden_corregido);

corregido_filename =  sortrows(corregido_filename);
           
for n = 1:size(corregido_filename,1) %Usando la matriz construyo los nombres de los archivos de auido (la misma forma se usa en createWriterV2
filename{n} = strcat(path,corregido_filename{n,1},'_',corregido_filename{n,2}, '_',corregido_filename{n,3},'_',corregido_filename{n,4});
end        

%%%Guardado de Archivos

                 load('app_data/current.mat','temp_folder');
                 load('app_data/current.mat','username');
                 file_location = strcat(temp_folder,username,'\T0\');
                 if exist(file_location,'dir') == 0    
                 mkdir(strcat(temp_folder,username,'\'),'T0');
                 end
%%%

 if strcmp(typesignal,'SWEEP')

    SweepOrig = audioread(Nombre_signal);
    for i=1:length(filename)
    Sweep = audioread(filename{i}); %Leo el archivo de audio actual

            [corr, lag]=xcorr(Sweep,SweepOrig);
            [~,I] = max(abs(corr));
            lagDiff = lag(I);
            if lagDiff<0
                lagDiff = - lagDiff;
            end
            Sweep = Sweep(lagDiff:end);

    Respuestas(i,2) = {Sweep}; %Lo guardo en una celda de Respuestas
    Respuestas(i,1) = {filename{i}}; %La celda de al lado indica qué archivo es
    end
    
    file_name = strcat(file_location,username,'_','Sweeps','.mat');
    save(file_name,'Respuestas');
    
    
    
    load(Nombre_filtroinverso);

    for i = 1:length(filename)
        current_Respuesta = Respuestas(i,2);
        current_Respuesta = current_Respuesta{:};
        irLin = extractIRfromSweep(current_Respuesta, inversefiltersweepfft);
        Irs(i,2) = {irLin};
        Irs(i,1) = Respuestas(i,1);
    end
  file_name = strcat(file_location,username,'_','Irs','.mat');
  save(file_name,'Irs')
 
 
 else
     
    for i=1:length(filename)
    MLS = audioread(filename{i}); %Leo el archivo de audio actual
    Respuestas(i,2) = {MLS}; %Lo guardo en una celda de Respuestas
    Respuestas(i,1) = {filename{i}}; %La celda de al lado indica qué archivo es
    end

    file_name = strcat(file_location,username,'_','Sweeps','.mat');
    save(file_name,'Respuestas');
    
    for i = 1:length(filename)
    current_Respuesta = Respuestas(i,2);
    current_Respuesta = current_Respuesta{:};
    ir = AnalyseMLSSequence(current_Respuesta,mls_orden,repet_mls);
    Irs(i,2) = {ir};
    Irs(i,1) = Respuestas(i,1);
    end
    
    file_name = strcat(file_location,username,'_','Irs','.mat');
    save(file_name,'Irs')
    
 end
 
%Filtrado
w_filters = waitbar(0,'Filtrando respuestas al impulso. Por favor, espere');

if octavas == 1
    bands = 10;
elseif octavas ==3
    bands = 30;
end   
load(file_name,'Irs')
for i = 1:bands
    apply_filters_t0(Irs(:,2),i);
    waitbar (i/bands,w_filters);
end
close(w_filters)


     load('app_data/current.mat','path');
     load('app_data/current.mat','temp_folder');
     load('app_data/current.mat','username');
     load('app_data/settings.mat','SampleRate');
     load('app_data/filtros.mat','fc_octava');
     load('app_data/filtros.mat','fc_tercios');


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
                [p,C] = lundeby(map_f{j},SampleRate);
                sch{j} = 10*log10(flipud(cumsum(flipud(map_f{j}(1:p).^2)))/max(flipud(cumsum(flipud(map_f{j}(1:p).^2))))) + C;
            end

             file_name = strcat(file_location,username,'_','SCH','_',fc_num,'.mat'); %File name
             save(file_name,'sch')
             waitbar (i/bands,w_sch);
end
close(w_sch)

%Calculo del Tiempo de Reverberación
load('app_data/orden.mat','logico_ordenado')
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
 
 
for j = 1:length(sch_filtrado_actual) %El largo de sch_filtrado_actual siempre es un múltiplo de 4.
  
   actual = sch_filtrado_actual{j}-max(sch_filtrado_actual{j}); %Normalizo en dB
   actual = actual(length(actual) - find(flipud(actual) >= -1) : end); %Revierto en tiempo para encontrar cuando llega a -1 dB. No me impota perder info porque para el TR tengo que ir desde -5 a -25. Corto de ahi al final
    
   ini = find(actual < -5,1); %Inicio de la regresión

   
       fin_t20 = find(actual < -25,1); %Fin de la regresion
       time = 1:length(actual); %Vector temporal de la regresion
       P_t20= polyfit(time(ini:fin_t20)',actual(ini:fin_t20),1); %Cuadrados minimos de la curva entre -5 y -25 dB
       recta_t20 = polyval(P_t20,time); %Evaluacion de la curva en el vector temporal
       
    
               if  ~isempty(fin_t20)
                 TR_actual {j} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {j} = 'StN';
               end
 
     sch_actual{j} = actual;
     recta_actual{j} = recta_t20;
     time_actual{j} = time;
     

end


TR{i} = TR_actual;
clear T20_actual

waitbar (i/bands,w_tr);
end
close(w_tr) 

file_name = strcat(file_location,username,'_','TR','.mat'); %File name
save(file_name,'TR')
