% Numerical Solution for the Plank Function
function B = numericalB(B_0,t)
    B = zeros(1,length(t)); % Zeros Array for the Plank Function
    B(1) = B_0;             % Initial Value for the Plank Function
    for n = 1:length(t) -1  % Array Position
        
        B(n+1) = B(n)+B(n)*exp(t(n)); 
    end
end