dxstar = 0.01;
xstar = 0:dxstar:20;

Dstar = ones(size(xstar))';

%isostasy case
Wtstar_b = 10;
Hstar_b = zeros(size(xstar))';
Hstar_b(xstar < Wtstar_b) = 1;
wstar_b = - solveW(dxstar,Dstar,Hstar_b);

Wtstar = linspace(dxstar,10,50);
w0 = zeros(size(Wtstar));
for i = 1:length(Wtstar)
    Hstar = zeros(size(xstar))';
    Hstar(xstar < Wtstar(i)) = 1;
    wstar = - solveW(dxstar,Dstar,Hstar);
    w0(i) = wstar(1);
    plot(xstar-Wtstar(i),wstar);
    hold on
end

% plot(Wtstar,-(w0+2))