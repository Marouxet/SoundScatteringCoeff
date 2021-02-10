function [] = Act_canal (canal, handles)
%ACT_CANAL Activa un canal de grabación al presionar ON
%  Se encarga de tomar nformación sobre el nombre del archivo del handles (debe ser el nombre con el
%  que se encuentra en la GUI maininterface y de tomar información sobre el
%  ChannelMapping (del menú desplegable que se encuentra en el canal). Esa
%  información la guarda en Disco para poder luego generar los objetos de
%  escritura de audio dsp.AudioFileWriter

switch canal
    case 1
        %Tomar el ChannelMapping 
        load ('app_data/current.mat','nChannels');
        Canal = get(handles.c1_canales,'String');
        select = get(handles.c1_canales,'Value');
        Canal = str2double(Canal(select));
        nChannels(1) = Canal;
        save('app_data/current.mat','nChannels','-append');

        %Guardar nombre de archivo
        load('app_data/current.mat','ChannelsNames');
        Name  = get(handles.c1_name,'String');
        ChannelsNames(1) = {Name};
        save('app_data/current.mat','ChannelsNames','-append');
            
    case 2
        load ('app_data/current.mat','nChannels');
        Canal = get(handles.c2_canales,'String');
        select = get(handles.c2_canales,'Value');
        Canal = str2double(Canal(select));
        nChannels(2) = Canal;
        save('app_data/current.mat','nChannels','-append');

        load('app_data/current.mat','ChannelsNames');
        Name = get(handles.c2_name,'String');
        ChannelsNames(2) = {Name};
        save('app_data/current.mat','ChannelsNames','-append');  
        
    case 3
        load ('app_data/current.mat','nChannels');
        Canal = get(handles.c3_canales,'String');
        select = get(handles.c3_canales,'Value');
        Canal = str2double(Canal(select));
        nChannels(3) = Canal;
        save('app_data/current.mat','nChannels','-append');

        load('app_data/current.mat','ChannelsNames');
        Name = get(handles.c3_name,'String');
        ChannelsNames(3) = {Name};
        save('app_data/current.mat','ChannelsNames','-append');

    case 4
        load ('app_data/current.mat','nChannels');
        Canal = get(handles.c4_canales,'String');
        select = get(handles.c4_canales,'Value');
        Canal = str2double(Canal(select));
        nChannels(4) = Canal;
        save('app_data/current.mat','nChannels','-append');


        load('app_data/current.mat','ChannelsNames');
        Name = get(handles.c4_name,'String');
        ChannelsNames(4) = {Name};
        save('app_data/current.mat','ChannelsNames','-append')
       
end

end

