function Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar)
D2star = 1;
Dtstar = ((xstar - Lcstar).*(1 - D1star.^(1/3))./Ltstar + 1).^3;
Dstar = (xstar > Lcstar).*D2star + (xstar < Lcstar-Ltstar).*D1star +...
        ((xstar <= Lcstar) & (xstar >= (Lcstar-Ltstar))).*Dtstar;
Dstar = Dstar';
end