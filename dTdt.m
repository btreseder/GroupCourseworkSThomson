function dTdt = dTdt(g,C_p,dNdp,kappa,R,T,p,theta_n,a,dtheta)
    dTdt = zeros(1,length(T));
    for i = 2:length(T)-1
        
        %dTdtheta2 = (cos(theta_n)*dTdtheta)/dtheta;
        %dTdtheta2 = (-sin(theta_n)*dTdtheta);

        dTdtheta = (T(i)-T(i+1))/dtheta;
        dT2dtheta2 = (T(i+1) - 2*T(i) + T(i-1))/(dtheta^2);

        d_cosd = cos(theta_n)*dT2dtheta2 - sin(theta_n)*dTdtheta;

        % PRE-UPDATE
        %dTdt(i) = (g/C_p)*dNdp(i) + (kappa*R*T(i))/(p(i)*C_p*a^2*cos(theta_n))*dTdtheta2;

        dTdt(i) = (g/C_p)*dNdp(i) + (kappa)/(p(i)*a^2*cos(theta_n))*d_cosd;

    end
end