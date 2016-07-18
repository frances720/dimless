x = 0:0.01:20;
dx = x(2)-x(1);
% magallanes base case
g = 9.8;
T1 = 25e3;
T2 = 45e3;
Lc = 280e3;
Lt = 180e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2450;

pt = 20;
Wt = linspace(20e3,200e3,pt);

D2 = E.*T2.^3./(12.*(1-v.^2));
a = (4.*D2./((rho_m-rho_s).*g)).^(1/4);
Lcstar = Lc./a;
Ltstar = Lt./a;
D1star = (T1./T2).^3;
D2star = ones(1,pt);

Wt = Wt./a;

wave = zeros(1,pt);
amp = zeros(1,pt);
for i = 1:pt
    
    Dtstar = ((x-Lcstar).*(1-D1star.^(1/3))./Ltstar + 1).^3;
    Dstar = (x > Lcstar).*D2star(i) + (x < Lcstar-Ltstar).*D1star +...
        ((x <= Lcstar) & (x >= (Lcstar-Ltstar))).*Dtstar;
    Dstar = Dstar';
    
    % block load
    H = zeros(size(x));
    H(x <= Wt(i)) = 1;
    F = 1*Wt(i);
    H = H./F./dx;
    H = H';
    plot(x,H);
    hold on
    
    w = solveW(dx,Dstar,H);
    w = -w;
    amp(i) = w(1);
    [vmax,imax] = max(w);
    [vmin,imin] = min(w);
    wave(i) = x(imax)-x(imin);
    plot(x,w);
    hold on
end
axis([0,5,-inf,inf]);
% figure;
% plot(Wt,amp);
% title('advancing thrust belt with maximum subsidence');
% figure;
% plot(Wt,wave);
% title('advancing thrust belt with flexural wavelength');