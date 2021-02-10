            
   %         load('app_data/current.mat','Nombre_signal');
   %         load('app_data/current.mat','matriz_filename');
   %         load('app_data/orden.mat','nmedicion');
  %          load('app_data/settings.mat','objectName');
%            load('app_data/settings.mat','c_mics_simultaneo');
 %           load('app_data/settings.mat','c_mics_total');
            load('app_data/current.mat','SampleRate')
%            load('app_data/current.mat','Nombre_filtroinverso');
            load('app_data/current.mat','octavas');
%             load('app_data/current.mat','filename1');
%             load('app_data/current.mat','filename2');
%             load('app_data/current.mat','filename3');
%             load('app_data/current.mat','filename4');
%             load('app_data/current.mat','filename5');
%             load('app_data/current.mat','filename6');
            
% SweepOrig = audioread(Nombre_signal);
 
suma = 0;               %En suma se van a ir sumando las mediciones de un mismo giro    
registro = 1;
for n_registro = 1:length(filename1)
    Sweep = audioread(filename1{n_registro}); %Leo el archivo de audio actual
    suma = PromediosV2(Sweep,SweepOrig,registro,suma); %Ajusto delay y polaridad segun CorrelacionCruzada y fase de FFT. Sumo
registro = registro + 1;
end
Sweep1 = suma/length(filename1); %Promedio: divido la suma por la cantidad de mediciones

suma = 0;               %En suma se van a ir sumando las mediciones de un mismo giro    
registro = 1;
for n_registro = 1:length(filename2)
    Sweep = audioread(filename2{n_registro}); %Leo el archivo de audio actual
    suma = PromediosV2(Sweep,SweepOrig,registro,suma); %Ajusto delay y polaridad segun CorrelacionCruzada y fase de FFT. Sumo
registro = registro + 1;
end
Sweep2 = suma/length(filename2); %Promedio: divido la suma por la cantidad de mediciones

suma = 0;               %En suma se van a ir sumando las mediciones de un mismo giro    
registro = 1;
for n_registro = 1:length(filename3)
    Sweep = audioread(filename3{n_registro}); %Leo el archivo de audio actual
    suma = PromediosV2(Sweep,SweepOrig,registro,suma); %Ajusto delay y polaridad segun CorrelacionCruzada y fase de FFT. Sumo
registro = registro + 1;
end
Sweep3 = suma/length(filename3); %Promedio: divido la suma por la cantidad de mediciones

suma = 0;               %En suma se van a ir sumando las mediciones de un mismo giro    
registro = 1;
for n_registro = 1:length(filename4)
    Sweep = audioread(filename4{n_registro}); %Leo el archivo de audio actual
    suma = PromediosV2(Sweep,SweepOrig,registro,suma); %Ajusto delay y polaridad segun CorrelacionCruzada y fase de FFT. Sumo
registro = registro + 1;
end
Sweep4 = suma/length(filename4); %Promedio: divido la suma por la cantidad de mediciones

suma = 0;               %En suma se van a ir sumando las mediciones de un mismo giro    
registro = 1;
for n_registro = 1:length(filename5)
    Sweep = audioread(filename5{n_registro}); %Leo el archivo de audio actual
    suma = PromediosV2(Sweep,SweepOrig,registro,suma); %Ajusto delay y polaridad segun CorrelacionCruzada y fase de FFT. Sumo
registro = registro + 1;
end
Sweep5 = suma/length(filename5); %Promedio: divido la suma por la cantidad de mediciones

suma = 0;               %En suma se van a ir sumando las mediciones de un mismo giro    
registro = 1;
for n_registro = 1:length(filename6)
    Sweep = audioread(filename6{n_registro}); %Leo el archivo de audio actual
    suma = PromediosV2(Sweep,SweepOrig,registro,suma); %Ajusto delay y polaridad segun CorrelacionCruzada y fase de FFT. Sumo
registro = registro + 1;
end
Sweep6 = suma/length(filename6); %Promedio: divido la suma por la cantidad de mediciones


% load('app_data/current.mat','Nombre_filtroinverso');
% load(Nombre_filtroinverso);
irLin1 = extractIRfromSweep(Sweep1, inversefiltersweepfft);
irLin2 = extractIRfromSweep(Sweep2, inversefiltersweepfft);
irLin3 = extractIRfromSweep(Sweep3, inversefiltersweepfft);
irLin4 = extractIRfromSweep(Sweep4, inversefiltersweepfft);
irLin5 = extractIRfromSweep(Sweep5, inversefiltersweepfft);
irLin6 = extractIRfromSweep(Sweep6, inversefiltersweepfft);


if octavas == 1
    bands = 10;
elseif octavas ==3
    bands = 30;
end   
w_filters = waitbar(0,'Filtrando respuestas al impulso. Por favor, espere');

irLin = cell(1,6);
irLin{1}=irLin1;
irLin{2}=irLin2;
irLin{3}=irLin3;
irLin{4}=irLin4;
irLin{5}=irLin5;
irLin{6}=irLin6;
%Filtrado
  

for i = 1:bands
    apply_filters_promedios(irLin(:),i);
    waitbar (i/length(irLin),w_filters);
end
close(w_filters)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bands = 10;
% octavas = 1;
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

         file_location = strcat(temp_folder,username,'/pp/');
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

%----------------------


[corr, lag]=xcorr(AAA,SweepOrig);
                                            [~,I] = max(abs(corr));
                                            lagDiff = lag(I);
                                            if lagDiff<0
                                                lagDiff = - lagDiff;
                                            end
                                            AAA = AAA(lagDiff:end);
                                            
                                            
                                            
                                            
    to_filter = AAA;
    for band=1:30
        
    filter_x = filtros{band};    
    map_f {band} = filter(filter_x, to_filter);
    
    end
for i = 1:bands    
[p,C] = lundeby(map_f{i},SampleRate);
sch{i} = 10*log10(flipud(cumsum(flipud(map_f{i}(1:p).^2)))/max(flipud(cumsum(flipud(map_f{i}(1:p).^2))))) + C;
end