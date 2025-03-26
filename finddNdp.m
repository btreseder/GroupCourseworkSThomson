function [dNdp, N] = finddNdp(Unum, Dnum, p)
%Defining N
N= Unum-Dnum;

%Finite difference
for i=1:length(N)-1
    dp = (p(i+1)-p(i));
    dN = (N(i+1)-N(i));
    dNdp(i) = dN/dp;
end
