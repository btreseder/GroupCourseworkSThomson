close all 

clear 

h=0.5; 

g=9.81; 

R=287.04; 

T=270; 

zn=zeros(100,1); 

[zn,p] = findp(h,g,R,zn,T);

plot(p,zn)
