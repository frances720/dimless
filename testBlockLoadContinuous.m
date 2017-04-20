% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

% assume uniform rigidity
Dstar = ones(size(xstar))';

Wtstar = 10;
Hstar = zeros(size(xstar))';
Hstar(xstar <= Wtstar) = 10;
Hstar = Hstar ./ Wtstar;

% analytical solution from Turcotte and Schubert
wstarBench = exp(-xstar).*(cos(xstar)+sin(xstar));
basinArea = wstarBench*wstarBench';
wstarBench = wstarBench';
plot(xstar + Wtstar,-wstarBench);
hold on

wstar = solveW(dxstar,Dstar,Hstar);

xstarclip = xstar(Wtstar/dxstar + 1:end);
wstarclip = wstar(Wtstar/dxstar + 1:end);

wstarBenchclip = [wstarBench(1:Wtstar/dxstar);0];

e = wstarBenchclip-wstarclip;
et = e';
l2mat = et*e;

ratio = l2mat/basinArea;

plot(xstar,-wstar);