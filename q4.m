close all; clear;

load("workspace_consts.mat")

% Test with T defined with B
B = B(tau,S_0); T = (B./sigma).^(1/4);  fliplr(T);

% Test with T the same for all heights (initial case)
%T = zeros(size(z));     T(:) = 270;

% Other Constants Defined
h=0.1;      %step
Cp = 7*R/2; %Specific Heat Capacity

% Find P Function
p = q4_findp(p_z0,g,R,T);
fliplr(p);

% Plotting Figure
figure
plot(p,z)
