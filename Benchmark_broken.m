% dimensionless space
xstar = 0:0.01:20;
dxstar = xstar(2)-xstar(1);

% assume uniform rigidity
Dstar = ones(size(xstar))';

% normalized line load at xstar = 0
Hstar = zeros(size(xstar))';
Hstar(1) = 100;

% analytical solution from Turcotte and Schubert
wstarBench = exp(-xstar).*cos(xstar);
wstarBench = wstarBench';
plot(xstar,-wstarBench);
hold on

wstar = solveW_broken(dxstar,Dstar,Hstar);

% e = wstarBench-wstar;
% et = e';
% l2mat = et*e;

plot(xstar,-wstar);

plot(xstar,zeros(size(xstar))');
axis([0,6,-1.2,0.2]);