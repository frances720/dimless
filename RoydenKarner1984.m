% dimensionless space
xstar = 0:0.01:20;
dxstar = xstar(2)-xstar(1);

% assume uniform rigidity

Dstar = ones(size(xstar))';
E = 50e9;
v = 0.25;
Te = 15e3;

D = (E*Te^3)/(12*(1-v^2));

rho_c = 2700;
rho_m = 3300;
rho_s = 2700;

alpha = calcAlpha(D,rho_m,rho_s);
Wtstar = 200e3 / alpha;

%Hstar = buildLineLoad(xstar, dxstar, 0);
H = zeros(size(xstar))';
H(xstar < Wtstar) = 2e3;
F = 1e3 * Wtstar;

Hstar = H ./ F;

wstar = solveW(dxstar,Dstar,Hstar);

w0 = calcw0(rho_c,rho_m,rho_s,F);

x = xstar .* alpha ./1000;
w = wstar .* w0 ./ 1000;

figure;
plot(x-200,-w);
hold on;
plot(x-200,zeros(size(x))');
axis([0,500,-3,1.5]);
% xlabel('distance from rangefront (km)');
