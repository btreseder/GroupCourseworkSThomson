function U = find_U(B,tau,U_0)
    %preallocate U and load initial value.
    U = zeros(1,length(B));
    U(1) = U_0;
    %input is the wrong way around
    B=fliplr(B);
    tau=fliplr(tau);
    
    for i = 1:length(B)-1
        h = abs(tau(i)-tau(i+1)); %h changes 
        %maths
        U(i+1) = exp(tau(i+1))*( exp(-tau(i))*U(i) + (h/2)*( -exp(-tau(i))*B(i) - exp(-tau(i+1))*B(i+1) ) );
    end
    U = fliplr(U); %undo the flip
end