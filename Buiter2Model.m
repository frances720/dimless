% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

D1star = 0.005;
T2 = 30e3;

E = 100e9;
v = 0.25;
D = calcD(T2,E,v);

rho_c = 2800;
rho_m = 3250;
rho_s = 2300;

alpha = calcAlpha(D,rho_m,rho_s);
Lcstar = 500e3/alpha;
Ltstar = 150e3/alpha;
Wt = 175e3;
Wtstar = Wt/alpha;

H = zeros(size(xstar))';
H(xstar < Wtstar) = 15e3;
F = sum(H) * dxstar;
Hstar = H ./ F;

x = xstar .* alpha ./1000;
w0 = calcw0(rho_c,rho_m,rho_s,F);

Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
wstar = solveW(dxstar,Dstar,Hstar);
w = -wstar .* w0 ./ 1000;

figure;
plot(x,w);
hold on;
plot(Buiter2(:,1),Buiter2(:,2),'o');