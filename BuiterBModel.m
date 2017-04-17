% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;

D1star = logspace(-3,0,10);
T2 = 15e3; 

E = 100e9;
v = 0.25;
D = calcD(T2,E,v);

rho_c = 2800;
rho_m = 3250;
rho_s = 2300;

alpha = calcAlpha(D,rho_m,rho_s);
Lcstar = 260e3/alpha;
Ltstar = 90e3/alpha;
Wt = 170e3;
Wtstar = Wt/alpha;

H = zeros(size(xstar))';
H(xstar < Wtstar) = 3e3;
F = sum(H) * dxstar;
Hstar = H ./ F;

x = xstar .* alpha ./1000;
w0 = calcw0(rho_c,rho_m,rho_s,F);

RMS = zeros(size(D1star));

for i = 1:length(D1star)
    Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
    wstar = solveW(dxstar,Dstar,Hstar);
    w = -wstar .* w0 ./ 1000;
    RMS(i) = fitToMeasuredPts(BuiterB,x,w);
end

figure;
plot(D1star,RMS);