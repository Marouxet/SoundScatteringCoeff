function y = FastHadamard(x, P1, N)
% Applies a Fast Hadamard transform to a 1-D signal
%
% y = FastHadamard(x, P, N)
%
% x:	Signal to be transformed
% P:	Length of MLS, where P=2N-1
% N:	Order of MLS
% y: 	Transformed signal

k1 = P1;
for k=1:1:N
    k2 = k1/2;
    for j=1:1:k2
        for i=j:k1:P1
            i1 = i + k2;
            temp = x(i) + x(i1);
            x(i1) = x(i) - x(i1);
            x(i) = temp;
        end
    end
    k1 = k1/2;
end

y = x;