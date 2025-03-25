clear; close all;

load("workspace_consts.mat")

week_sec = 604800; % 1 week in seconds
tn = 6*week_sec;    
dt = 9600;        % Time-step (240 minutes)


Cp = 7*R/2; %Specific Heat Capacity

% Initial condition for find_U
S = @(theta, S_0, delta) S_0*(1+0.25*delta *(1-3*(sin(theta))^2));


% Initial condition for find_D
D_0 = 0;

theta_min = - pi/2;
theta_max = pi/2;
dtheta = pi/32;
theta = theta_min:dtheta:theta_max;

T = zeros(tn/dt,length(z), length(theta));
T(1,:) = 175;
B1 = B(tau,S_0);

p = zeros(length(z));
%p(1,:) = p_z0;


for i = 1:length(theta)
    for n= 1:(tn/dt)
        p(n,:) = q4_findp( p_z0 , g , R , T(n,:,i) );
        
        B1 = sigma.*T(n,:,i).^4;
        
        Unum = find_U(B1,tau,S(theta(i), S_0, delta));
        Dnum = find_D(B1,tau,D_0);
    
        dNdp = finddNdp( Unum, Dnum, p(n,:) );
        
        j = length(T(n,:,i))-1;
    
        T(n+1,1:j,i) = T(n,1:j,i) + dt *(g/Cp)* dNdp;
            
    end
end
%%
t = 1:dt:tn+1;

%%
close all;  figure;
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
