function [] = medicion(type,handles)

%MEDICION Organiza la medición (grabación y manipulación de la mesa
%giratoria) en función de "type" que indica qué tipo de medición es.
%   type debe ser un string: 'SM_SG' para mediciones sin muestra y 
%   sin rotación ;'SM_G' para mediciones sin muestra con rotación
%   'CM_SG'  para medición con muestra sin rotación y 'CM_G' para mediciones 
%   con muestra y rotación. 

load('app_data/settings.mat','intervalo_angular')
load('app_data/current.mat','active_chan');

switch type
    
    case 'SM_SG'
        
        for j = 1:active_chan 
            %Nombre de Archivo
            load('app_data/current.mat','path');
            load('app_data/current.mat','ChannelsNames');
            Filename = strcat(path,ChannelsNames(j),'-','SM_SG','.wav');
            Filename = Filename{:};
            %Creo objeto de Escritura
            createWriter(j,Filename);
        end
        cla(handles.ax_chan1)
        cla(handles.ax_chan2)
        cla(handles.ax_chan3)
        cla(handles.ax_chan4)
        RECv7;
        
    case 'SM_G'
        
        for i = 1:360/intervalo_angular;
            for j = 1:active_chan
                %Nombre de Archivo
                load('app_data/current.mat','path');
                load('app_data/current.mat','ChannelsNames');
                Filename = strcat(path,ChannelsNames(j),'-','SM_G','-',num2str(intervalo_angular*(i-1)),'grados','.wav');
                Filename = Filename{:};
                createWriter(j,Filename);
            end
        cla(handles.ax_chan1)
        cla(handles.ax_chan2)
        cla(handles.ax_chan3)
        cla(handles.ax_chan4)
        RECv7;
        girar;
        flag_rec = 1;
        save('app_data/current.mat','flag_rec','-append')
        end
                
    case 'CM_SG'
        
        for j = 1:active_chan 
            %Nombre de Archivo
            load('app_data/current.mat','path');
            load('app_data/current.mat','ChannelsNames');
            Filename = strcat(path,ChannelsNames(j),'-','CM_SG','.wav');
            Filename = Filename{:};
            %Creo objeto de Escritura
            createWriter(j,Filename);
        end
        cla(handles.ax_chan1)
        cla(handles.ax_chan2)
        cla(handles.ax_chan3)
        cla(handles.ax_chan4)
        RECv7;
                
    case 'CM_G'
    
        for i = 1:360/intervalo_angular;
            for j = 1:active_chan
                %Nombre de Archivo
                load('app_data/current.mat','path');
                load('app_data/current.mat','ChannelsNames');
                Filename = strcat(path,ChannelsNames(j),'-','CM_G','-',num2str(intervalo_angular*(i-1)),'grados','.wav');
                Filename = Filename{:};
                createWriter(j,Filename);
            end
        cla(handles.ax_chan1)
        cla(handles.ax_chan2)
        cla(handles.ax_chan3)
        cla(handles.ax_chan4)
        RECv7;
        girar;
        flag_rec = 1;
        save('app_data/current.mat','flag_rec','-append')
        end
end


end

