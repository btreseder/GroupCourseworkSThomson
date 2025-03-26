clear;
close all;

% Change start point to be the radius of equilibrium (Q6)
load("10week_higher2.mat")

for timestep = [2, 64, 631]
    figure;     
    hold on;

    contour(   theta_deg(1:length(theta)), ...
                z(1:length(z)), ...
                squeeze(T(timestep,1:length(z), 1:length(theta))), ...
                "ShowText",true, ...
                "LabelFormat","%1.f K", ...
                "LabelSpacing",216, ...
                "LabelColor","black")

    xlabel("Latitude (degrees)")
    ylabel("Altitude (metres)")

    hold off;
end



%%
clear;
load("10week_higher2_q6.mat")

for timestep = [2, 64, 631]
    figure;     
    hold on;

    contour(   theta_deg(1:length(theta)), ...
                z(1:length(z)-1), ...
                squeeze(T_new(timestep,1:length(z)-1, 1:length(theta))), ...
                "ShowText",true, ...
                "LabelFormat","%1.f K", ...
                "LabelSpacing",216, ...
                "LabelColor","black")

    xlabel("Latitude (degrees)")
    ylabel("Altitude (metres)")

    hold off;
end


%%
clear; figure; hold on;

load("10week_q6.mat")

contourf(   theta_deg(1:length(theta)), ...
            z(1:length(z)-2), ...
            squeeze(T(631,1:length(z)-2, 1:length(theta))), ...
            "ShowText",true, ...
            "LabelFormat","%1.f K", ...
            "LabelSpacing",216, ...
            "LabelColor","white")

xlabel("Latitude (degrees)")
ylabel("Altitude (metres)")

hold off;


