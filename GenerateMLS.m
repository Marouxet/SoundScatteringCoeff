function  [sequence, mls, n] = GenerateMLS(orden, repetitions, amplitud)
 
% GenerateMLS
%
% Generates an MLS sequence
%
% y = mls(n, flag)
%
% n:        order of MLS (puede ser un string si es que hay dos pociones
% distintas para el mismo orden. Eje: '17A')
% flag:     true for registers initialised to 1, false for random
% y:        P-length MLS sequence, where P=2N-1


switch orden								%assign taps which will yeild a maximum
case '2'								%length sequence for a given bit length
   taps=2;							%I forget the reference I used, but theres
   tap1=1;							%a list of appropriate tap values in
   tap2=2;							%Vanderkooy, JAES, 42(4), 1994.
   n = 2;
case '3'
   taps=2;
   tap1=1;
   tap2=3;
   n = 3;
case '4'
   taps=2;
   tap1=1;
   tap2=4;
   n = 4;
case '5'
   taps=2;
   tap1=2;
   tap2=5;
   n = 5;
case '6'
   taps=2;
   tap1=1;
   tap2=6;
   n = 6;
case '7'
   taps=2;
   tap1=1;
   tap2=7;
   n = 7;
case '8'
   taps=4;
   tap1=1;
   tap2=6;
   tap3=5;
   tap4=8;
   n = 8;
case '9'
   taps=2;
   tap1=4;
   tap2=9;
   n = 9;
case '10'
   taps=2;
   tap1=7;
   tap2=10;
   n = 10;
case '11'
   taps=2;
   tap1=2;
   tap2=11;
   n = 11;
case '12A'
   taps=4;
   tap1=2;
   tap2=10;
   tap3=11;
   tap4=12;
   n = 12;
case '12B'
   taps=4;
   tap1=3;
   tap2=4;
   tap3=7;
   tap4=12;
   n = 12;
    case '13'
   taps=4;
   tap1=1;
   tap2=3;
   tap3=4;
   tap4=13;
   n = 13;
case '14A'
   taps=4;
   tap1=2;
   tap2=12;
   tap3=13;
   tap4=14;
   n = 14;
case '14B'
   taps=4;
   tap1=2;
   tap2=12;
   tap3=13;
   tap4=14;
   n = 14;
case '15A'
   taps=2;
   tap1=14;
   tap2=15;
   n = 15;
case '15B'
   taps=2;
   tap1=11;
   tap2=15;
   n = 15;
case '16'
   taps=4;
   tap1=2;
   tap2=3;
   tap3=5;
   tap4=16;
   n = 16;
case '17A'
   taps=2;
   tap1=3;
   tap2=17;
   n = 17;
case '17B'
   taps=4;
   tap1=9;
   tap2=13;
   tap3=14;
   tap4=17;
   n = 17;
case '18'
   taps=2;
   tap1=7;
   tap2=18;
   n = 18;
case '19'
   taps=4;
   tap1=1;
   tap2=6;
   tap3=5;
   tap4=19;
   n = 19;
case '20'
   taps=2;
   tap1=3;
   tap2=20;
   n = 20;
case '21'
   taps=2;
   tap1=2;
   tap2=21;
   n = 21;
case '22'
   taps=2;
   tap1=1;
   tap2=22;
   n = 22;
case '23'
   taps=2;
   tap1=5;
   tap2=23;
   n = 23;
case '24'
   taps=4;
   tap1=1;
   tap2=3;
   tap3=4;
   tap4=24;
   n = 24;
end

	abuff = ones(1,n);

for i = (2^n)-1:-1:1
      
   xorbit = xor(abuff(tap1),abuff(tap2));		%feedback bit
   
   if taps==4
      xorbit2 = xor(abuff(tap3),abuff(tap4));%4 taps = 3 xor gates & 2 levels of logic
      xorbit = xor(xorbit,xorbit2);				%second logic level
   end
   
	abuff = [xorbit abuff(1:n-1)];
	y(i) = (-2 .* xorbit) + 1;  	%yields one's and negative one's (0 -> 1; 1 -> -1)
end

%%Amplico la amplitud elegida

mls = y;

sequence = int16(y);
for j=1:1:repetitions
   sequence = [sequence int16(y)];
end

sequence = [sequence zeros(1,2^n-1)];

sequence= 10^(amplitud/20)* 32768 * sequence;

