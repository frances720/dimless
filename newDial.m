% dimensionless horizontal length-scale
dxstar = 0.01;
xstar = 0:dxstar:20;

%to be changed
%computing load for flexure (dim on vertical and dimless on horizontal)
Hmax = 2e3;
Wtstar = 10;
[Hstar,F] = buildBlockLoad_dim(xstar,dxstar,Wtstar,Hmax);

%compute flexure wstar
T1 = 20e3;
T2 = 40e3;
D1star = (T1/T2)^3;
Ltstar = 2;
Lcstar = 11;
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
wstar = solveW(dxstar,Dstar,Hstar);

%compute w0
rho_c = 2900;
rho_m = 3400;
rho_s = 2200;
rho_star = rho_c/(rho_m-rho_s);
w0 = calcw0(rho_c,rho_m,rho_s,F);

%compute the inital sag (dimensionless)
thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar - Ltstar)).*T1 + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar - Ltstar))).*((xstar - Lcstar + Ltstar).*(T2 - T1)./Ltstar + T1);
thickness = thickness';
dT = T2 - thickness;

gamma_star = dT./F;

%compute the dial N
N = rho_star./(rho_star + 2.*gamma_star);
%N = 0.5;
w_sag_star = (rho_m - rho_c) / (rho_m - rho_s);
wtotstar = wstar.*N + w_sag_star.*(1-N).*ones(size(wstar));
plot(xstar,-wtotstar);



