pt = 20;
x = 0:0.01:20;
dx = x(2)-x(1);
Wt = dx;
H = squareLoad(x,Wt);
plot(x,H);
Ltstar = linspace(0.2084,2.4343,pt);
Lcstar = 4.0572;
D1star = 0.125;
D2star = 1;
Dtstar_Fun = @(Lts,D1s,Lcs) ((x - Lcs).*(1-D1s.^(1/3))./Lts + 1).^3;

for i = 1:pt
    Dtstar = Dtstar_Fun(Ltstar(i),D1star,Lcstar);
    Dstar = (x > Lcstar).*D2star + (x < Lcstar-Ltstar(i)).*D1star +...
        ((x <= Lcstar) & (x >= (Lcstar-Ltstar(i)))).*Dtstar;
    Dstar = Dstar';
    w = solveW(dx,Dstar,H);
    plot(x,-w);
    hold on
end

axis([0,5,-inf,3]);