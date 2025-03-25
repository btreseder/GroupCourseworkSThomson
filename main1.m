close all; clear; clc;

load('workspace_consts.mat')

%Analytical Solutions
B = B(tau,S_0);          % Analytical Solution for Plank Functions
D = D(tau,S_0);          % Analytical Solution for Downward Flux
U = U(tau,S_0);          % Analytical Solution for Upward Flux
T = (B./sigma).^(1/4);   % Analytical Solution for Temperature

% Plotting Flux`s and Plank Function
figure;
hold on
plot(B,z)
plot(D,z)
plot(U,z)
legend('B','D','U')
ylabel('Z (m)')
xlabel('(Wm^-2)')

% Plotting Temperature
figure;
plot(T,z)
xlabel('Temparature (K°)')
ylabel('Z (m)')

% Plotting numerical
Unum = find_U(B,tau,S_0);
Dnum = find_D(B,tau,0);
figure;
hold on
plot(Dnum,z)
plot(Unum,z)
legend('D','U')

% Plotting Flux Error
Uerr = abs(U - Unum);
Derr = abs(D - Dnum);
figure;
hold on
plot(Uerr,z)
plot(Derr,z)
legend('Error in U','Error in D')
xlabel('Error')
ylabel('Height z (m)')