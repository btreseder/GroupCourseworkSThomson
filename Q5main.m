 clear; close all;

load("workspace_consts.mat")

tn = 604800*10; % 10 week in seconds
dt = 9600;      % Delta t in seconds

T = zeros(tn/dt,length(z)); % Zeros Array for Temperature
p = zeros(length(z));       % Zeros Array for Pressure

% Initial Conditions
U_0 = S_0;  D_0 = 0; % Upward and Downward Flux ICs
Cp = 7*R/2;          % Specific Heat Capacity
T(1,:) = 175;        % Initial Temperature

B1 = B(tau,S_0); % Plank Function Analytical solution


%figure; hold on;
for n= 1:(tn/dt)
    p(n,:) = q4_findp( p_z0 , g , R , T(n,:) );
    
    B1 = sigma.*T(n,:).^4;

    Unum = find_U(B1,tau,U_0);
    Dnum = find_D(B1,tau,D_0);

    dNdp = finddNdp( Unum, Dnum, p(n,:) );
    
    j = length(T(n,:))-1;

    T(n+1,1:j) = T(n,1:j) + dt *(g/Cp)* dNdp;
    

        %plot(Dnum,z)

end


t = 1:dt:tn+1;



%%
figure;
hold on
for i = 1:63:length(t)
    plot(T(i,1:20000),z(1:20000))
end
xlabel('Temperature (K)')
ylabel('Height (z)')
legend('Intial Condition','1 week','2 weeks', '3 weeks', '4 weeks','5 weeks','6 weeks','7 weeks','8 weeks', '9 weeks', '10 weeks')
%%