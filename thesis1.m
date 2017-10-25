dxstar = 0.01;
xstar = 0:dxstar:20;

D1star = logspace(-2,0,20);

Wtstar = 1;
Lcstar = 10;
Ltstar = 0.1;

Hstar = zeros(size(xstar))';
Hstar(xstar < Wtstar) = 1;
% Hstar = Hstar ./ sum(Hstar);

figure
for i = 1:length(D1star)
    Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
    wstar = - solveW(dxstar,Dstar,Hstar);
    plot(xstar,wstar);
    hold on
end

