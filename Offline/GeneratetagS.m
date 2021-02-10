function [tagS,S] = GeneratetagS(mls, P, N)
% Generates array for the rearrangement of samples before a Hadamard Transform
%
% tagS = GeneratetagS(mls, P, N);
%
% mls:		The MLS signal for which tagS is valid.
% P:		Length of the MLS signal
% N:		Order of the MLS signal
% tagS:		1x(P+1) vector of indices.


% Convert {-1,1} to binary
binmls = mls;%%mls-1)./-2; 

% Make S matrix by making first line mls and shifting every subsequent row
% RIGHT up to N then multiply each row by the correct power of 2.
powerindices = N-1:-1:0
powers = 2.^powerindices

for i=1:1:N
   S(i, 1:i-1) = binmls(P-i+2:P);
   S(i, i:P) = binmls(1:P-i+1);
end
tagS = powers*S;