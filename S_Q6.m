clear; clc;

s0 = 238; %ICs

pheta0 = -pi/2;%Start angle
pheta_end = pi/2; %End angle
dpheta = pi/8;% Delta pheta

%Forward Euler
h = pheta0:dpheta:pheta_end; 
s = zeros(1, length(h));
s(1) = s0;
for n = 1:length(h)
    s(n+1) = s(n) + s0*(1 + 0.25*1.4*(1-3*(sin(n))^2));
    
end

