function [ mag , B] = filter_sweep( mag,f1,f2,FS )
%FILTER_SWEEP Filtro pasa banda para la generación de barrido senoidales
%   mag es la magnitud deseada (-3dB por octava para log-sine-sweep) f1 es
%   la frecuencia inferior del pasa banda, f2 es la frecuencia superior.
%   Son las frecuencias de inicio y final del barrido. FS es la frecuencia
%   de sampleo. Esta función se coloca a parte para poder probar con
%   diferenes tipo de filtros ( IIR, FIR, distintos órdenes) ya que el
%   filtro original (Butterworth de 2do orden) no generaba los resultados experados.


%%%%Generación del 

%FIR por ventana Kaiser
B = fir1(8000,[f1/(FS/2) f2/(FS/2)] ,kaiser(8001,20));

[H1 , W1] = freqz(B,1,length(mag),FS);


%Codigo original
% Create band pass magnitude to start and stop at desired frequencies
% [B1 A1] = butter(2,f1/(FS/2),'high' );  %%% HP at f1
% [B2 A2] = butter(2,f2/(FS/2));          %%% LP at f2
%Convert filters to freq domain
%[H1 W1] = freqz(B1,1,N+1,FS);          
%[H2 W2] = freqz(B2,1,N+1,FS);

%Filtrado
mag = mag.*abs(H1)';
end

