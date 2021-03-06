% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

% assume uniform rigidity
Dstar = ones(size(xstar))';

D = 7e23;
rho_c = 2650;
rho_m = 3300;
rho_s = 2400;

alpha = calcAlpha(D,rho_m,rho_s);
Wtstar = 300e3 / alpha;

%Hstar = buildLineLoad(xstar, dxstar, 0);
H = zeros(size(xstar))';
H(xstar < Wtstar) = 2e3;
F = 2e3 * Wtstar;

Hstar = H ./ F;

wstar = solveW(dxstar,Dstar,Hstar);

w0 = calcw0(rho_c,rho_m,rho_s,F);

x = xstar .* alpha ./1000;
w = wstar .* w0 ./ 1000;

figure;
plot(x-300,-w);
hold on;
plot(x-300,zeros(size(x))');
axis([0,500,-3,1.5]);
xlabel('distance from rangefront (km)');
