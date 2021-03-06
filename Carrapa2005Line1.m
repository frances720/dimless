% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 12e3;
T2 = 15e3;
D1star = (T1/T2)^3;

E = 70e9;
v = 0.25;
D = calcD(T2,E,v);

rho_c = 2700;
rho_m = 3300;
rho_s = 2400;

alpha = calcAlpha(D,rho_m,rho_s);
Lcstar = 130e3/alpha;
Ltstar = 80e3/alpha;

Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

Wt = 50e3;
Wtstar = Wt / alpha;

H = zeros(size(xstar))';
% H(xstar < Wtstar) = 1e3;
% H(xstar < 170e3/alpha) = 1.5e3;
% H(xstar < 100e3/alpha) = 3e3;
H(xstar < Wtstar) = 1.75e3;
% height = 5e3;
% H(xstar < Wtstar) = height*(Wtstar - xstar(xstar < Wtstar))/Wtstar;
F = sum(H) * dxstar;

Hstar = H ./ F;

wstar = solveW(dxstar,Dstar,Hstar);

w0 = calcw0(rho_c,rho_m,rho_s,F);

x = xstar .* alpha ./1000;
w = wstar .* w0 ./ 1000;

figure;
plot(x-Wt/1e3,-w);
hold on;
plot(x-Wt/1e3,zeros(size(x))');
axis([0,150,-3.5,1.5]);
xlabel('distance from rangefront (km)');
