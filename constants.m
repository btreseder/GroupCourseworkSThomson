clear
close all


z = 0:1:20000;
g = 9.81;
tau_0 = 2.2;
H_a = 2000;
tau = tau_0*exp(-z./H_a);
S_0 = 238;
sigma = 5.67*10^(-8);
R=287.04;   %Specific Gas Constant [Jkg-1K-1]
