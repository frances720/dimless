function Hstar = uniformHstar(xstar,WtstarFin)
Hstar = zeros(size(xstar))';
Hstar(xstar < WtstarFin) = 1;
