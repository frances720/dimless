x = 0:10:2000; % nodes on x-axis
%T1 = 20:5:50; % elastic thickness of proximal segment of plate (km)
T1 = 15;
T2 = 20; % elastic thickness of distal segment of plate (km)
Lc = 280; % length of proximal plate segment (km)
Lt = 180; % length of transition between proximal and distal segments (km)

S = 5; % surface slope of the thrust belt (degrees)
g = 9.8; % gravity acceleration (m/s^2)
v = 0.25; % poison's ratio
E = 70; % Young's Modulus (GPa)
rho_s = 2450; % density of sediments (kg/m^3)
rho_c = 2800; % density of crust (kg/m^3)
rho_m = 3300; % density of mantle (kg/m^3)
rho_w = 1030; % density of water (kg/m^3)

Hmax = 4; % maximum height of the thrust belt (km)
Wt = 70; % width of thrust belt (km)
Ww = Hmax ./ tan(S.*pi./180); % width of the slope of thrust belt (km)
Wp = Wt - Ww; % width of plateau (km)

figure; hold on;

%for i = 1:length(Lc)
    [w,D,a,wo,wb,Hthick] = calcDeflections(x,rho_m,rho_c,rho_w,rho_s,E,v,g,Hmax,T1,T2,Lc,Lt,S,Wt,'Airy');
    x = x.*1e3;
    w0 = 7.1939*1e3; % calculated using point load
    plot(x./a',-w./w0);
    %plot(x./a',-w./wo);
    %plot(x./a',-w./w(1));
    %plot(x,-w);
    %plot(x,-w./(E(i)*1e9));
%end

% plot the surface and the calculated deflections
%plot(x./a',Hthick./wo);
plot(x./a',Hthick./w0);
%plot(x,Hthick);
axis([0 7 -inf inf]);
%axis([0 700 -inf inf]);
%plot(x,D);


