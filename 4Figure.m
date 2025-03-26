close all; clear; clc;

load("workspace_consts.mat")

B = B(tau,S_0);           % Test with T defined with Plank function
T = (B./sigma).^(1/4); 
p = find_p(p_z0,g,R,T); % Pressure Function

fliplr(p);  % Flips pressure Array
fliplr(T);  % Flips Temperature Array

% Plotting
figure
plot(p,z)
%title('Pressure Profile')
xlabel('Pressure (Pa)')
ylabel('Distance (m)')
