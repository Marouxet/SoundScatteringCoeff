function [sequence] = mls_gen( N,taps )
%MLS_gen Genera una secuencia MLS. 
%   A partir de un registro de desplazamiento
%de orden N y la realimentación del primer bit con una compuerta XOR entre 
%los bits definidos en taps. taps debe ser un vector de 1 fila y a columnas
%Para que la secuencia sea MLS, el vector en taps debe cumplir dicha 
%condición. La longitud de la secuencia es 2^N-1.

M = 2^N-1; %define el largo de la señal
regout = zeros(1,M); %general el vector de salida
m = ones(1,N); %general el registro de desplazamiento todo cargados con 1 (PRUEBA)
% m2 = zeros(N,M);
if length(taps)==2    
    for i = 1:M

    buf = xor(m(taps(2)),m(taps(1))); %Xor entre la posición 1 y 2 del vector taps 
   % m2(:,i)= m';
    m(2:N) = m(1:N-1); %desplaza el registro 1 posición

    m(1)=buf; %carga el Xor en la posición 1 del registro
    %m2(:,i)= m';
    regout(i) = m(N); %carga la salida del registro en el primer elemento del vector salida

    end
else
    for i = 1:M
    buf = 0;  %defino un bufer = 0 porque el 0 es transparente a la función XOR
    for j = 1:length(taps)
    buf = xor(buf,m(taps(j))); %Xor el valor anterior de buffer y el siguiente valor en taps (for entre múltiples bits)
    end
   % m2(:,i)= m';
    m(2:N) = m(1:N-1); %desplaza el registro 1 posición

    m(1)=buf; %carga el Xor en la posición 1 del registro
   % m2(:,i)= m';
    regout(i) = m(3); %carga la salida del registro en el primer elemento del vector salida

    end
end
sequence = regout;

% %Mapeo de 1 y 0 a -1 y 1
 comp = ~ regout; 
 sequence = regout - comp;
end

