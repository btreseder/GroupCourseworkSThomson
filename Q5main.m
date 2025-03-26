clear; close all; clc;

load("workspace_consts.mat")

tn = 6000000; % 10 weeks in seconds
dt = 10000;   % Delta t in seconds

T = zeros(tn/dt,length(z)); % Zeros Array for Temperature
p = zeros(length(z));       % Zeros Array for Pressure

% Initial Conditions
U_0 = S_0;  D_0 = 0; % Upward and Downward Flux ICs
Cp = 7*R/2;          % Specific Heat Capacity
T(1,:) = 175;        % Initial Temperature

B = B(tau,S_0); % Plank Function Analytical solution

for n = 1:(tn/dt)                          % Horizontal Position in Array
    j = length(T(n,:)) -1;                 % Vertical Position in T array
    p(n,:) = q4_findp(p_z0, g, R, T(n,:)); % Pressure Array position
    
    B = sigma .*T(n,:).^4;    % Plank Function Numerical solution
    Unum = find_U1(B,tau,U_0); % Upward Flux Numerical solution
    Dnum = find_D(B,tau,D_0); % Downward Flux Numerical solution
    
    % Net Flux differential
    dNdp = finddNdp(Unum, Dnum, p(n,:));

    T(n +1,1:j) = T(n,1:j) + dt *(g/Cp) *dNdp; % Forward Euler
end

% Delta t for plotting
t = 1:dt:tn +1;

% Plotting
figure;
hold on
i = 1:50:length(t);
plot(T(i,1:20000), z(1:20000))
title('CO2 360ppmv')
xlabel('Temperature (K°)')
ylabel('Height (m)')
