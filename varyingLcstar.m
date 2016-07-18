pt = 20;
x = 0:0.01:20;
dx = x(2)-x(1);
Wt = dx;
H = squareLoad(x,Wt);
plot(x,H);
Ltstar = 0.2084;
Lcstar = linspace(0.4169,4.0572,pt);
D1star = 0.125;
D2star = 1;
Dtstar_Fun = @(Lts,D1s,Lcs) ((x - Lcs).*(1-D1s.^(1/3))./Lts + 1).^3;

for i = 1:pt
    Dtstar = Dtstar_Fun(Ltstar,D1star,Lcstar(i));
    Dstar = (x > Lcstar(i)).*D2star + (x < Lcstar(i)-Ltstar).*D1star +...
        ((x <= Lcstar(i)) & (x >= (Lcstar(i)-Ltstar))).*Dtstar;
    Dstar = Dstar';
    w = solveW(dx,Dstar,H);
    plot(x,-w);
    hold on
end

axis([0,5,-inf,1]);