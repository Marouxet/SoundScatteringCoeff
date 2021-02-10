%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%Obtención de matrices de permutación%%%%%%%%%%%%%%%%%

% MATRIZ contiene a la secuencia MLS desplazada un elemento en cada columna
MATRIZ = zeros(M,M);
MATRIZ(1,:) = sequence;
for i = 2:M
    MATRIZ(i,:) = [sequence(i:M) sequence(1:i-1)];
end

%%

%%%%b es la suma (con peso binario) de las N primeras filas de MATRIZ para
%%%%cada columna.  A partir de b se puede ordenar MATRIZ
suma = zeros(1,M);
for i = 1:M
    suma(i) = 0;
    for j=1:N
        suma(i) = suma (i) + MATRIZ(j,i)*2^(N-j);
    end
end

b = suma;
%%%%%Se ordena b y se obtiene J que es la columna de MATRIZ que hay que
%%%%%colocar en cada columna de MATRIZ_ORD para que esta siga el orden de b
[~, J] =sort(suma);

MATRIZ_ORD = zeros (size(MATRIZ));

for i = 1:M
    MATRIZ_ORD(:,i)= MATRIZ(:,J(i));
end

%%%%%%Obtención de la permutacion de columnas
b2 = zeros(M,1);
for i = 1:M
        for j=1:N
        k = 2^(j-1);
        b2(i) = b2(i) + MATRIZ_ORD(i,k)*k;
        end
end
