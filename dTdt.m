function dTdt = dTdt(g,C_p,dNdp,kappa,R,T,p,theta_n,a,dtheta)
    dTdt = zeros(1,length(T));
    for i = 1:length(T)-1
        
        dTdtheta = (T(i)-T(i+1))/dtheta;

        dTdtheta2 = (cos(theta_n)*dTdtheta)/dtheta;

        % PRE-UPDATE
        %dTdt(i) = (g/C_p)*dNdp(i) + (kappa*R*T(i))/(p(i)*C_p*a^2*cos(theta_n))*dTdtheta2;

        dTdt(i) = (g/C_p)*dNdp(i) + (kappa)/(p(i)*a^2*cos(theta_n))*dTdtheta2;

    end
end