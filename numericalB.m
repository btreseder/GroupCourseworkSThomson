
function B = numericalB(B_0,t)
    B = zeros(1,length(t));
    B(1) = B_0;
    n = 1;
    for n = 1:length(t)-1
        B(n+1) = B(n)+B(n)*exp(t(n)); %%
    end
end