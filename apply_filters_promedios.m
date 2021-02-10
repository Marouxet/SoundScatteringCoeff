function apply_filters_promedios(source_name,band)

%     %Load current file information.
     load('app_data/current.mat','path');
     load('app_data/current.mat','temp_folder');
     load('app_data/current.mat','username');
     load('app_data/settings.mat','SampleRate');
     load('app_data/filtros.mat','fc_octava');
     load('app_data/filtros.mat','fc_tercios');
     load('app_data/current.mat','octavas');
   
     file_location = strcat(temp_folder,username,'/');
     if exist(file_location,'dir') == 0    
         %Create directory for measurement.
         mkdir(temp_folder,username);
     end
%     %To get the filter bank back.
     file_loc = strcat(file_location,username,'_');
     save('app_data/current.mat','file_loc','-append');
   

    to_filter = source_name;
    
    a = SampleRate * octavas;
    
    if a == 44100*3; 
    load('app_data/filtros.mat','hd_tercios_44100');
    filtros = hd_tercios_44100;
    elseif a == 48000*3;
    load('app_data/filtros.mat','hd_tercios_48000');
    filtros = hd_tercios_48000;
    elseif a == 44100;
    load('app_data/filtros.mat','hd_octava_44100');
    filtros = hd_octava_44100;  
    else
    load('app_data/filtros.mat','hd_octava_48000');
    filtros = hd_octava_48000;     
    end
    
    filter_x = filtros{band};
    
    for h=1:length(to_filter)
        
    map_f{h} = filter(filter_x, to_filter{h});
    
    end
%     for j=1:length(source_name)
%         filter_x = filtros{band};
%         map_f{j} = filter(filter_x, to_filter{j});
% 
%     end
            if octavas == 1
            fc_num = num2str(round(fc_octava(band)));
            elseif octavas == 3
            fc_num = num2str(round(fc_tercios(band)));
            end
            file_name = strcat(file_location,'pp\',username,'_','IRs','_',fc_num,'.mat'); %File name
            save(file_name,'map_f')

end

 