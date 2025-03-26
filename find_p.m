% Numerical Solution for pressure
function p = find_p(p_0,g,R,T) 
   
   % Zeros Array and Initial Value for Pressure
   p = zeros(1,length(T));
   p(1) = p_0;             
   h=1;
   % Recursion for p
   for i = 1:length(T)-1
       p(i+1) = exp( log(p(i)) - (g/R)*( (h/2)*((1/T(i)))+(1/T(i+1))) );

   end 

end 
