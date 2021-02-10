
load('app_data/current.mat','matriz_filename')

for n_registro = 1:6
    
registro_actual = audioread(matriz_filename{n_registro}); %Leo el archivo de audio actual
registro_actual = registro_actual/max(registro_actual);    %Normalizo

%%%%%%%%%%FIND T_sincro

v_10  = find(registro_actual>0.1,1); %Encuentro la primera vez que el archivo es mayor que el 10% de la amplitud positiva
v_10n = find(registro_actual<-0.1,1); %Encuentro la primera vez que el archivo es menor que el 10% de la amplitud negativa

%Considero que el archivo está "en fase" si primero tiene el semiciclo
%positivo;

if v_10 > v_10n
    registro_actual = -registro_actual;
    v_10  = find(registro_actual>0.1,1);
    v_10n = find(registro_actual<-0.1,1);
end

t_sincro = v_10 + find(registro_actual(v_10:end)<0 ,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Definición de la suma para el caso en el que analizo el primer vector
if n_registro == 1
    suma = zeros(size(registro_actual));
    t_sincro_ant = t_sincro;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Zero padding para poder sumar

A1 = suma(1:t_sincro_ant - 1);
B1 = suma(t_sincro_ant:end);

A2 = registro_actual(1:t_sincro-1);
B2 = registro_actual(t_sincro:end);

if length(A1) > length(A2)
    registro_actual = [zeros(length(A1)-length(A2),1) ; registro_actual];
    t_sincro = t_sincro + length(A1)-length(A2);
elseif length(A1) < length(A2)
    suma = [zeros(length(A2)-length(A1),1) ; suma];
    t_sincro_ant = t_sincro_ant + length(A2)-length(A1);
end

if length(B1) > length(B2)
    registro_actual = [registro_actual ; zeros(length(B1)-length(B2),1)];
    
elseif length(B1) < length(B2)
    suma = [suma ; zeros(length(B2)-length(B1),1)];
    
end

suma = suma + registro_actual;
t_sincro_ant = t_sincro;

end