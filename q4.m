close all;  clear;

load("workspace_consts.mat")
B = B(tau,S_0);
T = (B./sigma).^(1/4);
fliplr(T);


h=0.1;      %step
g=9.81;     %Gravity
R=287.04;   %Specific Gas Constant [Jkg-1K-1]
%T=270;      %Temperature [K] 
Cp = 7*R/2; %Specific Heat Capacity
p_0 = 1e5;
%zn=zeros(100,1); 

p = q4_findp(p_0,g,R,T);
fliplr(p);
figure
plot(p,z)
