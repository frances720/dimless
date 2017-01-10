% dimensionless horizontal length-scale
dxstar = 0.01;
xstar = 0:dxstar:20;

%computing load for flexure (dim on vertical and dimless on horizontal)
Hmax = 2000;
Wtstar = 16666.66/2000;
[Hstar,F] = buildBlockLoad_dim(xstar,dxstar,Wtstar,Hmax);

%compute flexure wstar
T1 = 20e3;
T2 = 40e3;

Ltstar = 2;
Lcstar = 11;

%compute w0
rho_c = 2900;
rho_m = 3400;
rho_s = linspace(1800,2400,7);

D1star = (T1/T2)^3;
thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar - Ltstar)).*T1 + ...
((xstar <= Lcstar) & (xstar >= (Lcstar - Ltstar))).*((xstar - Lcstar + Ltstar).*(T2 - T1)./Ltstar + T1);
thickness = thickness';
dT = T2 - thickness;

Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
wstar = solveW(dxstar,Dstar,Hstar);

%compute the inital sag (dimensionless)
for i = 1:length(rho_s)
    w0 = calcw0(rho_c,rho_m,rho_s(i),F);
    w_sag_star = (rho_m - rho_c) / (rho_m - rho_s(i));
    %compute the dial N
    N = w0 ./ (dT + w0);
    
    wtotstar = wstar.*N + w_sag_star.*(1-N).*ones(size(wstar));
    plot(xstar,N);
    hold on
end

xlabel('xstar');
ylabel('N');
legend(sprintf('rho_s = %.1f',rho_s(1)),sprintf('rho_s = %.1f',rho_s(2)),...
    sprintf('rho_s = %.1f',rho_s(3)),sprintf('rho_s = %.1f',rho_s(4)),...
    sprintf('rho_s = %.1f',rho_s(5)),sprintf('rho_s = %.1f',rho_s(6)),...
    sprintf('rho_s = %.1f',rho_s(7)),'Location','southeast');



