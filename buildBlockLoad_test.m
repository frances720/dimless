function [Hstar,F] = buildBlockLoad_test(xstar,dxstar,Wtstar,Hmax)
H = zeros(size(xstar));

% QC CHECK - try for dimensional space for calculating F
T2 = 40e3;
rho_m = 3400;
rho_s = 2200;

E = 70e9;
v = 0.25;
g = 9.8;
D2 = E.*T2.^3./(12.*(1-v.^2));
a = (4.*D2./((rho_m-rho_s).*g)).^(1/4);
Wt = Wtstar.*a;
% END QC CHECK

H(xstar < Wtstar) = Hmax;
%F = Hmax*WtstarFin;
F = Hmax * (Wtstar / dxstar);

% QC CHECK -- what are these values?
% Hmax
% WtstarFin
%pause
% END QC CHECK

Hstar = H./F;
Hstar = Hstar';
end