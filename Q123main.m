clc; close all; clc;

load("workspace_consts.mat")
% Question 1
% Analytical Solutions
B = B(tau,S_0);        % Plank Function
D = D(tau,S_0);        % Downward Flux    
U = U(tau,S_0);        % Upward Flux
% Question 2
T = (B./sigma).^(1/4); % Temperature 

% Plotting Analytical
figure;
colororder('sail')
hold on
plot(B,z)
plot(D,z)
plot(U,z)
legend('B','D','U')
ylabel('Z (m)')
xlabel('(Wm^-2)')

% Plotting Temperature
figure;
colororder('sail')
plot(T,z)
title('Temperature profile')
xlabel('Temparature (K)')
ylabel('Z (m)')

% Question 3
% Plotting Numerical
Unum = find_U(B,tau,S_0);
Dnum = find_D(B,tau,0);
figure;
colororder('sail')
hold on
plot(Dnum,z)
plot(Unum,z)
legend('D','U')
title('numerical solutions')

% Plotting Error 
Uerr = abs(U - Unum);
Derr = abs(D - Dnum);

figure;
colororder('sail')
hold on
plot(Uerr,z)
plot(Derr,z)
legend('Error in U','Error in D')
title('Error in Numerical Solutions')
xlabel('Error')
ylabel('Height z (m)')
