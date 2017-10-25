%% case varying D
dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 48e3;
T2 = 55e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2400;
rho_c = 2650;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

Lc = 550e3;
Lt = 250e3;

D1star = (T1./T2).^3;
D2 = calcD(T2,E,v);
alpha = calcAlpha(D2,rho_m,rho_s);
Lcstar = Lc/alpha;
Ltstar = Lt/alpha;

Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

Wt = 300e3;
Wtstar = Wt/alpha;

H = zeros(size(xstar))';
H(xstar <= Wtstar) = 2e3;

w = solveW_dimOnVertical(dxstar,Dstar,rho_star,H);

plot(xstar*alpha/1e3,-w/1e3);
hold on

%% case uniform with T1
D1 = calcD(T1,E,v);
alpha2 = calcAlpha(D1,rho_m,rho_s);

Wtstar2 = Wt/alpha2;

H2 = zeros(size(xstar))';
H2(xstar <= Wtstar2) = 2e3;
F2 = sum(H2);
Hstar2 = H2 ./ F2;
w02 = calcw0(rho_c,rho_m,rho_s,F2);
wstar2 = - solveW(dxstar,Dstar,Hstar2);
w2 = wstar2*w02;
plot(xstar*alpha2/1e3, w2/1e3);

RMS = findRMS(w2,-w);
[forebulge,forebulgeind] = min(w);
[zeroxing,zeroxingind] = min(abs(w(1:forebulgeind)));
basinArea = sum(abs(w(1:zeroxingind)));
RMS = RMS/basinArea;

%% plot things
axis([250,650,-4.5,2.1])
plot(xstar*alpha/1e3,H/1e3,'k:')
sea = zeros(size(xstar))';
plot(xstar*alpha/1e3,sea,'k--');
xlabel('Distance across basin (km)');ylabel('Deflection (km)');title('Comparison of updated and classical model for Chaco Basin');
legend('varying EET model: T1=48km, T2=55km','uniform beam:         Te=48km ( D=7E23 )');