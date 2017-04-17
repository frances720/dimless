% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 45e3;
T2 = 55e3;
D1star = (T1/T2)^3;

E = 100e9;
v = 0.25;
D = calcD(T2,E,v);

% compute alpha from distal D
rho_m = 3300;
rho_s = 2650;
alpha = calcAlpha(D,rho_m,rho_s);
Lcstar = 800e3/alpha;

Dstar = computeDstar(xstar,D1star,Lcstar,Lcstar);

% build topographic load
blockEnd = 250e3 / alpha;
wedgeEnd = 400e3 / alpha;
height = 5e3;

H = zeros(size(Dstar));
H(xstar < wedgeEnd) = height*(wedgeEnd - xstar(xstar < wedgeEnd))/(wedgeEnd - blockEnd);
H(xstar < blockEnd) = 5e3;

F = sum(H) * dxstar;
Hstar = H./F;

% compute w
wstar = solveW(dxstar,Dstar,Hstar);

rho_c = 2725;
w0 = calcw0(rho_c,rho_m,rho_s,F);

x = xstar .* alpha ./1000;
w = wstar .* w0 ./ 1000;
%plot(x,-w);
figure;
plot(x-400,-w);
hold on;
%plot(x-400,zeros(size(x))');
axis([0,250,-7,1.5]);
% xlabel('distance from rangefront (km)');

% plot(xstar - wedgeEnd,-wstar);
% axis([0,2,-0.5,0.2]);

% figure;
% plot(xstar,Dstar);
% hold on;
% plot(xstar,Dstar_real);
% axis([0,6,0,1]);
