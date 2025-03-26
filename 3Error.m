clear; clc; close all;

load("workspace_consts.mat")

% Initial Conditions
H_a = 2000;                 % Height Scale
tau_0 = 2.2;                % Optical Depth IC
z = 0:1:20000;              % Distance in m
tau = tau_0*exp(-z./H_a);   % Optical depth for every value of z
S_0 = 238;                  % Solar Constant
sigma = 5.67*10^(-8);       % Stefan-Boltzmann constant

% Analytical Solutions
B = B(tau,S_0);         % Plank Function
D = D(tau,S_0);         % Downward Flux
U = U(tau,S_0);         % Upward Flux
T = (B./sigma).^(1/4);  % Temperature

% Plotting analytical
figure;
hold on
plot(B,z)
plot(D,z)
plot(U,z)
legend('B','D','U')
ylabel('Height (m)')
xlabel('Stefan-Boltzmann constant (Wm^-2)')
title('Analytical solution at equilibrium')

% Plotting Temperature 
figure;
plot(T,z)
title('Temperature profile')
xlabel('Temparature (K)')
ylabel('Height (m)')

% Plotting Numerical
Unum = find_U(B,tau,S_0);
Dnum = find_D(B,tau,0);
figure;
hold on
plot(Dnum,z)
plot(Unum,z)
legend('D','U')
title('numerical solutions')
xlabel('Temperature (K°)')
ylabel('Height (m)')


% Plotting Error
figure;
hold on
plot(z,Uerr)
plot(Uerr,z)
plot(Derr,z)
legend('Error in U','Error in D')
title('Error in Numerical Solutions')
xlabel('Error')
ylabel('Height (m)')
