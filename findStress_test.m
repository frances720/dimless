% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:10;

% dimensional parameteres
Te = 20e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2400;
rho_c = 2700;
coef = E / (1-v^2);
rho_star = calcRhoStar(rho_c,rho_m,rho_s);
D = calcD(Te,E,v);
alpha = calcAlpha(D,rho_m,rho_s);

% convert to dim space for calculating curvature
dx = dxstar .* alpha;
x = xstar .* alpha;

% dimensionless parameters to feed into the model
Dstar = ones(size(xstar))';
Wtstar = 0.5;

% dimensional load
H = zeros(size(xstar))';
H(xstar < Wtstar) = 0.5e3;

% dimensional w
w = -solveW_dimOnVertical(dxstar,Dstar,rho_star,H);
wdiff = [w(3);w(2);w;0;0];

% curvature eqn from T&S
curv = (wdiff(3:end) - 2.*wdiff(2:end-1) + wdiff(1:end-2))./dx.^2;

% setting up the matrix
h = 200; % finite diff grid
y = linspace(-10e3,10e3,h)';
yMat = repmat(y,1,length(xstar));
curv = curv(2:end-1)';
curvMat = repmat(curv,h,1);
strainMat = curvMat .* yMat;

% compute stresses
stressMat = coef .* strainMat;

% plotting deflection/stress
figure;
subplot(2,1,1);
plot(x/1e3,w/1e3);
xlabel('distance (km)');
ylabel('deflection (km)');
title(sprintf('Mtn belt width: %0.f km, Mtn belt height: %0.1f km',...
    Wtstar*alpha/1e3,H(1)/1e3));
% axis equal

subplot(2,1,2);
imagesc(stressMat);
pbaspect([5 1 1])
colorbar;
colormap jet;
% 
% plot(xstar,stress)