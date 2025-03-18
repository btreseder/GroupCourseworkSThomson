z = 0:1:200000;
g = 9.81;
tau_0 = 2.2;
tau = tau_0*exp(-z./H_a);
H_a = 2000;
S_0 = 238;
sigma = 5.67*10^(-8);
R=287.04;   %Specific Gas Constant [Jkg-1K-1]
