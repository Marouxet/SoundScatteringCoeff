global flac_rec


Player = createPlayerV2(1);
Reader = createReaderV2();
load('app_data/settings.mat','BufferSize')
load('app_data/settings.mat','QueueDuration')
load('app_data/settings.mat','SampleRate');
load('app_data/settings.mat','sec_factor');
load('app_data/settings.mat','objectName');

silencio = zeros(BufferSize,1);
    while flag_rec == 1  
        if ~isDone(Reader)
         play = [step(Reader) silencio];
         step(Player, play);
        end
    end
release(Player);
release(Reader);