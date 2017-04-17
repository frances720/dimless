% automatically finding the optimal D1* for the deflection profile


% input variables
Wt = 700e3;
H = 2e3;
basinWidth = 300e3;
Lc = basinWidth + Wt;
Lt = basinWidth;

% dimensionless setup
dx = 10;
modelEnd = (Wt + basinWidth) * 2 / 1e3;
x = 0:dx:modelEnd;

% model parameters
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2400;
rho_c = 2700;

% loading deflection data
w_pts = load('JordanWestLoad.csv');

% pinning curve postion according to basin width
w_interp = zeros(size(x))';
extent = max(w_pts(:,1));
endind = round(extent);
w_interp(1:endind) = interp1(w_pts(:,1),w_pts(:,2),x(1:endind));

%



