function [cross2] = lundebys(ir,fs)
%Lundeby’s Method to calculate IR's
%Las frases en ingles fueron extraídas del paper. Las anotaciones en
%español fueron hechas por el autor

t2 = 0:length(ir)-1;
t2 = t2/fs;
t2 = t2'; 

ir2 = ir.^2;
ir2 = ir2/max(ir2);

%1 - The squared impulse response is averaged into local
%time intervals in the range of 10–50 ms to yield a smooth
%curve without losing short decays.

int = 0.01; %se toman 10 mS
muestras_int = int*fs; %Cantidad de muestras a las que corresponden int segundos.

t = floor(length(ir2)/muestras_int); %Cantidad de intervalos en los que se divide el largo de ir2. Va a ser el nuevo largo del impulso Smootheado

v = floor(length(ir2)/t); %Cantidad de muestras por intervalo

for n=1:t
    media(n) = mean(ir2((((n-1)*v)+1):(n*v))); %Se promedian V muestras alrededor de cada intervalo.
    tiempo(n) = ceil(v/2)+((n-1)*v); %Me centro en el medio del intervalo y luego me corro de acuerdo al loop for
end

mediadB = 10*log10(media);


%2 - A first estimate for the background noise level is
%determined from a time segment containing the last 10%
%of the impulse response. This gives a reasonable statistical
%selection without a large systematic error if the decay continues
%to the end of the response.

noise_ini1 = fix(0.9*length(ir2));%Valor en muestras del 90% del largo del Impulso
noise1_v = 10*log10(mean(ir2(noise_ini1:end)));%Valor normalizado del ruido de fondo


%3) The decay slope is estimated using linear regression
%between the time interval containing the response 0-dB
%peak and the first interval 5–10 dB above the background
%noise level.

[~ , inicio1]= max(mediadB); %Encuentro la muestra donde está el máximo del impulso

mediadB2 = mediadB(inicio1:end); %Me quedo con lo que está a la derecha del máximo, para eliminar el ruido de fondo del comienzo

r = find( mediadB2 > noise1_v + 10,1,'last')+inicio1;%Encuentro todas las posiciones de 
%mediaB2 que son 10 dB mayores al valor del ruido. Luego, con last, 
%encuentro la mayor, o sea la que está más a la derecha. 

if any ( mediadB2(1:r-inicio1) < noise1_v + 10) %En caso que se cumpla esto, estoy 
%en un valor 10 dB mayor al ruido de fondo, pero dentro del sector 
%considerado ruido
%En ese caso, redefino r buscando el valor más a la izquiera que es menor a
%10dB por encima del ruido de fondo, dentro del rango pre-fijado
    r = find(mediadB2(1:r-inicio1) < noise1_v+10,1,'first') + inicio1;
end

% if isempty(r)
%     r=10
% elseif r<10
%     r=10;
% end


P = polyfit(tiempo(inicio1:r),mediadB(inicio1:r),1); %Encuentro los coeficientes del polinomio de orden 1 que mejor aproximan a ir2 en el rango
B = P(1); %Pendiente,
A = P(2); %Ordenada al origen;

%4) A preliminary crosspoint is determined at the intersection
%of the decay slope and the background noise
%level.

cross1 = (noise1_v-A)/B; 
%El valor de cross en muestra se obtiene buscando caundo la recta es igual
%al valor noise1_v en amplitud. El resultado en muestras incluye a lo que
%está antes del máximo.
error = 100;
max_it = 50;
rep = 1;
 while (error > 0.0001 && rep <= max_it)
    
     clear v t media mediadB tiempo
%5) A new time interval length is calculated according to
%the calculated slope, so that there are 3–10 intervals per 10
%dB of decay.
%int_x_10dB = 5; %Cantidad de intervalos que hay en 10 dB de decay
%delta = 10/int_x_10dB; %dB en cada intervalo

%RECORDATORIO: eq de una recta (B = pendiente)
%
% B = (Y2 -Y1 )/(X2 - X1) = dY/dX
%En este caso dY = delta por lo que dX (cantidad de muestras) es
%dX = delta/B


        p = 5;                          %numero de passos por decada
        delta = abs(10/B);              %numero de amostras para o a linha de tendencia decair 10dB
        v = floor(delta/p);             %intervalo para obtencao de media
        t = floor(length(ir2(1:round(cross1-delta)))/v);

%v = floor(abs(delta/B)); %V es la cantidad de muestras que corresponden a un nuevo intervalo.
%t = floor(length(ir2(1:round(cross1-delta)))/v);
%t es la cantidad de intervalos en las que se divide el nuevo rango. Se lo
%acorta hasta cross1-delta. Por lo indicado en el punto 5, el intervalo
%debe ser calculado ACORDE a la pendiente. la pendiente va hasta 5-10 dB
%antes del punto de 

%6 The squared impulse is averaged into the new local
%time intervals.

        for n=1:t
            media(n) = mean(ir2((((n-1)*v)+1):(n*v)));
            tiempo(n) = ceil(v/2)+((n-1)*v);
        end
        mediadB = 10*log10(media);
clear A B noise1_v;
P = polyfit(tiempo,mediadB,1); %Encuentro los coeficientes del polinomio de orden 1 que mejor aproximan a ir2 en el rango. No se acorta el rango porque ya fue acortado al definir t y v.
B = P(1); %Pendiente,
A = P(2); %Ordenada al origen;


%7) The background noise level is determined again. The
%evaluated noise segment should start from a point corresponding
%to 5–10 dB of decay after the crosspoint, or a
%minimum of 10% of the total response length.

noise_ini1 = length(ir2) - cross1 + delta;  %El nuevo sector de ruido comienza 5 dB luego del punto de cruce(o delta muestras)

if noise_ini1 < round(.1*length(ir2)) %Caso en el que el nuevo intervalo de ruido es más corto que el 10% del IR
     noise_ini1 = fix(0.9*length(ir2));%EL ruido vuelve a empezaar en el 90% del largo del Impulso 
end       
noise1_v = 10*log10(mean(ir2(noise_ini1:end)));%Valor normalizado del ruido de fondo

%9) A new crosspoint is found.
cross2 = round((noise1_v-A)/B);
error = abs(cross2 - cross1);
cross1 = cross2; %hago el update del error.
rep = rep + 1; %aumento el contador de repetición

 end
 
%8) The late decay slope is estimated for a dynamic range
%of 10–20 dB, starting from a point 5–10 dB above the
%noise level.
pre_fin2 = find(sector<noise2_v+5,1);
pre_ini1 = find(sector<sector(pre_fin2)+15,1);
to_polyfit2 = ave2(inicio1+pre_ini1:inicio1+pre_fin2);
decay2_c = polyfit(t(inicio1+pre_ini1:inicio1+pre_fin2),to_polyfit2,1);
decay2 = polyval(decay2_c,t);



%figure

plot(t,ir2,'b',t,noise,'g',t,decay1,'g',t,ave,'y',t,ave2,'c',t,decay2,'r',t,noise2,'r')

%plot(t,ir2,'b',t,noise2,'g',t,decay2,'r',t,ave2,'y')

