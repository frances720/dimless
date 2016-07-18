% base case with a block mountain belt

x = 0:0.01:20;
dx = x(2)-x(1);
% magallanes base case
g = 9.8;
T1 = 45e3;
T2 = 55e3;
Lc = 280e3;
Lt = 180e3;
Wt = 200e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2450;

% D
D2 = E.*T2.^3./(12.*(1-v.^2));
a = (4.*D2./((rho_m-rho_s).*g)).^(1/4);
Lcstar = Lc./a;
Ltstar = Lt./a;
D1star = (T1./T2).^3;
D2star = 1;
Dtstar = ((x-Lcstar).*(1-D1star.^(1/3))./Ltstar + 1).^3;
Dstar = (x > Lcstar).*D2star + (x < Lcstar-Ltstar).*D1star +...
    ((x <= Lcstar) & (x >= (Lcstar-Ltstar))).*Dtstar;
Dstar = Dstar';

% distributed load (a block)
Wtstar = Wt./a;
H = zeros(size(x));
H(x <= Wtstar) = 1;
F = sum(H).*dx;
H = H./F;
H = H';

% % distributed load (wedge)
% Wtstar = Wt./a;
% s = 3;
% H = (Wtstar - x > 0).*(Wtstar - x).*tan(s.*pi./180);
% F = sum(H).*dx;
% H = H./F;
% H = H';

w = solveW(dx,Dstar,H);
plot(x,-w); hold on
plot(x,H);