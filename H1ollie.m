 clear; clc; close all;

load("workspace_consts.mat")

tn = 60000000; % 10 week in seconds
dt = 100000;

U_0 = S_0;  D_0 = 0;
Cp = 7*R/2; %Specific Heat Capacity

tau2 = ((tau_0 + 0.2023 * log(720/360)) * exp(-z./H_a)); %Tau with CO2 doubled

T = zeros(tn/dt,length(z));
T(1,:) = 175;
B1 = B(tau,S_0);
B2 = B(tau2,S_0);

p = zeros(length(z));
p1 = zeros(length(z));
%p(1,:) = p_z0;


for n= 1:(tn/dt)
    p(n,:) = q4_findp( p_z0 , g , R , T(n,:) );
    
    B1 = sigma.*T(n,:).^4;

    Unum = find_U(B1,tau,U_0);
    Dnum = find_D(B1,tau,D_0);

    dNdp = finddNdp( Unum, Dnum, p(n,:) );
    
    j = length(T(n,:))-1;

    T(n+1,1:j) = T(n,1:j) + dt *(g/Cp)* dNdp;
   
end

T1 = zeros(tn/dt,length(z));
T1(1,:) = T(tn/dt,length(z)-1); %Starting Value as the End starting value of T
p_z01 = p_z0;

for m= 1:(tn/dt)
    p1(m,:) = q4_findp( p_z01 , g , R , T1(m,:) );
    
    B2 = sigma.*T1(m,:).^4;

    Unum1 = find_U(B2,tau2,U_0);
    Dnum1 = find_D(B2,tau2,D_0);

    dNdp1 = finddNdp( Unum1, Dnum1, p1(m,:));
    
    k = length(T1(m,:))-1;

    T1(m+1,1:k) = T1(m,1:k) + dt *(g/Cp)* dNdp1;
end

t = 1:dt:tn+1;
%Plot for T
i = 1:50:length(t);
    plot(T(i,1:20000),z(1:20000), T(length(t),1:1000:20000),z(1:1000:20000), '--')
    title("C02=360ppmv")
    xlabel('Temperarture')
    ylabel('Height')

    %PLot for T1
figure;
y = 1:50:length(t);
    plot(T1(y,1:20000),z(1:20000), T1(length(t),1:1000:20000),z(1:1000:20000), '--')
    title("C02=720ppmv")
    xlabel('Temperarture')
    ylabel('Height')

%Both final t values plotted as both graphs converge to a single ?line?
figure; hold on
plot(T(length(t),1:20000),z(1:20000))
plot(T1(length(t),1:20000),z(1:20000))
title("Analytical")
legend 'C02=360ppmv' 'C02=720ppmv'
xlabel('Temperarture')
ylabel('Height')
