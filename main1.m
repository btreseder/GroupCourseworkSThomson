%initial values
clear
H_a = 2000;
tau_0 = 2.2;
z = 0:1:20000;
tau = tau_0*exp(-z./H_a);
S_0 = 238;
sigma = 5.67*10^(-8);

%Analytical Solutions
B = B(tau,S_0);
D = D(tau,S_0);
U = U(tau,S_0);
T = (B./sigma).^(1/4);

%plot :)
figure;
hold on
plot(B,z)
plot(D,z)
plot(U,z)
legend('B','D','U')
ylabel('Z (m)')
xlabel('(Wm^-2)')
title('Analytial solution at equilibrium')
figure;
plot(T,z)
title('Temperature profile')
xlabel('Temparature (K)')
ylabel('Z (m)')

%plot numerical
Unum = find_U(B,tau,S_0);
Dnum = find_D(B,tau,0);
figure;
hold on
plot(Dnum,z)
plot(Unum,z)
legend('D','U')
title('numerical solutions')

figure;
hold on
plot(z,Uerr)
plot(Uerr,z)
plot(Derr,z)
legend('Error in U','Error in D')
title('Error in Numerical Solutions')
xlabel('Error')
ylabel('Height z (m)')