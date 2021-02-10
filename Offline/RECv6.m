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

tictoc = zeros(1,1000);
memory = zeros(Record.BufferSize,length(Record.ChannelMapping));

j = 0; %j es la cantidad de frames que se van grabando
m = 0; %cantidad de pasos de graficacion
x = 1;

while ~isDone (Reader); %flag_rec ==1
    
    % i es la cantdad de canales q grabo simultáneamente
   
    play = step(Reader);
    step(Player, play);
    memory = step(Record);
    for i = 1:length(objectName)
    name = char(objectName{i});
    step(Writer.(name), memory(:,i));
    end
    
   [j,m,x] =  graph(4,1, memory,j,m,x );
    
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