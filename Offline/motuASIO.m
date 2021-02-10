%Grabador multicanal usando los dispostivos creados por createRecord y
%createWriter. Versión beta

%Cargo el objeto de grabación
load('app_data/current.mat','Record');
%Cargo los objetos de escritura
load('app_data/current.mat','Writer');
load('app_data/settings.mat','objectName');
%Cargo el flag record
load('app_data/current.mat','flag_rec');


memory = zeros(Record.BufferSize,length(Record.ChannelMapping));

tic
while toc <10
    
    memory = step(Record);
    for i = 1:length(objectName)
     
    name = char(objectName{i});
    step(Writer.(name), memory(:,i));
           
    end

%Cargo nuevamente el flag record, por si el usuario presionó STOP      
load('app_data/current.mat','flag_rec');
end

release(Record);
for i =1:length(objectName)
name = char(objectName{i});

release(Writer.(name));
end

 