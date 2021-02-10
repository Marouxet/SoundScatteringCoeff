function suma = PromediosV2(Sweep,SweepOrig,n_registro,suma)

[corr, lag]=xcorr(Sweep,SweepOrig);
[~,I] = max(abs(corr));
lagDiff = lag(I);
if lagDiff<0
    lagDiff = - lagDiff;
end
Sweep_cut = Sweep(lagDiff:end);

        %Análisis de la polaridad de la señal, usando el valor de la fase.
        if angle(fft(Sweep(1))) - angle(fft(SweepOrig(1))) == 0
            pol = 1;
        elseif angle(fft(Sweep(1))) - angle(fft(SweepOrig(1)))  == 2*pi;
            pol = 1;
        elseif angle(fft(Sweep(1))) - angle(fft(SweepOrig(1)))  == pi;
            pol = 0;
        elseif angle(fft(Sweep(1))) - angle(fft(SweepOrig(1)))  == -pi;
            pol = 0;
        end
        
if pol == 0; 
    Sweep_cut = -Sweep_cut; 
end


if n_registro == 1
    suma = zeros(size(Sweep_cut));
end

A = length(suma)-length(Sweep_cut);

if A>0
    suma = suma + [Sweep_cut  ; zeros(A,1)];
elseif A<0
        suma = Sweep_cut + [suma ; zeros(-A,1)];
else
        suma = suma + Sweep_cut;
end

end