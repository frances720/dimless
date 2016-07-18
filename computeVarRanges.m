xstar = 0:0.01:20;
dxstar = xstar(2)-xstar(1);

% value ranges for model variables
g = 9.8;
T1min = 10*1e3;
T1max = 15*1e3;
T2min = 30*1e3;
T2max = 70*1e3;
Emin = 50*1e9;
Emax = 75*1e9;
vmin = 0.2;
vmax = 0.28;
rho_mmin = 3300;
rho_mmax = 3400;
rho_cmin = 2700;
rho_cmax = 3100;
rho_smin = 1800;
rho_smax = 2600;
smin = 0.5;
smax = 6;
Wtmin = 50*1e3;
Wtmax = 400*1e3;
Ltmin = 40*1e3;
Ltmax = 180*1e3;
Lcmin = 80*1e3;
Lcmax = 300*1e3;

% dimensional values to compute a
D2_Fun = @(E,T2,v) E.*T2.^3./(12.*(1-v.^2));
D2min = D2_Fun(Emin,T2min,vmin);
D2max = D2_Fun(Emax,T2max,vmax);
a_Fun = @(D2,rho_m,rho_s) (4.*D2./((rho_m-rho_s).*g)).^(1/4);
amin = a_Fun(D2min,rho_mmax,rho_smin);
amax = a_Fun(D2max,rho_mmin,rho_smax);

% dimensionless
Lcstarmin = Lcmin./amax;
Lcstarmax = Lcmax./amin;
Ltstarmin = Ltmin./amax;
Ltstarmax = Ltmax./amin;
Wtstarmin = Wtmin./amax;
Wtstarmax = Wtmax./amin;

D1star_Fun = @(T1,T2) (T1./T2).^3;
D1starmin = D1star_Fun(T1min,T2max);
D1starmax = D1star_Fun(T1max,T2min);

Dtstar_Fun = @(Lt,D1star,Lc) ((xstar-Lc).*(1-D1star.^(1/3))./Lt + 1).^3;
Dtstarmin = Dtstar_Fun(Ltstarmin,D1starmin,Lcstarmin);
Dtstarmax = Dtstar_Fun(Ltstarmax,D1starmax,Lcstarmax);

% % % flexural rigidity
% % D2star = 1;
% % Dstarmin = (xstar > Lcstarmin).*D2star + (xstar < Lcstarmin-Ltstarmin).*D1starmin + ((xstar <= Lcstarmin) & (xstar >= (Lcstarmin-Ltstarmin))).*Dtstarmin;
% % Dstarmax = (xstar > Lcstarmax).*D2star + (xstar < Lcstarmax-Ltstarmax).*D1starmax + ((xstar <= Lcstarmax) & (xstar >= (Lcstarmax-Ltstarmax))).*Dtstarmax;
% % Dstarmin = Dstarmin';
% % Dstarmax = Dstarmax';

% % hstarmin = Dstarmin.^(1/3);
% % hstarmax = Dstarmax.^(1/3);
% % Tthinmin = hstarmin(end)-hstarmin;
% % Tthinmax = hstarmax(end)-hstarmax;

% % % MeanOverSummit = 0.6;
% % Hmin = (Wtstarmin - xstar > 0).*(Wtstarmin - xstar).*tan(smin.*pi./180);
% % Hmax = (Wtstarmax - xstar > 0).*(Wtstarmax - xstar).*tan(smax.*pi./180);
% % % maxHeightmin = Hmin(1).*MeanOverSummit;
% % % maxHeightmax = Hmax(1).*MeanOverSummit;
% % % Hmin(Hmin > maxHeightmin) = maxHeightmin;
% % % Hmax(Hmax > maxHeightmax) = maxHeightmax;
% % Fmin = Hmin(1).*Wtstarmin.*dxstar./2;
% % Fmax = Hmax(1).*Wtstarmax.*dxstar./2;
% % Hmin = Hmin'./Fmin;
% % Hmax = Hmax'./Fmax;

% % % isostatic deflection
% % T2star_Fun = @(T2,F,rho_s,rho_c) 2.*T2./F.*(1-rho_s./rho_c);
% % Istar_Fun = @(T2star,hstar) T2star.*(1-hstar);
% % 
% % T2starmin = T2star_Fun(T2min,H(1),rho_smax,rho_cmin);
% % T2starmax = T2star_Fun(T2max,Fmax,rho_smin,rho_cmax);
% % 
% % Istarmin = Istar_Fun(T2starmin,hstarmax);
% % Istarmax = Istar_Fun(T2starmax,hstarmin);