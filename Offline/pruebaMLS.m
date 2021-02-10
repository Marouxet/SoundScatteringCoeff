clear
clc
%%Prueba Generador MLS Orden 15 subtipo B

%% http://www.silcom.com/~aludwig/Signal_processing/Maximum_length_sequence
%% s.htm#Appendix

N= 3; M = 2^N-1;

%m = zeros(1,N); m(1)=1; m(3)=1; m(4)=1; m(8)=1; m(13)=1;m(15) = 1;  %Carga
%el registro de desplazamiento con la semilla original para N = 15

m = [0 1 0];
%m = zeros(1,N); m(1) = 1;
m2 = zeros(3,7);

regout = zeros(1,M); %general el vector de salida

for i = 1:M

buf = xor(m(3),m(1)); %Xor entre la posición 14 y 15 del registro de dezplazamiento
m2(:,i)= m';
m(2:N) = m(1:N-1); %desplaza el registro 1 posición

m(1)=buf; %carga el Xor en la posición 1 del registro

regout(i) = m(3); %carga la salida del registro en el primer elemento del vector salida

end

comp = ~ regout; %No se que hace eso 
sequence = regout;% - comp;

% 
% MATRIZ = zeros(M,M);
% MATRIZ(1,:) = sequence;
% for i = 2:M
%     MATRIZ(i,:) = [sequence(i:M) sequence(1:i-1)];
% end
% 
% %%%%%%%%%%%%%%%%Permutación de columnas
% b = zeros(1,M);
% for i = 1:M
%     suma(i) = 0;
%     for j=1:N
%         suma(i) = suma (i) + MATRIZ(j,i)*2^(N-j);
%     end
%     
% %b(i) = MATRIZ(1,i)*4 + MATRIZ(2,i)*2 + MATRIZ(3,i)*1;
% end
% b = suma;
% 
% sequence
% MATRIZ
% 
% [H J] =sort(b);
% J
% for i = 1:M
%     MATRIZ_ORD(:,i)= MATRIZ(:,J(i));
% end
% MATRIZ_ORD
% 
% %%%%%%%%%%%%%%%%%Permutación de filas
