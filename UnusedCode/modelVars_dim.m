clear all;

% Finite difference mesh
x = (1:1:2000).*1e3; % (m)

% Constant Parameters
g = 9.8; % gravity acceleration (m/s^2)
v = 0.25; % poison's ratio
E = 50*1e9; % Young's Modulus (Pa)
rho_s = 2450; % density of sediments (kg/m^3)
rho_c = 2700; % density of crust (kg/m^3)
rho_m = 3300; % density of mantle (kg/m^3)

% Crustal Properties
T2 = 50*1e3;
T1 = 20*1e3;
Lc = 280*1e3;
Lt = 180*1e3;

% Build Thrust Belt Topography
S = 3; %slope of thrust belt
Wt = 100.*1e3; % width of thrust belt (m)
H = (Wt - x > 0).*(Wt - x).*tan(S.*pi./180);
Hmax = 3*1e3;
H(H > Hmax) = Hmax;
H(H < 0) = 0;
F = sum(H);
w0 = rho_c.*F./(2.*(rho_m-rho_s));

T1star = T1./w0;
T2star = T2./w0;

% Normalizing Parameters (a-horizontal, w0-veritical)
D2 = E.*T2.^3./(12.*(1-v.^2));
a = (4.*D2./((rho_m-rho_s).*g)).^(1/4); % flexural parameter (m)
xstar = x./a;

Lcstar = Lc./a;
Ltstar = Lt./a;
Hstar = H./F./a;

hstar = (xstar > Lcstar).*T2star + (xstar < (Lcstar-Ltstar)).*T1star + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar-Ltstar))).*((xstar-Lcstar+Ltstar).*(T2star-T1star)./Ltstar + T1star);

hstar = hstar';
Hstar = Hstar';

dxstar = x(2) - x(1);

% Match Matrix Dimensions
rho_m = rho_m.*ones(length(x),1);
rho_c = rho_c.*ones(length(x),1);
rho_s = rho_s.*ones(length(x),1);

w = solveW(dxstar,rho_m,rho_c,rho_s,E,v,hstar,Hstar,'Airy');

plot(xstar,-w);
hold on
%plot(xstar,Hstar);
%axis([0,100000,-inf,inf])






