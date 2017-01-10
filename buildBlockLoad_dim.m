function [Hstar,F] = buildBlockLoad_dim(xstar,dxstar,WtstarFin,Hmax)

H = zeros(size(xstar));

if WtstarFin < dxstar
    F = Hmax * dxstar; % line load
    H(1) = Hmax;
else
    H(xstar < WtstarFin) = Hmax;
    F = Hmax * WtstarFin;
    
end

Hstar = H./F;
Hstar = Hstar';
end