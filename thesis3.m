dxstar = 0.01;
xstar = 0:dxstar:20;

Dstar = ones(size(xstar))';

linepos = 7;
Hstar = zeros(size(xstar))';
Hstar(linepos/dxstar) = 100;

wstar = - solveW(dxstar,Dstar,Hstar);
plot(xstar,wstar,'k-','LineWidth',2);

blockWidth = linspace(dxstar,7,20);

for i = 1:length(blockWidth)
    Hstar(xstar < linepos) = 100;
    Hstar(xstar < 7-blockWidth(i)) = 0;
    F = sum(Hstar);
    Hstar = Hstar ./ F;
    
    wstar = - solveW(dxstar,Dstar,Hstar);
    plot(xstar,wstar)
    hold on
    plot(xstar,Hstar);
    
end

