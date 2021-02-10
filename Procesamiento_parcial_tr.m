load('app_data/current.mat','vol_camara');
load('app_data/current.mat','sup_muestra');

%Calculo de Coeficientes (Alpha_s -  Alpha_spec - Splate - S - Scorreg)

for j =  1:length(Resultados)
    
    
    R = Resultados{j};
    %Alpha_S es Resultados 13
            R(13,:) =   55.3*vol_camara/sup_muestra.*...
                        (1./(R(11,:).*R(3,:))-1./(R(9,:).*R(1,:)))-...
                        4*vol_camara/sup_muestra.*(R(7,:)-R(5,:));
        
    %Alpha_Spec es Resultados 14
            R(14,:) =   55.3*vol_camara/sup_muestra.*...
                        (1./(R(12,:).*R(4,:))-1./(R(10,:).*R(2,:)))-...
                        4*vol_camara/sup_muestra.*(R(8,:)-R(6,:)); 
                    
    %S_Plate  es Resultados 15
            R(15,:) =   55.3*vol_camara/sup_muestra.*...
                        (1./(R(10,:).*R(2,:))-1./(R(9,:).*R(1,:)))-...
                        4*vol_camara/sup_muestra.*(R(6,:)-R(5,:));                  
        
    %S es Resultados 16        
    
            R(16,:) = (R(14,:)-R(13,:))./(1-R(13,:));

Resultados{j} = R;
clear R
end
            
%             (1/(velocidad_actual(4*j-4+2)*TR_actual{4*j-4+2})-1/(velocidad_actual(4*j-4+1)*TR_actual{4*j-4+1}))-...
%             4*vol_camara/sup_muestra*(mf_actual(4*j-4+2)-mf_actual(4*j-4+1));
%     
%         for i = 1:length(fc)
%             
%             TR_actual = TR{i}; 
%             mf_actual = mf{i};
%             velocidad_actual = velocidad{i};
%             
%             for j = 1:c_mediciones/4;
%             alpha_s(j) =55.3*vol_camara/sup_muestra*...
%             (1/(velocidad_actual(4*j-4+2)*TR_actual{4*j-4+2})-1/(velocidad_actual(4*j-4+1)*TR_actual{4*j-4+1}))-...
%             4*vol_camara/sup_muestra*(mf_actual(4*j-4+2)-mf_actual(4*j-4+1)); 
%         
%             alpha_spec(j) =55.3*vol_camara/sup_muestra*...
%             (1/(velocidad_actual(4*j-4+4)*TR_actual{4*j-4+4})-1/(velocidad_actual(4*j-4+3)*TR_actual{4*j-4+3}))-...
%             4*vol_camara/sup_muestra*(mf_actual(4*j-4+4)-mf_actual(4*j-4+3)); 
%         
%             S_plate(j) = 55.3*vol_camara/sup_muestra*...
%             (1/(velocidad_actual(4*j-4+3)*TR_actual{4*j-4+3})-1/(velocidad_actual(4*j-4+1)*TR_actual{4*j-4+1}))-...
%             4*vol_camara/sup_muestra*(mf_actual(4*j-4+3)-mf_actual(4*j-4+1));
%         
%             s(j) = (alpha_spec(j)-alpha_s(j))/(1-alpha_s(j));
%                
%             end
%             
%             
%             alpha_S(i) = {alpha_s};
%             alpha_SPEC(i) = {alpha_spec};
%             S_PLATE (i) = {S_plate};
%             S(i) = {s};
%             
%             clear alpha_s
%             clear alpha_spec
%             clear S_plate
%             
%         end
%         
% 
%         file_name = strcat(file_location,username,'_','Coeficientes','.mat'); %File name
%         save(file_name,'alpha_S','alpha_SPEC','S_PLATE','S')

        
        %%% Armado de Variables para Guardar
%end
        
% for i = 1:length(S)
% coef_scattering(i) = mean(S{i});
% Alpha_SPEC_end(i) = mean(alpha_SPEC{i});
% coef_absorcion(i) = mean(alpha_S{i});
% coef_scattering_corregido(i) = mean(S{i});
% end
% 
% save('app_data/current.mat','-V6','coef_scattering','coef_scattering_corregido','coef_absorcion','-append');
% export_excel