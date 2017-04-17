% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

% compute D from Te
E = 100e9;
v = 0.25;
load('Jordan1.mat');
Te = Jordan1(:,2) * 1000;
D_pts = calcD(Te,E,v);
xaxis = Jordan1(:,1) * 1000;
[extent,ind] = max(xaxis);
D2 = D_pts(ind);

% compute alpha from distal D
rho_m = 3300;
rho_s = 2650;
alpha = calcAlpha(D2,rho_m,rho_s);

% construct Dstar with extracted data from Jordan
D = D2.*ones(size(xstar))';
endind = round((extent/alpha)/dxstar);
Dp = interp1(xaxis./alpha,D_pts,xstar(1:endind));
D(1:endind) = Dp;
Dstar = D./D2;

% build topographic load
blockEnd = 250e3 / alpha;
wedgeEnd = 400e3 / alpha;
height = 5e3;

H = zeros(size(Dstar));
H(xstar < wedgeEnd) = height*(wedgeEnd - xstar(xstar < wedgeEnd))/(wedgeEnd - blockEnd);
H(xstar < blockEnd) = height;

F = sum(H) * dxstar;
Hstar = H./F;

wstar = solveW(dxstar,Dstar,Hstar);

rho_c = 2725;
w0 = calcw0(rho_c,rho_m,rho_s,F);

x = xstar .* alpha ./1000;
w = wstar .* w0 ./ 1000;
hold on;
%plot(x,-w);
%figure;
% hold on;
plot(x-400,-w);
% hold on;
% plot(x-400,zeros(size(x))');
% axis([0,500,-7,1.5]);
% xlabel('distance from rangefront (km)');

% plot(xstar - wedgeEnd,-wstar);
% axis([0,2,-0.5,0.2]);
