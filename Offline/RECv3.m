%Grabador multicanal usando los dispostivos creados por createRecord, 
%createWriter, createrPlayer y createrReader. Versión beta

load('app_data/current.mat','active_chan')
switch active_chan
    case 1
%Cargo el objeto de lectura
load('app_data/current.mat','Reader');
%Cargo el objeto de grabación
load('app_data/current.mat','Record');
%Cargo los objetos de escritura
load('app_data/current.mat','Writer');
load('app_data/settings.mat','objectName');
%Cargo el flag record
load('app_data/current.mat','flag_rec');
%Cargo el objeto de Reproduccion
load('app_data/current.mat','Player');
Player.ChannelMapping = 1;
%Cargo los graficos
load('app_data/current.mat','ax_chan1');

%Cargo data relativa a graficar
load('app_data/settings.mat','SamplesPerFrame');
load('app_data/settings.mat','SampleRate');
n = 2048; %Cantidad de muestras que se grafican por cada frame de audio tomado
k = 20480; % Cantidad de muestras cada las que se grafica debe ser multiplo de la cantidad de samples per frames.
cant = round((k/SamplesPerFrame));
buf_plot = zeros(cant,length(Record.ChannelMapping));

time = 1:k;%,cant);

tictoc = zeros(1,1000);
memory = zeros(Record.BufferSize,length(Record.ChannelMapping));

j = 0; %j es la cantidad de frames que se van grabando
m = 0; %cantidad de pasos de graficacion
x = 1;
while flag_rec ==1
    % i es la cantdad de canales q grabo simultáneamente
    
    j = j + 1;
    play = step(Reader);
    step(Player, play);
        
    memory = step(Record);
    for i = 1:length(objectName)
    name = char(objectName{i});
    step(Writer.(name), memory(:,i));
    end
    tic;
       buf_plot((j-1)*n+1:j*n,:) = memory; %Guardando el promedio de el frame
    if j==cant
        
       plot(ax_chan1,time+m*k,buf_plot(:,1))
       hold on
       drawnow
       j = 0;  
       m = m+1;
           
    end
   tictoc(x) = toc;
 x = x+1;
%Cargo nuevamente el flag record, por si el usuario presionó STOP      
load('app_data/current.mat','flag_rec');

end

save ('app_data/current.mat','tictoc','-append');
release(Record);
release(Player);
release(Reader);
for i =1:length(objectName)
name = char(objectName{i});

release(Writer.(name));
end

    case 2
 
        
end