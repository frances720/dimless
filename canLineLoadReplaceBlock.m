% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

Wtstar = 1.84;

% block load
Hmax = 2e3;
H = zeros(size(xstar));
H(xstar < Wtstar) = Hmax;

F = Hmax * Wtstar;
Hstar = H./F;
Hstar = Hstar';

% line load
% Hstar = zeros(size(xstar))';
% ind = Wtstar / dxstar;
% Hstar(ind/2) = 100;

D1star = 1;
Ltstar = 1;
Lcstar = 2;
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
wstar = solveW(dxstar,Dstar,Hstar);

hold on
plot(xstar,-wstar);