function dTdt = dTdt(g,C_p,dNdp,kappa,R,T,p,theta_n,a,dtheta)
    dTdt = zeros(1,length(T));
    for i = 2:length(T)-1

        %finite difference wrt theta
        dTdtheta = (T(i)-T(i+1))/dtheta;
        %second order finite difference wrt theta
        dT2dtheta2 = (T(i+1) - 2*T(i) + T(i-1))/(dtheta^2);

        d_cosd = cos(theta_n)*dT2dtheta2 - sin(theta_n)*dTdtheta;
        
        dTdt(i) = (g/C_p)*dNdp(i) + (kappa)/(p(i)*a^2*cos(theta_n))*d_cosd;

    end
end