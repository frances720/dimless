function H = squareLoad(x,Wt)
H = zeros(size(x));
H(x < Wt) = 1;
F = 1*Wt;
H = H./F;
H = H';
end