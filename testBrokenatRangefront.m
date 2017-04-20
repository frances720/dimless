% dimensionless space
dxstar = 0.005;
xstar = 0:dxstar:20;

% assume uniform rigidity
Dstar = ones(size(xstar))';

% long block load (isostasy)
Wtstar = 10;
Hstar = zeros(size(xstar))';
Hstar(xstar <= Wtstar) = 10;
Hstar = Hstar ./ Wtstar;

% analytical solution from Turcotte and Schubert
wstarBench = exp(-xstar).*cos(xstar);
L2norm = wstarBench*wstarBench';
wstarBench = wstarBench';

wstar = solveW(dxstar,Dstar,Hstar);

% plot(xstar,-wstar);
% hold on
% 
% plot(xstar+Wtstar,-wstarBench);
% 
% plot(xstar,zeros(size(xstar))');

xstarclip = xstar(Wtstar/dxstar + 1:end);
wstarclip = wstar(Wtstar/dxstar + 1:end);

wstarBenchclip = [wstarBench(1:Wtstar/dxstar);0];

e = wstarBenchclip-wstarclip;
et = e';
l2mat = et*e;

ratio = l2mat/L2norm;

% axis([0,6,-1.2,0.2]);