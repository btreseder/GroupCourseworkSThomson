clear; close all;

load("workspace_consts.mat")

tn = 600000; % 1 week in seconds
dt = 10000;


Cp = 7*R/2; %Specific Heat Capacity

% Initial condition for find_U
S = @(theta, S_0, delta) S_0*(1+0.25*delta *(1-3*(sin(theta))^2));


% Initial condition for find_D
D_0 = 0;

theta_min = - pi/2;
theta_max = pi/2;
theta = theta_min:pi/32:theta_max;

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
        
        %plot(Dnum,z)
    
    end
end


t = 1:dt:tn+1;



%%
figure;
hold on
for i = length(t)
    for j = 1:length(theta)
        plot(T(i,1:20000,j),z(1:20000))
    end
end

