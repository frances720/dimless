% dimensionless space
xstar = 0:0.01:5;
dxstar = xstar(2)-xstar(1);

T1 = 7e3;
T2 = 13e3;

% Te = 10e3;
E = 70e9;
v = 0.25;
D = (E*T2^3) / (12*(1-v^2)); 
rho_c = 2800;
rho_m = 3300;
rho_s = 2700;

Lcstar = 20;
Ltstar = 20;
D1star = (T1/T2)^3;
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

% Dstar = ones(size(xstar))';
alpha = calcAlpha(D,rho_m,rho_s);
Wtstar = 50e3 / alpha;

%Hstar = buildLineLoad(xstar, dxstar, 0);
H = zeros(size(xstar))';
H(xstar < Wtstar) = 350;
F = 350 * Wtstar;

Hstar = H ./ F;

wstar = solveW(dxstar,Dstar,Hstar);

w0 = calcw0(rho_c,rho_m,rho_s,F);

x = xstar .* alpha ./1000;
w = wstar .* w0 ./ 1000;

figure;
plot(x-50,-w);
hold on;
plot(x-50,zeros(size(x))');
axis([0,700,-1.7,0.2]);
xlabel('distance from rangefront (km)');
[depth,width] = findDepthWidthofBasin(x,w,50);