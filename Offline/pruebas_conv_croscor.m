%%%Pruebas de convoluci�n y correlaci�n cruzada
n=[-3 -2 -1 0 1 2 3 4 5 6 7 8 9 10]; %vector tiempo
x=[0 0 0 1 2 5 3 5 4 5 2 6 0 0 ]; %se�al x cualquiera

y=[0 0 0 0 1 2 5 3 5 4 5 2 6 0 ]; %desplazamiento de x hacia la izquierda

%Verificaci�n visual 
% figure
% subplot(2,1,1)
% stem(n,x)
% subplot(2,1,2)
% stem(n,y)

%Impulso 
dir = zeros(size(n));
dir(4) = 1;

%Respuesta al impulso del sistema de retardo
h = zeros(size(n));
for i=2:size(n,2);
    h(i) = dir(i-1);
end

[prueba,nfinal]=conv_temp(x,n(1),h,n(1)); %funci�n externa que hace la convoluci�n pero adem�s agrega los vectores temporales

%Verificaci�n visual 
% figure
% subplot(2,1,1)
% stem(n,y)
% subplot(2,1,2)
% stem(nfinal,prueba)


%%%%%%%Correlaci�n
n_x_inv=-fliplr(n); %defino el vector tiempo de la funcion fliprl(x)
[Rxx,n_Rxx]=conv_temp(x,n(1),fliplr(x),n_x_inv(1)); %Autocorrelaci�n de la entrada

[Ryx,n_Ryx]=conv_temp(y,n(1),fliplr(x),n_x_inv(1)); %Correlaci�n cruzada salida Vs entrada

%Convoluci�n entre la Rta Al impulso y la autocorrelacion de la entrada
[final,n_final]=conv_temp(h,n(1),Rxx,n_Rxx(1));

%verificaci�n Visual
figure
subplot(2,1,1)
stem(n_Ryx,Ryx), legend('Autocorrelaci�n de la Salida')
subplot(2,1,2)
stem(n_final,final), legend('Convoluci�n entre la Correlaci�n cruzada de la entrada y la Rta al impulso')


