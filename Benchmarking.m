% dimensionless space
xstar = 0:0.01:20;
dxstar = xstar(2)-xstar(1);

% assume uniform rigidity
Dstar = ones(size(xstar))';

% normalized line load at xstar = 0
Hstar = buildLineLoad(xstar, dxstar, 0);

% analytical solution from Turcotte and Schubert
wstarBench = exp(-xstar).*(cos(xstar)+sin(xstar));
wstarBench = wstarBench';
plot(xstar,-wstarBench);
hold on

wstar = solveW(dxstar,Dstar,Hstar);

e = wstarBench-wstar;
et = e';
l2mat = et*e;

plot(xstar,-wstar);
grid on