N = 3;
mls = [1 1 0 1 0 0 1];
M = length(mls)
S = zeros(N,M);

S(1,:) = mls;

for i = 2:N
    S(i,:) = [mls(i:M) mls(1:i-1)];
end

tita = S(:,1:N);

tita_inv = inv(tita);


L = S' * tita_inv;