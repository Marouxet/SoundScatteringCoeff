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
load('app_data/current.mat','xlimites');
int_plot = 64;
n = SamplesPerFrame / int_plot ; %Cantidad de muestras que son ploteadas en cada FRAME

%n = 256 ; %2048; %Cantidad de muestras que se grafican por cada frame de audio tomado
k = 1920; % Cantidad de muestras cada las que se grafica debe ser multiplo de la cantidad de samples per frames.
cant = round((k/n));
buf_plot = zeros(n,length(Record.ChannelMapping));

tictoc = zeros(1,1000);
memory = zeros(Record.BufferSize,length(Record.ChannelMapping));

j = 0; %j es la cantidad de frames que se van grabando
m = 0; %cantidad de pasos de graficacion
x = 1;
ploteo1 = plot(ax_chan1,nan);
% load('app_data/current.mat','xlimites');
% xlimites = xlimites(2);
% ejex = zeros(1,legnth(xlimites));
%ejey = zeros(1,length(Record.ChannelMapping));
while ~isDone (Reader); %flag_rec ==1
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
    %if mod(j,int_plot) == 0
           buf_plot(m*k+((j-1)*n+1:j*n),:) = memory(1:int_plot:end,:); %Guardando el promedio de el frame
        if j==cant
          %ejey =[ejey(:,1) ;   buf_plot(:,1)];
          %plot(ax_chan1,time+m*k,buf_plot(:,1))
          set(ploteo1,'YData',buf_plot(:,1));
          drawnow
          hold on
          j = 0;  
          m = m+1;  
        end
   % end
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