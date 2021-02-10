function [y,t] = conv_temp(x,nxi,h,nhi)

nyi=nxi+nhi;%valor inicial del vector tiempo

t=zeros(1,size(x,2)+size(h,2)-1);
for i=1:length(t)
    t(i)=nyi+i-1; %Valor final del vector tiempo
end
y=conv(x,h); %Convolución de matlab