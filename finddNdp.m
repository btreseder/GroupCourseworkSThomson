function [dNdp, N] = finddNdp(Unum, Dnum, p)
N= Unum-Dnum;
for n=1:length(N)-1
    dp = abs(p(n)-p(n+1));
    dN = abs(N(n+1)-N(n));
    dNdp(n) = dN/dp
end
