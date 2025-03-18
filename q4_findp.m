function [zn, p] = findp(h,g,R,zn,T) 

%UNTITLED3 Summary of this function goes here 

% Detailed explanation goes here 
n = 1;
while zn(n) <= 200
    p(n) = exp( log(1e5) - g/R*(zn(n)));
    zn(n+1) = zn(n) + h*(.5*(1/T+1/T));
    n = n+1;
end 
p(n) = exp( log(1e5) - g/R*(zn(n)));

end 