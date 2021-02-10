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
        
     %    file_name = strcat(file_location,username,'_','Coeficientes','.mat'); %File name
     %    save(file_name,'Resultados');

      %   close(w_coef)
               
