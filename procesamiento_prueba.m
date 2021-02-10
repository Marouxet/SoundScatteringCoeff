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
 
 logico_ordenado2 = zeros(length(sch_filtrado_actual),4);
 for ii = 1:length(objectName)
     logico_ordenado2((ii-1)*length(logico_ordenado)+1:ii*length(logico_ordenado),:) = logico_ordenado(:,:);
 end
 
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


    
%     
%     a = fix(j/4);
%    switch mod(j,4)
%        case 1
%            verificar = 1;    
%        case 2
%            verificar = 2;
%        case 3
%            verificar = 3;
%        case 0
%            verificar = 4;
%             a= a - 1;
%    end

   
   actual = sch_filtrado_actual{j}-max(sch_filtrado_actual{j}); %Normalizo en dB
   actual = actual(length(actual) - find(flipud(actual) >= -1) : end); %Revierto en tiempo para encontrar cuando llega a -1 dB. No me impota perder info porque para el TR tengo que ir desde -5 a -25. Corto de ahi al final
    
   ini = find(actual < -5,1); %Inicio de la regresión
   if logico_ordenado2(j,4) == 0; %Se trata de una medición SIN GIRAR-->Calculo de t20
       fin_t20 = find(actual < -25,1); %Fin de la regresion
       time = 1:length(actual); %Vector temporal de la regresion
       P_t20= polyfit(time(ini:fin_t20)',actual(ini:fin_t20),1); %Cuadrados minimos de la curva entre -5 y -25 dB
       recta_t20 = polyval(P_t20,time); %Evaluacion de la curva en el vector temporal
       
    if logico_ordenado2(j,1) == 0  % Se trata de medicion Sin muestra --> es T1
               if  ~isempty(fin_t20)
                 TR_actual {j} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {j} = 'StN';
               end
    else                                  % Se trata de medicion Con muestra --> es T2
               if  ~isempty(fin_t20)
                  TR_actual {j} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {j} = 'StN';
              end
    end
        
       
%        if  ~isempty(fin_t20)
%             T20_actual {j} = (find(recta_t20 <= -25,1) - find(recta_t20 <=-5,1))* 3/SampleRate;  %Calculo de T20
%        else
%             %no hay suficiente relacion señal a ruido
%             T20_actual {j} = 'StN';
%        end
     sch_actual{j} = actual;
     recta_actual{j} = recta_t20;
     time_actual{j} = time;
     
   elseif logico_ordenado2(j,4) == 1; %%Se trata de una medición GIRANDO --> Calculo de t15
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
        
         if logico_ordenado2(j,1) == 0  % Se trata de medicion Sin muestra --> es T3
               if  ~isempty(fin_t15)
                 TR_actual {j} =  (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate; 
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {j} = 'StN';
               end
    else                                  % Se trata de medicion Con muestra --> es T4
               if  ~isempty(fin_t15)
                  TR_actual {j} = (find(recta_t15 <= -20,1) - find(recta_t15 <=-5,1))* 4/SampleRate;
               else
                 %no hay suficiente relacion señal a ruido
                 TR_actual {j} = 'StN';
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