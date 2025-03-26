
function p = q4_findp(p_0,g,R,T) 

%UNTITLED3 Summary of this function goes here 
p = zeros(1,length(T));
p(1) = p_0;
h=1;
% Detailed explanation goes here
for i = 1:length(T)-1
    %h = abs(zn(i+1) - zn(i)); %should be constant h = 1
    p(i+1) = exp( log(p(i)) - (g/R)*((h/2)*((1/T(i)))+(1/T(i+1))));
end 

end 