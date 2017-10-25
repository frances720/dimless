dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 20e3;
T2 = 40e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2400;
rho_c = 2850;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

Lc = 200e3;
Lt = 130e3;

D1star = (T1./T2).^3;
D2 = calcD(T2,E,v);
alpha = calcAlpha(D2,rho_m,rho_s);
Lcstar = Lc/alpha;
Ltstar = Lt/alpha;

Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

Wt = (70:10:150)*1e3;
Wtstar = Wt./alpha;

for i = 1:length(Wtstar)
    H = zeros(size(xstar))';
    H(xstar <= Wtstar(i)) = 2e3;
    w = -solveW_dimOnVertical(dxstar,Dstar,rho_star,H);
    plot(xstar*alpha/1e3,w/1e3);
    hold on
    plot(xstar*alpha/1e3,H/1e3,'k')
end

axis([0,500,-7,2.2]);
xlabel('Distance across basin (km)');ylabel('Deflection (km)');
title('Thrust belt propagation for Magallanes Basin');