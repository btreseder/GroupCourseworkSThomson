function [p] = findp(h,g,R,zn,T) 

%UNTITLED3 Summary of this function goes here 

% Detailed explanation goes here 

for n= 2:100 
    p(n)=exp(log(1e5)-g/R*(zn(n)));

    zn(n) = zn(n-1) + h*((.5*(1/T(n-1))+(1/T(n))));
end 
end 
