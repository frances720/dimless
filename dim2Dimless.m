function [D1star, Wtstar, Lcstar, Ltstar] = dim2Dimless(T1,T2,Lc,Lt,Wt)
E = 70*1e9;
v = 0.25;
g = 9.8;
rho_m = 3300;
rho_s = 2400;
D2 = E.*T2.^3./(12.*(1-v.^2));
a = (4.*D2./((rho_m-rho_s).*g)).^(1/4);

Lcstar = Lc./a;
Ltstar = Lt./a;
Wtstar = Wt./a;
D1star = (T1./T2).^3;