function D_n = find_D(B,tau,D_0)
    %h needs to change each time
    %keep track of flipping
    %make sure maths is good
    
    D_n = zeros(1,length(B));
    D_n(1) = D_0; %initial condition when tau = 0
    
    %initial value is at top of atmosphere
    %flip input to correct for this
    tau = fliplr(tau); 
    B = fliplr(B);
    
    for i = 1:length(B)-1
        h =abs(tau(i)-tau(i+1)); %tau does not change linearly like z
        D_n(i+1) = (D_n(i)*(exp(tau(i))) + (h/2)*( B(i)*exp(tau(i)) + B(i+1)*exp(tau(i+1)) ))*(exp(-(tau(i+1))));    
    end
    D_n = fliplr(D_n); %reverse the output to account for the rest of it
end