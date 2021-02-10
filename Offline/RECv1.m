%Grabador multicanal usando los dispostivos creados por createRecord y
%createWriter. Versión beta


%Cargo el objeto de grabación
load('app_data/current.mat','Record');
%Cargo los objetos de escritura
load('app_data/current.mat','Writer');
load('app_data/settings.mat','objectName');
%Cargo el flag record
load('app_data/current.mat','flag_rec');

%Cargo los graficos
load('app_data/current.mat','ax_chan1');
load('app_data/current.mat','ax_chan2');

%Cargo data relativa a graficar
load('app_data/settings.mat','SamplesPerFrame');
load('app_data/settings.mat','SampleRate');
n = 1; %Cantidad de muestras que se grafican por cada frame de audio tomado
k = 0.7; % Cantidad de segundos cada los que se grafica
cant = round((k*SampleRate)/SamplesPerFrame);
buf_plot = zeros(cant,length(Record.ChannelMapping));
time = linspace(0,k,cant);

memory = zeros(Record.BufferSize,length(Record.ChannelMapping));

j = 0;
m = 0; %cantidad de pasos de graficacion
while flag_rec ==1
    % i es la cantdad de canales q grabo simultáneamente
    %j es la cantidad de frames que se van grabando
    j = j + 1;
    memory = step(Record);
    for i = 1:length(objectName)
    name = char(objectName{i});
    step(Writer.(name), memory(:,i));
    end
   
    buf_plot(j,:) = mean(memory); %Guardando la muestra 300 de cada frame
    if j==cant
       plot(ax_chan1,time+m*k,buf_plot(:,1))
       hold on
%       plot(ax_chan2,time+m*k,buf_plot(:,2))
       hold on
       drawnow
     j = 0;  
     m = m+1;
    end
   
%Cargo nuevamente el flag record, por si el usuario presionó STOP      
load('app_data/current.mat','flag_rec');

end

release(Record);
for i =1:length(objectName)
name = char(objectName{i});

release(Writer.(name));
end
