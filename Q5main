h=0.1;
g=9.81;
R=287.04;
zn=zeros(100,1);

T = zeros(1,length(zn));
for i = 1:length(zn)
    T(i) = 175;
end
for n= 1:length(Unum)-1
    p = findp(h,g,R,zn,T)
    finddNdp(Unum, Dnum, p)
end
