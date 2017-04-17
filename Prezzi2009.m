% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 50e3;
T2 = 60e3;
D1star = (T1/T2)^3;

E = 70e9;
v = 0.25;
D = calcD(T2,E,v);

rho_c = 2900;
rho_m = 3330;
rho_s = 2200;

alpha = calcAlpha(D,rho_m,rho_s);
Lcstar = 470e3/alpha;
Ltstar = 270e3/alpha;
x = xstar .* alpha ./1000;

Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

Wtstar = 200e3 / alpha;
H = zeros(size(xstar))';
H(xstar < Wtstar) = 0.4e3;
H(xstar < 160e3/alpha) = 1.1e3;
H(xstar < 100e3/alpha) = 2.7e3;
% H(xstar < Wtstar) = 2e3;
% height = 5e3;
% H(xstar < Wtstar) = height*(Wtstar - xstar(xstar < Wtstar))/Wtstar;

% H = zeros(size(Dstar));
% load('Prezzi2009Load.mat');
% height = Prezzi2009Load(:,2);
% xforh = Prezzi2009Load(:,1) * 1000;
% Wtind = round((max(xforh)/alpha)/dxstar);
% Hp = interp1(xforh./alpha,height,xstar(1:Wtind));
% H(1:Wtind) = Hp;
% H(x > 200) = 0;
% % H= H.*2800/2900;

F = sum(H) * dxstar;

Hstar = H ./ F;

wstar = solveW(dxstar,Dstar,Hstar);

w0 = calcw0(rho_c,rho_m,rho_s,F);

w = wstar .* w0 ./ 1000;

figure;
plot(x-200,-w);
hold on;
plot(x-200,zeros(size(x))');
axis([0,400,-3.5,1.5]);
xlabel('distance from rangefront (km)');
