pt = 20;
x = 0:0.01:20;
dx = x(2)-x(1);
Wt = dx;
H = zeros(size(x));
H(x < Wt) = 1;
F = 1*Wt;
H = H./F;
H = H';
plot(x,H);
Ltstar = 0.2084;
Lcstar = 4.0572;
D1star = linspace(0.0029,0.125,pt);
D2star = 1;
Dtstar_Fun = @(Ltstar,D1star,Lcstar)...
    ((x - Lcstar).*(1-D1star.^(1/3))./Ltstar + 1).^3;

for i = 1:length(D1star)
    Dtstar = Dtstar_Fun(Ltstar,D1star(i),Lcstar);
    Dstar = (x > Lcstar).*D2star + (x < Lcstar-Ltstar).*D1star(i) +...
        ((x <= Lcstar) & (x >= (Lcstar-Ltstar))).*Dtstar;
    Dstar = Dstar';
    w = solveW(dx,Dstar,H);
    plot(x,-w);
    hold on
end

axis([0,5,-inf,3]);