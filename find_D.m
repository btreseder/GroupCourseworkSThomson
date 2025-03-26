% Numerical Solution for Downward Flux
function D_n = find_D(B,tau,D_0)
    
    D_n = zeros(1,length(B));  % Zeros matrix for Downward Flux
    D_n(1) = D_0;              % Initial condition when tau = 0
    
    % Flipping initial and end values to change the values from the 
    % top of the atmosphere to the bottom
    tau = fliplr(tau);  
    B = fliplr(B);   
    
    for i = 1:length(B) -1  
        h = abs(tau(i)-tau(i+1)); % Absolute value of h, Tau isnt linear
        B1 = (h/2)*( B(i)*exp(tau(i)) + B(i+1)*exp(tau(i+1)));
        D_n(i+1) = (D_n(i)*(exp(tau(i))) + B1)*(exp(-(tau(i+1))));    
    end
    D_n = fliplr(D_n); % Flip the output
end