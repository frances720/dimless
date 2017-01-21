% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

Wtstar = linspace(0.01,10,50);
diff = zeros(size(Wtstar))';

% D1star = 1;
% Ltstar = 1;
% Lcstar = 2;
% Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

Dstar = ones(size(xstar))';
    
for i = 1:length(Wtstar)    
    % block load
    Hmax = 2e3;
    H = zeros(size(xstar));
    H(xstar < Wtstar(i)) = Hmax;
    F = Hmax * Wtstar(i);
    HstarB = H'./F;
    wstarBlock = solveW(dxstar,Dstar,HstarB);

    % line load
    HstarL = zeros(size(xstar))';
    ind = Wtstar(i) / dxstar;
    HstarL(1) = 100;
    wstarLine = solveW(dxstar,Dstar,HstarL);

    e = wstarBlock - wstarLine;
    et = e';
    diff(i) = et*e;
%    diff(i) = findRMS(wstarBlock,wstarLine);
end

plot(Wtstar,diff);
