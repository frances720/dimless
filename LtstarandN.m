% dimensionless horizontal length-scale
dxstar = 0.01;
xstar = 0:dxstar:20;

%computing load for flexure (dim on vertical and dimless on horizontal)
Hmax = 2000;
Wtstar = 5;

%compute flexure wstar
T1 = 20e3;
T2 = 40e3;
D1star = (T1/T2)^3;
Ltstar = linspace(1,6,7);
Lcstar = 11;

%compute w0
rho_c = 2900;
rho_m = 3400;
rho_s = 2200;


%compute the inital sag (dimensionless)



for i = 1:length(Ltstar)
    thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar - Ltstar(i))).*T1 + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar - Ltstar(i)))).*((xstar - Lcstar + Ltstar(i)).*(T2 - T1)./Ltstar(i) + T1);
    thickness = thickness';
    dT = T2 - thickness;
    [Hstar,F] = buildBlockLoad_dim(xstar,dxstar,Wtstar,Hmax);
    Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar(i));
    wstar = solveW(dxstar,Dstar,Hstar);
    w0 = calcw0(rho_c,rho_m,rho_s,F);
    
    %compute the dial N
    N = w0 ./ (dT + w0);
    
    w_sag_star = (rho_m - rho_c) / (rho_m - rho_s);
    wtotstar = wstar.*N + w_sag_star.*(1-N).*ones(size(wstar));
    plot(xstar,N);
    hold on
end

xlabel('xstar');
ylabel('N');
legend(sprintf('Ltstar = %.1f',Ltstar(1)),sprintf('Ltstar = %.1f',Ltstar(2)),...
    sprintf('Ltstar = %.1f',Ltstar(3)),sprintf('Ltstar = %.1f',Ltstar(4)),...
    sprintf('Ltstar = %.1f',Ltstar(5)),sprintf('Ltstar = %.1f',Ltstar(6)),...
    sprintf('Ltstar = %.1f',Ltstar(7)),'Location','southeast');



