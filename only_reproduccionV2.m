%  Player = createPlayerV2(1);
%  Reader = createReaderV2();


load('app_data/settings.mat','BufferSize')
load('app_data/settings.mat','QueueDuration')
load('app_data/settings.mat','SampleRate');
load('app_data/settings.mat','sec_factor');
load('app_data/settings.mat','objectName');
%load('app_data/current.mat','flag_rec')


silencio = zeros(BufferSize,1);
latency = (QueueDuration * SampleRate + 2 * BufferSize)/SampleRate;
flag_rec = 1;
i = 0;
while flag_rec == 1;

%         if ~isDone(Reader)
%                 play = [step(Reader) silencio];
%                 step(Player, play);
%                 tic;
%         end
% 
%     a = get(handles.transport_stop,'Value');
%     if a ==1
%     flag_rec = 0;
%     end
i = i + 1 
flag_rec = ~get(handles.transport_stop,'Value');

end

release(Player);
release(Reader);
