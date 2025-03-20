clear
close all

% This generates "workspace_consts.mat" file, the constants that can be
% used anywhere.

z = 0:1:20000;  % Range of z values evaluated (0km to 20km in metres)
g = 9.81;       % Acceleration due to gravity
tau_0 = 2.2;    
H_a = 2000;
tau = tau_0*exp(-z./H_a);
S_0 = 238;
sigma = 5.67*10^(-8);
R=287.04;       %Specific Gas Constant [Jkg-1K-1]
p_z0 = 10^5;    %Pressure at z = 0 is 1x10^5 [Pa]
delta = 1.4;    %Delta for Q6
