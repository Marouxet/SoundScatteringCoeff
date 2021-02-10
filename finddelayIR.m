%Prueba: encontrar delay inicial buscando la autocorrelación entre el
%impulso y su componente de fase mínima
function [lagDiff] = finddelayIR(IR)
data=IR;
[~,ym] = rceps(data);

[corr, lag, pol]=xcorrMOD(data,ym);
[~,I] = max(abs(corr));
lagDiff = lag(I)  ;
if lagDiff<0
    lagDiff = - lagDiff;
end

data = data(lagDiff:end);
figure(1)
subplot(3,1,1);
plot(data)
subplot(3,1,2)
plot(IR)
subplot(3,1,3)
plot(ym)
t = 1:length(IR);
figure(2)
plot(t(1:lagDiff),IR(1:lagDiff),'r',t(lagDiff+1:end),IR(lagDiff+1:end),'b')