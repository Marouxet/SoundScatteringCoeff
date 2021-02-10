function [sweep ,invsweepfft, sweepRate] = synthSweep(T,FS,f1,f2,maxamp, timesilence)

% SYNTHSWEEP Synthesize a logarithmic sine sweep.
%   Modificado a partir del archivo generado por Oygo Sound LLC (ver
%   licencia)
%   [sweep invsweepfft sweepRate] =
%   SYNTHSWEEP(T,FS,f1,f2,maxamp,timesilence)
% Genera barridos senoidales logaritimos sintetizando la magnitud y el
% retardo de grupo por separado y luego aplicando ifft. T es la duración
% del barrido, FS la frecuencia de sampleo, f1 y f2 las frecuencias de
% inicio y fin de la señal. Maxamp es el valor en dBFS que tiene la señal y
% timeslence es la duración de silencio que se le agrega al sweep. La
% función entrega "sweep" que es el barrido senoidal, e "invsweepfft" que
% es el espectro del filtro inverso. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             DO SOME PREPARATORY STUFF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% number of samples / frequency bins
N = real(round(T*FS));


%%% make sure start frequency fits in the first fft bin
f1 = ceil( max(f1, FS/(2*N)) );

%%% set group delay of sweep's starting freq to one full period length of
%%% the starting frequency, or N/200 if thats too small, or N/10 if its too
%%% big
Gd_start = ceil(min(N/10,max(FS/f1, N/200)));

%%% set fadeout length
postfade = ceil(min(N/10,max(FS/f2,N/200)));

%%% find the length of the actual sweep when its between f1 and f2
Nsweep = N - Gd_start - postfade;

%%% length in seconds of the actual sweep 
tsweep = Nsweep/FS;

sweepRate = log2(f2/f1)/tsweep;

%%% make a frequency vector for calcs (This  has length N+1) )
f = ([0:N]*FS)/(2*N);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             CALCULATE DESIRED MAGNITUDE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% create pink (-10dB per decade, or 1/(sqrt(f)) spectrum
mag = sqrt(f1./f(1:end));
mag(1) = mag(2);

%%% filtrado para iniciar y detener el sweep a las frecuencias de diseño
[mag, B] = filter_sweep(mag,f1,f2,FS);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%            CALCULATE DESIRED GROUP DELAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% calc group delay for arbitrary mag spectrum with contant time envelope
%%% from Muller eq's 11 and 12
C = tsweep ./ sum(mag.^2);
Gd = C * cumsum(mag.^2);
Gd = Gd + Gd_start/FS; % add predelay
Gd = Gd*FS/2;   % convert from secs to samps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%            CALCULATE DESIRED PHASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% integrate group delay to get phase
ph = grpdelay2phase(Gd);

%%% force the phase at FS/2 to be a multiple of 2pi using Muller eq 10
%%% (but ending with mod 2pi instead of zero ...)
ph = ph - (f/(FS/2))*mod(ph(end),2*pi);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             SYNTHESIZE COMPLEX FREQUENCY RESPONSE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cplx = mag.*exp(sqrt(-1)*ph); %%% put mag and phase together in polar form
cplx = [cplx conj(fliplr(cplx(2:end-1)))]; %%% conjugate, flip, append for whole spectrum

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             EXTRACT IMPULSE RESPONSE WITH IFFT AND WINDOW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ir = real(ifft(cplx));
err = max(abs(imag(ifft(cplx))));  %%% if this is not really tiny then something is wrong

%%% create window for fade-in and apply
w = hann(2*Gd_start)';
I = 1:Gd_start;
ir(I) = ir(I).*w(I);

%%% create window for fade-out and apply
w = hann(2*postfade)';
I = Gd_start+Nsweep+1:Gd_start+Nsweep+postfade;
ir(I) = ir(I).*w(postfade+1:end);

%%% force the tail beyond the fadeout to zeros
I = Gd_start+Nsweep+postfade+1:length(ir);
ir(I) = zeros(1,length(I));

%%% cut the sweep down to its correct size
ir = ir(1:end/2);

%%% Ajuste de la amplitud 
ir = ir/(max(abs(ir(:))));
ir =ir * 10^(maxamp/20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        AGREGANDO CEROS A LA SALIDA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
silence_n = timesilence*FS;
ir = [ir zeros(1,silence_n)];

%%%Ahora la FFT va a tener el mismo tamaño que el archivo (porque tomo la
%%%ventana para la FFT con la inclusión de los ceros.


%%% get fft of sweep to verify that its okay and to use for inverse
irfft = fft(ir);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             CREATE INVERSE SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% start with the true inverse of the sweep fft
%%% this includes the band-pass filtering, whos inverse could go to
%%% infinity!!!
invirfft = 1./irfft;

%%% volvemos a aplicar el filtro pasabanda para evitar la tendencia al
%%% invertirlo de tender a infino. 
[H1 W1] = freqz(B,1,length(irfft),FS,'whole');

%%% apply band pass filter to inverse magnitude
invirfftmag  = abs(invirfft).*abs(H1)';%'.*abs(H2)';

%%% get inverse phase
invirfftphase = angle(invirfft);

%%% re-synthesis inverse fft in polar form
invirfft = invirfftmag.*exp(sqrt(-1)*invirfftphase);


%%% assign outputs
invsweepfft = invirfft;
sweep = ir;






