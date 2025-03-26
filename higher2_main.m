clear; close all;

load("workspace_consts.mat")

week_sec = 604800; % 1 week in seconds
tn = 1*week_sec;
dt = 9600;
t = 1:dt:tn+1;

B1 = B(tau,S_0); %Defines our B

Cp = 7*R/2; %Specific Heat Capacity

% Initial condition for find_U
S = @(theta, S_0, delta) S_0*(1+0.25*delta *(1-3*(sin(theta))^2));

% Initial condition for find_D
D_0 = 0;

kappa = 0.1;

% Defines the range of latitudes chosen
dtheta = pi/32; 
theta_min = dtheta - pi/2;
theta_max = pi/2 - dtheta;
theta = theta_min:dtheta:theta_max;

% Defines the Temperature Array to be filled
T = zeros(tn/dt,length(z), length(theta));
T(1,:) = 175; % This is making all times z=0 or z(1) value to be 175.



% Predefine pressure vector
p = zeros(length(z));

for n= 1:(tn/dt)
    for i = 1:length(theta)
        p(n,:) = q4_findp( p_z0 , g , R , T(n,:,i) );
        
        B1 = sigma.*T(n,:,i).^4;
        
        Unum = find_U(B1,tau,S(theta(i), S_0, delta));
        Dnum = find_D(B1,tau,D_0);
    
        dNdp = finddNdp( Unum, Dnum, p(n,:) );
        
        j = length(T(n,:,i));

        T(n+1,1:j,i) = T(n,1:j,i) + dt * dTdt(g, Cp, dNdp, kappa, R, ...
                                                squeeze(T(n,1:j,i)), ...
                                                p(n,:), theta(i), a, dtheta);
            
    end
end

%%
close all;  figure;
hold on

theta_deg = theta.* (180/pi);

contourf(   theta_deg(1:length(theta)), ...
            z(1:length(z)), ...
            squeeze(T(length(t),1:length(z), 1:length(theta))), ...
            "ShowText",true, ...
            "LabelFormat","%1.f K", ...
            "LabelSpacing",216, ...
            "LabelColor","white")

xlabel("Latitude (degrees)")
ylabel("Altitude (metres)")