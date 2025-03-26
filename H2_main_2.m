clear;
close all;

%Q6main %use either this or the workspace
load("10week_q6.mat")

T_new = T(length(t),1:length(z)-1, 1:length(theta));

%%
% Defines the range of latitudes chosen
dtheta = pi/32; 
theta_min = dtheta - pi/2;
theta_max = pi/2 - dtheta;
theta = theta_min:dtheta:theta_max;
theta_deg = theta.* (180/pi);

week_sec = 604800; % 1 week in seconds
tn = 10*week_sec;
dt = 9600;
t = 1:dt:tn+1;

B1 = B(tau,S_0); %Defines our B

Cp = 7*R/2; %Specific Heat Capacity

% Initial condition for find_U
S = @(theta, S_0, delta) S_0*(1+0.25*delta *(1-3*(sin(theta))^2));

% Initial condition for find_D
D_0 = 0;


%Predefine pressure vector
p_new = zeros(length(z)-1);


kappa = 1e6;
for n= 1:(tn/dt)
    for i = 1:length(theta)
        p_new(n,:) = q4_findp( p_z0 , g , R , T_new(n,:,i) );
        
        B1 = sigma.*T_new(n,:,i).^4;
        
        Unum = find_U(B1,tau,S(theta(i), S_0, delta));
        Dnum = find_D(B1,tau,D_0);
    
        dNdp = finddNdp( Unum, Dnum, p_new(n,:) );
        
        j = length(T_new(n,:,i));

        T_new(n+1,1:j,i) = T_new(n,1:j,i) + dt .* dTdt(g, Cp, dNdp, kappa, R, ...
                                                squeeze(T_new(n,1:j,i)), ...
                                                p_new(n,1:j), theta(i), a, dtheta);
            
    end
end

%%
for timestep = [64 631]
    figure;     
    hold on;

    contourf(   theta_deg(1:length(theta)), ...
                z(2:length(z)-2), ...
                squeeze(T_new(timestep,2:length(z)-2, 1:length(theta))), ...
                "ShowText",true, ...
                "LabelFormat","%1.f K", ...
                "LabelSpacing",216, ...
                "LabelColor","white")

    xlabel("Latitude (degrees)")
    ylabel("Altitude (metres)")

    hold off;
end



