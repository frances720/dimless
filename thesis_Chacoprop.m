dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 48e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2400;
rho_c = 2650;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

D1 = calcD(T1,E,v);
alpha = calcAlpha(D1,rho_m,rho_s);
Dstar = ones(size(xstar))';
Wt = (220:10:300)*1e3;
Wtstar = Wt./alpha;

for i = 1:length(Wtstar)
    H = zeros(size(xstar))';
    H(xstar <= Wtstar(i)) = 2e3;
    w = - solveW_dimOnVertical(dxstar,Dstar,rho_star,H);
    plot(xstar*alpha/1e3, w/1e3);
    hold on
    plot(xstar*alpha/1e3, H/1e3,'k');
end

axis([0,600,-6.5,2.2]);
xlabel('Distance across basin (km)');ylabel('Deflection (km)');
title('Thrust belt propagation for Chaco Basin');