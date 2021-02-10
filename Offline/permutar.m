function  [S,P1] = permutar( mls, N )
% MATRIZ contiene a la secuencia MLS desplazada un elemento en cada columna
M = 2^N-1;
%sequence = (mls-1)./-2; 
S = zeros(N,M);
S(1,:) = mls;
for i = 2:N
    S(i,:) = [mls(i:M) mls(1:i-1)];
end

%%

%%%%b es la suma (con peso binario) de las N primeras filas de MATRIZ para
%%%%cada columna.  A partir de b se puede ordenar MATRIZ
P1 = zeros(1,M);
for i = 1:M
    P1(i) = 0;
    for j=1:N
        P1(i) = P1 (i) + S(j,i)*2^(N-j);
    end
end

%%%%%Se ordena b y se obtiene J que es la columna de MATRIZ que hay que
%%%%%colocar en cada columna de MATRIZ_ORD para que esta siga el orden de b
% [~, J] =sort(suma);
% 
% MATRIZ_ORD = zeros (size(MATRIZ));
% 
% for i = 1:M
%     MATRIZ_ORD(:,i)= MATRIZ(:,J(i));
% end
% 
% %%%%%%Obtención de la permutacion de columnas
% b2 = zeros(M,1);
% for i = 1:M
%         for j=1:N
%         k = 2^(j-1);
%         b2(i) = b2(i) + MATRIZ_ORD(i,k)*k;
%         end
% end

end

