clear; clc; close all;

load("workspace_consts.mat")


tn = 604800*10; % 10 week in seconds
dt = 9600;      % Delta t in seconds

U_0 = S_0;  D_0 = 0; % Initial Values for Upward and Downward Flux
Cp = 7*R/2; % Specific Heat Capacity

%Tau with CO2 doubled
tau2 = ((tau_0 + 0.2023 * log(720/360)) * exp(-z./H_a));

% Plank function defined for tau at both 360ppmv and 720ppmv
B1 = B(tau,S_0);
B2 = B(tau2,S_0);

% Zeros Array and Initial value for Temperature at 360ppmv
T1 = zeros(tn/dt,length(z));
T1(1,:) = 175;

% Zeros Array and Initial value for Temperature at 360ppmv
T2 = zeros(tn/dt,length(z));
T2 = (B1./sigma).^(1/4); 

% Zeros array for pressure for both 360ppmv and 720ppmv 
p1 = zeros(length(z));
p2 = zeros(length(z));

% Forward Euler for 360ppmv
for n= 1:(tn/dt)           % Horizontal Position in Array
    j = length(T1(n,:))-1; % Vertical Position in Array
   
    % Pressure Array position
    p1(n,:) = find_p( p_z0 , g , R , T1(n,:) );
    
    % Plank Function Numerical solution
    B1 = sigma.*T1(n,:).^4;

    Unum1 = find_U(B1,tau,U_0); % Upward Flux Numerical Solution
    Dnum1 = find_D(B1,tau,D_0); % Downward Flux Numerical Solution

    % Net Flux differential
    dNdp1 = finddNdp( Unum1, Dnum1, p1(n,:) );

    T1(n+1,1:j) = T1(n,1:j) + dt *(g/Cp)* dNdp1;  
end

% Forward Euler for 720ppmv
for m = 1:(tn/dt)          % Horizontal Position in Array
    k = length(T2(m,:))-1; % Vertical Position in Array
    
    % Pressure Array position
    p2(m,:) = find_p(p_z0 , g , R , T2(m,:));
    
    % Plank Function Numerical solution
    B2 = sigma.*T2(m,:).^4;

    Unum2 = find_U(B2,tau2,U_0); % Upward Flux Numerical solution
    Dnum2 = find_D(B2,tau2,D_0); % Downward Flux Numerical solution
    
    % Net Flux differential
    dNdp2 = finddNdp( Unum2, Dnum2, p2(m,:));

    T2(m+1,1:k) = T2(m,1:k) + dt *(g/Cp)* dNdp2;
end

t = 1:dt:tn+1;

% Plot for C02 = 360ppmv
i = 1:50:length(t);
    plot(T1(i,1:20000),z(1:20000), ...
         T1(length(t),1:1000:20000),z(1:1000:20000), '--')
    xlabel('Temperature (K)')
    ylabel('Height (m)')

% Plot for C02 = 720ppmv
figure;
y = 1:50:length(t);
    plot(T2(y,1:20000),z(1:20000), ...
         T2(length(t),1:1000:20000),z(1:1000:20000), '--')
    xlabel('Temperature (K)')
    ylabel('Height (m)')
    
% Both 360ppmv and 720ppmv plotted as both graphs converge to a single line
figure; hold on
plot(T1(length(t),1:20000),z(1:20000))
plot(T2(length(t),1:20000),z(1:20000))
legend 'C02=360ppmv' 'C02=720ppmv'
xlabel('Temperature (K)')
ylabel('Height (m)')

figure; hold on
axis([0 6e6 286 292])
plot(t,T2(:,1) )
xlabel('Time (s)')
ylabel('Temperature (K)')
