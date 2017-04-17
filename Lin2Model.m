% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

D1star = 0.18;
T2 = 16e3; 

E = 100e9;
v = 0.25;
D = calcD(T2,E,v);

rho_c = 2700;
rho_m = 3200;
rho_s = 2500;

alpha = calcAlpha(D,rho_m,rho_s);
Lcstar = 225e3/alpha;
Ltstar = 100e3/alpha;
Wt = 140e3;
Wtstar = Wt/alpha;

H = zeros(size(xstar))';
H(xstar < Wtstar) = 1.7e3;
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
plot(300-Lin2(:,1),Lin2(:,2),'o');