binmls = mls; 
N = 3;
P = 2^N-1;

% Busca que valores de P1 son potencia de 2
for i=1:1:P
    for j=1:1:N
        if (P1(i) == 2^(j-1))
            index(j) = i;
        end
    end
end

powerindices = 0:1:N-1;
powers = 2.^powerindices;

for i=1:1:N
  L(i,1:mod(index(i),P)) = binmls(mod(index(i),P):-1:1)
  L(i,mod(index(i),P)+1:P) = binmls(P:-1:mod(index(i),P)+1)
end