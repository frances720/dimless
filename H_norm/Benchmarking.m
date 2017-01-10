% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

% assume uniform rigidity
Dstar = ones(size(xstar))';

% (rho_m - rho_s) / rho_c
rhostar = 1;

% analytical solution from Turcotte and Schubert
wstarBench = exp(-xstar).*(cos(xstar)+sin(xstar));
wstarBench = wstarBench';
plot(xstar,-wstarBench);
hold on

wstar = solveW(dxstar,Dstar,rhostar);
fpwstar = flipud(wstar) - 1;

e = wstarBench-fpwstar;
et = e';
l2mat = et*e;

plot(xstar,fpwstar);