close all;  clear;

h=0.1;      %step
g=9.81;     %Gravity
R=287.04;   %Specific Gas Constant [Jkg-1K-1]
T=270;      %Temperature [K] 
Cp = 7*R/2; %Specific Heat Capacity

zn=zeros(100,1); 

[zn,p] = findp(h,g,R,zn,T);

figure
plot(p,zn)
