function [Reader] = createReaderV2(~);
load('app_data/current.mat','file')
load('app_data/settings.mat','SamplesPerFrame')
load('app_data/settings.mat','nBits');

Reader = dsp.AudioFileReader;
Reader.Filename = file;
Reader.PlayCount = 1;

Reader.SamplesPerFrame = SamplesPerFrame;

if nBits == 16
    Reader.OutputDataType = 'int16';
else
    Reader.OutputDataType ='single';
end

save('app_data/current.mat','Reader','-append')
end