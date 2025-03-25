% Numerical Solution for Upward Flux 
function U = find_U(B,tau,U_0)

    U = zeros(1,length(B)); % Zeros Array for Upward Flux
    U(1) = U_0;             % Initial Value for Upward Flux

    % Flipping initial and end values to change the values from the 
    % top of the atmosphere to the bottom
    B=fliplr(B);
    tau=fliplr(tau);
    
    for i = 1:length(B)-1
        h = abs(tau(i)-tau(i+1)); % % Tau does not change linearly like z
        B1 =  (h/2)*(-exp(-tau(i))*B(i) - exp(-tau(i+1))*B(i+1));
        U(i+1) = exp(tau(i+1))*(exp(-tau(i))*U(i) + B1);
    end
    U = fliplr(U); %undo the flip
end