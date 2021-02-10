%%%%%ANALISIS DE LA SEÑAL MLS
mls = [0 0 1 0 1 1 1];
y = mls; %En este caso uso la salida = que la entrada, para ver si obtengo un impulso



tagS = GeneratetagS(mls,length(mls),3); %Encuentro el orden en S

 for i = 1:length(mls);                  %Ordeno la salida de acuerdo a S   
y2(i) = y(find(tagS ==i));
end
y2 = [0 y2];                            %le agrego un cero;

g = fwht(y2);
g = g(2:end);

tagL = GeneratetagL(mls,length(mls),3);

fact = 1/(length(mls)+1);

resp = g(tagL).*fact;
