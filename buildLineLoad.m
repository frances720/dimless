function Hstar = buildLineLoad(xstar)
Hstar = zeros(size(xstar));
Hstar(1) = 1/(xstar(2)-xstar(1));
Hstar = Hstar';
end
