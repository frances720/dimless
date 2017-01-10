function Hstar = buildLineLoad(xstar, dxstar, pos)
Hstar = zeros(size(xstar));
xstarind = pos/dxstar + 1;
Hstar(xstarind) = 1/dxstar;
Hstar = Hstar';
end
