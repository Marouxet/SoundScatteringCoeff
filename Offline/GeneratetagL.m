function tagL = GeneratetagL(mls, P, N)
% Generates array for the rearrangement of samples after a Hadamard Transform
%
% tagL = GeneratetagL(mls, P, N);
%
% mls:		The MLS signal for which tagL is valid.
% P:		Length of the MLS signal
% N:		Order of the MLS signal
% tagL:		1x(P+1) vector of indices.


% Convert {-1,1} to binary
%binmls = (mls-1)./-2; 
binmls = mls;
S = GeneratetagS(mls,P,N);

% Find which values of the tagS vector are powers of 2
for i=1:1:P
    for j=1:1:N
        if (S(i) == 2^(j-1))
            index(j) = i;
        end
    end
end

powerindices = 0:1:N-1;
powers = 2.^powerindices;

for i=1:1:N
  L(i,1:mod(index(i),P)) = binmls(mod(index(i),P):-1:1);
  L(i,mod(index(i),P)+1:P) = binmls(P:-1:mod(index(i),P)+1);
end

tagL = powers*L;