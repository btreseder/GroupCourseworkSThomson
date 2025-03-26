clear; close all;

load("workspace_consts.mat")

week_sec = 604800; % 1 week in seconds
tn = 6*week_sec;   % 6 weeks in seconds  
dt = 9600;         % Time-step (240 minutes)

% ICs for theta
theta_min = - pi/2;                 % Starting theta
theta_max = pi/2;                   % End theta
dtheta = pi/32;                     % delta theta
theta = theta_min:dtheta:theta_max; % delta theta array

T = zeros(tn/dt,length(z), length(theta)); % Zeros Array for Temperature
p = zeros(length(z));                      % Zeros Array for Pressure

% Planks Function Analytical Solution
B1 = B(tau,S_0);

%ICs and Constants
T(1,:) = 175; % Initial Temperature
Cp = 7*R/2;   % Specific Heat Capacity
D_0 = 0;      % Initial Downward Flux value

% Initial condition for find_U
S = @(theta, S_0, delta) S_0*(1+0.25*delta *(1-3*(sin(theta))^2));

for i = 1:length(theta)
    for n= 1:(tn/dt)            % Horizontal Position in Array
        j = length(T(n,:,i))-1; % Vertical Position in Array
        
         % Pressure Array position
        p(n,:) = find_p( p_z0 , g , R , T(n,:,i) );
        
        B1 = sigma.*T(n,:,i).^4;
        % Upward Flux Numerical solution
        Unum = find_U(B1,tau,S(theta(i), S_0, delta));

        %Downward Flux Numerical solution
        Dnum = find_D(B1,tau,D_0);

        % Net Flux Numerical solutions
        dNdp = finddNdp( Unum, Dnum, p(n,:) );
    
        T(n+1,1:j,i) = T(n,1:j,i) + dt *(g/Cp)* dNdp;
            
    end
end

close all;  figure;

% Delta t to use when plotting
t = 1:dt:tn+1;

% Plotting with a contour
figure;
hold on

theta_deg = theta.* (180/pi);

contourf(theta_deg, ...
            z(1:20000), ...
            squeeze(T(length(t),1:20000, 1:length(theta))), ...
            "ShowText",true, ...
            "LabelFormat","%1.f K", ...
            "LabelSpacing",216, ...
            "LabelColor","white")

xlabel("Latitude (degrees)")
ylabel("Altitude (metres)")
