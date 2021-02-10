function [inputdevices, maxinp, maxout] = inputhardware()
%Primro leo que dispositivos hay
inputdev = dspAudioDeviceInfo;



for i = 1:length(inputdev)
inputdriver= 'ASIO';
borrar = length(inputdriver) + 3;
inputdevice = inputdev(i).name;
inputdevice = inputdevice(1:length(inputdevice)-borrar);
inputdevices{i} = inputdevice;
maxinp(i) = inputdev(i).maxInputs;
maxout(i) = inputdev(i).maxOutputs;
end

for i = 1:length(inputdevices)
inputdevices(i+1) = inputdevices(i);
inputdevices{1} = 'Seleccionar Hardware';
end

end

