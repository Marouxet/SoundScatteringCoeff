%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculo de la integral de Schroeder y otras yerbas
%Algortimo de Lundebys para encontrar el punto de corte entre IR y ruido

%Hay que importar al workspace alguna banda de mapf. Que es el resultado
%del filtrado.
bands = 30;
     load('app_data/current.mat','path');
     load('app_data/settings.mat','temp_folder');
     load('app_data/current.mat','username');
     load('app_data/settings.mat','SampleRate');
     load('app_data/filtros.mat','Fc');
     load('app_data/settings.mat','temp_folder');
     load('app_data/current.mat','username');
     file_location = strcat(temp_folder,username,'/');
for i = 1:bands
            fc_num = num2str(round(Fc(i)));
            file_name = strcat(file_location,username,'_','IRs','_',fc_num,'.mat'); %File name
            load(file_name,'map_f')
            
            mapf1 = map_f{1};
            mapf2 = map_f{2};
            mapf3 = map_f{3};
            mapf4 = map_f{4};
            mapf5 = map_f{5};
            mapf6 = map_f{6};
            mapf7 = map_f{7};
            mapf8 = map_f{8};

            [p1,C1]=lundeby(map_f{1},SampleRate);
            [p2,C2]=lundeby(map_f{2},SampleRate);
            [p3,C3]=lundeby(map_f{3},SampleRate);
            [p4,C4]=lundeby(map_f{4},SampleRate);
            [p5,C5]=lundeby(map_f{5},SampleRate);
            [p6,C6]=lundeby(map_f{6},SampleRate);
            [p7,C7]=lundeby(map_f{7},SampleRate);
            [p8,C8]=lundeby(map_f{8},SampleRate);

            sch{1} = 10*log10(flipud(cumsum(flipud(map_f{1}(1:p1).^2)))/max(flipud(cumsum(flipud(map_f{1}(1:p1).^2))))) + C1;
            sch{2} = 10*log10(flipud(cumsum(flipud(map_f{2}(1:p2).^2)))/max(flipud(cumsum(flipud(map_f{2}(1:p2).^2))))) + C2;
            sch{3} = 10*log10(flipud(cumsum(flipud(map_f{3}(1:p3).^2)))/max(flipud(cumsum(flipud(map_f{3}(1:p3).^2))))) + C3;
            sch{4} = 10*log10(flipud(cumsum(flipud(map_f{4}(1:p4).^2)))/max(flipud(cumsum(flipud(map_f{4}(1:p4).^2))))) + C4;
            sch{5} = 10*log10(flipud(cumsum(flipud(map_f{5}(1:p5).^2)))/max(flipud(cumsum(flipud(map_f{5}(1:p5).^2))))) + C5;
            sch{6} = 10*log10(flipud(cumsum(flipud(map_f{6}(1:p6).^2)))/max(flipud(cumsum(flipud(map_f{6}(1:p6).^2))))) + C6;
            sch{7} = 10*log10(flipud(cumsum(flipud(map_f{7}(1:p7).^2)))/max(flipud(cumsum(flipud(map_f{7}(1:p7).^2))))) + C7;
            sch{8} = 10*log10(flipud(cumsum(flipud(map_f{8}(1:p8).^2)))/max(flipud(cumsum(flipud(map_f{8}(1:p8).^2))))) + C8;

     file_name = strcat(file_location,username,'_','SCH','_',fc_num,'.mat'); %File name
     save(file_name,'sch')
end
%figure; plot(sch1,'r'); hold on ;plot(sch2,'b'); plot(sch3,'g'); plot(sch4,'k');
%plot(sch5,'r-');plot(sch6,'b-'); plot(sch7,'g-'); plot(sch8,'k-');
%grid on
%legend(Irs{1,1},Irs{2,1},Irs{3,1},Irs{4,1})
