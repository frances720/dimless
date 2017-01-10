function [Hstar,F] = buildBlockLoad(xstar,dxstar,WtstarFin)
Hstar = zeros(size(xstar));

if WtstarFin < dxstar
    F = dxstar; % line load
    Hstar(1) = 1;
else
    Hstar(xstar < WtstarFin) = 1;
    F = 1*WtstarFin;
end

Hstar = Hstar./F;
Hstar = Hstar';
end
