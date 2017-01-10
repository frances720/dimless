dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 7;
%Hmax = 4e3;
Hmax = linspace(2000,4000,pt);
rho_c = 2900;
%rho_c = linspace(2600,3200,pt);
rho_m = 3400;
%rho_s = linspace(1800,2600,pt);
rho_s = 2200;

Wtstar = 4;
D1star = 0.125;
Ltstar = 1;
Lcstar = 4;
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

T1 = 20e3;
T2 = 40e3;
E = 70e9;
v = 0.25;
g = 9.8;
D2 = E.*T2.^3./(12.*(1-v.^2));
a = (4.*D2./((rho_m-rho_s).*g)).^(1/4);

thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar - Ltstar)).*T1 + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar - Ltstar))).*((xstar - Lcstar + Ltstar).*(T2 - T1)./Ltstar + T1);
thickness = thickness';

%w = zeros(length(wstar),pt);

for i = 1:pt
    [Hstar,F] = buildBlockLoad_dim(xstar,dxstar,Wtstar,Hmax(i));
    wstar = solveW(dxstar,Dstar,Hstar);
    w0 = calcw0(rho_c,rho_m,rho_s,F);
    w = w0.*wstar;
    iso_deflect = ((rho_m - rho_c) / (rho_m - rho_s)) .* (T2 - thickness);
    plot(xstar,-iso_deflect-w);
    hold on
end


