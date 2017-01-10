% dimensionless horizontal length-scale
dxstar = 0.01;
xstar = 0:dxstar:20;

%computing load for flexure (dim on vertical and dimless on horizontal)
Hmax = 2e3;
Wtstar = 10;
[Hstar,F] = buildBlockLoad_dim(xstar,dxstar,Wtstar,Hmax);

%compute flexure wstar
T1 = 20e3;
T2 = 40e3;
D1star = (T1/T2)^3;
Ltstar = 4;
Lcstar = 12;
% Dstar = ones(size(xstar))';
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

%compute w0
% rho_c = 2900;
% rho_m = 3400;
% rho_s = 2200;
rhostar = 1/2;

%compute the inital sag (dimensionless)
thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar - Ltstar)).*T1 + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar - Ltstar))).*((xstar - Lcstar + Ltstar).*(T2 - T1)./Ltstar + T1);
thickness = thickness';
dT = T2 - thickness;

gmstar = dT/F;

% for i = 1:length(Hmax)
    wstar = solveW(dxstar,Dstar,Hstar);
    
    %compute the dial N
    N = 1./(1 + 2.*gmstar.*rhostar);
    
    w_sag_star = (rho_m - rho_c) / (rho_m - rho_s);
    wtotstar = wstar.*N + w_sag_star.*(1-N).*ones(size(wstar));
    plot(xstar,N);
    hold on
% end

% xlabel('xstar');
% ylabel('N');
% legend(sprintf('Hmax = %.0f',Hmax(1)),sprintf('Hmax = %.0f',Hmax(2)),...
%     sprintf('Hmax = %.0f',Hmax(3)),sprintf('Hmax = %.0f',Hmax(4)),...
%     sprintf('Hmax = %.0f',Hmax(5)),sprintf('Hmax = %.0f',Hmax(6)),...
%     sprintf('Hmax = %.0f',Hmax(7)),'Location','southeast');



