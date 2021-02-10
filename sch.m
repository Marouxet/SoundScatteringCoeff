     load('app_data/current.mat','path');
     load('app_data/settings.mat','temp_folder');
     load('app_data/current.mat','username');
     load('app_data/settings.mat','SampleRate');
     load('app_data/filtros.mat','Fc');
     file_location = strcat(temp_folder,username,'/');
    w_tr = waitbar(0,'Calculando SCH,TR, etc.. '); 
     for i = 1:length(Fc)
    %i = 5;
     fc_num = num2str(round(Fc(i)));
     file_name = strcat(file_location,username,'_','IRs','_',fc_num,'.mat');
     load(file_name);
     tr20 = zeros(size(map_f));
         for j = 1:length(map_f)
            ir = map_f{i};

            cross2 = lundebys(ir,SampleRate);
if isempty(cross2) %Error de no poder encontrar el cruce 
    tr20(j) = 0;
else
            ir2 = ir.^2;
            pcuadradoflip=flipud(ir2(1:cross2));
            A=cumsum(pcuadradoflip);
            SCH=flipud(A);
            SCH = 10*log10(SCH/max(SCH));
            t = 0:length(SCH)-1;
            t = t/SampleRate;

            %Cuadrados Mínimos desde los rangos de integración

            ini= -5;
            fin = -35;

            rango = [find(SCH<=ini,1) find(SCH<=fin,1)];
            SCH_topolyfit = SCH(rango(1):rango(2));
            t_topolyfit = t(rango(1):rango(2));
            t_topolyfit = t_topolyfit';
            pol = polyfit(t_topolyfit,SCH_topolyfit,1);
            recta = polyval(pol,t);

            %plot(t,SCH,'b',t,recta,'r')

            %Encuentro T20
            tr20(j) = 3*(find(recta<=-25,1) - find(recta<=-5,1))/SampleRate;
end
         end
      file_name_tr = strcat(file_location,username,'_','TR20','_',fc_num,'.mat');
      save(file_name_tr,'tr20')
      waitbar (i/length(Fc),w_tr);

     end