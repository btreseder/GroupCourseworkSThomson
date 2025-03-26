clear; clc; close all;

load("workspace_consts.mat")


tn = 604800*10; % 10 week in seconds
dt = 9600; %Timestep

U_0 = S_0;  D_0 = 0;
Cp = 7*R/2; %Specific Heat Capacity

tau2 = ((tau_0 + 0.2023 * log(720/360)) * exp(-z./H_a)); %Tau with CO2 doubled

T1 = zeros(tn/dt,length(z));
T1(1,:) = 175;
B1 = B(tau,S_0);
B2 = B(tau2,S_0);

p1 = zeros(length(z));
p2 = zeros(length(z));


for n= 1:(tn/dt)
    p1(n,:) = find_p( p_z0 , g , R , T1(n,:) );
    
    B1 = sigma.*T1(n,:).^4;

    Unum1 = find_U(B1,tau,U_0);
    Dnum1 = find_D(B1,tau,D_0);

    dNdp1 = finddNdp( Unum1, Dnum1, p1(n,:) );
    
    j = length(T1(n,:))-1;

    T1(n+1,1:j) = T1(n,1:j) + dt *(g/Cp)* dNdp1;
   
end

B = B(tau,S_0);
T2 =  (B./sigma).^(1/4);    %Starting Value as the analytical sol for original tau
p_z01 = p_z0;

for m = 1:(tn/dt)
    p2(m,:) = find_p( p_z01 , g , R , T2(m,:) );
    
    B2 = sigma.*T2(m,:).^4;

    Unum2 = find_U(B2,tau2,U_0);
    Dnum2 = find_D(B2,tau2,D_0);

    dNdp2 = finddNdp( Unum2, Dnum2, p2(m,:));

    k = length(T2(m,:))-1;

    T2(m+1,1:k) = T2(m,1:k) + dt *(g/Cp)* dNdp2;
end

t = 1:dt:tn+1;

%Plot for C02 = 360ppmv
i = 1:50:length(t);
    plot(T1(i,1:20000),z(1:20000), T1(length(t),1:1000:20000),z(1:1000:20000), '--')
    title("C02=360ppmv")
    xlabel('Temperature (K)')
    ylabel('Height (m)')

%PLot for C02 = 720ppmv
figure;
y = 1:length(t);
    plot(T2(y,1:20000),z(1:20000), T2(length(t),1:1000:20000),z(1:1000:20000), '--')
    title("C02=720ppmv")
    xlabel('Temperature (K)')
    ylabel('Height (m)')
    

%Both 360ppmv and 720ppmv plotted as both graphs converge to a single line
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