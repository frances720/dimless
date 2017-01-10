% dimensionless horizontal length-scale
dxstar = 0.01;
xstar = 0:dxstar:20;

%computing load for flexure (dim on vertical and dimless on horizontal)
Hmax = 2000;
Wtstar = 16666.66/2000;
[Hstar,F] = buildBlockLoad_dim(xstar,dxstar,Wtstar,Hmax);

%compute flexure wstar
T1 = linspace(5e3,35e3,7);
T2 = 50e3;

Ltstar = 2;
Lcstar = 11;

%compute w0
rho_c = 2900;
rho_m = 3400;
rho_s = 2200;

w0 = calcw0(rho_c,rho_m,rho_s,F);
w_sag_star = (rho_m - rho_c) / (rho_m - rho_s);


%compute the inital sag (dimensionless)
for i = 1:length(T1)
    D1star = (T1(i)/T2)^3;
    thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar - Ltstar)).*T1(i) + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar - Ltstar))).*((xstar - Lcstar + Ltstar).*(T2 - T1(i))./Ltstar + T1(i));
    thickness = thickness';
    dT = T2 - thickness;
    
    Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
    wstar = solveW(dxstar,Dstar,Hstar);
    
    %compute the dial N
    N = w0 ./ (dT + w0);
    
    wtotstar = wstar.*N + w_sag_star.*(1-N).*ones(size(wstar));
    plot(xstar,N);
    hold on
end

xlabel('xstar');
ylabel('N');
legend(sprintf('T1 = %.1f',T1(1)),sprintf('T1 = %.1f',T1(2)),...
    sprintf('T1 = %.1f',T1(3)),sprintf('T1 = %.1f',T1(4)),...
    sprintf('T1 = %.1f',T1(5)),sprintf('T1 = %.1f',T1(6)),...
    sprintf('T1 = %.1f',T1(7)),'Location','southeast');



