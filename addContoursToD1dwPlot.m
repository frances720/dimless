% horizontal dimless model
dxstar = 0.01;
xstar = 0:dxstar:20;

% dimless beam properties
Lcstar = 4;
Ltstar = 2;
D1star = logspace(-3,0,10);

% load properties
Wtstar = 0.1:0.1:0.5;
H = zeros(size(xstar))';
height = 3e3;

ratio = zeros(length(D1star),length(Wtstar));

% dimensional values
rho_c = 2700;
rho_m = 3300;
rho_s = 2400;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

E = 70e9;
v = 0.25;

% elastic thickness of distal plate
T2 = 10e3;

D = calcD(T2,E,v);
alpha = calcAlpha(D,rho_m,rho_s);

for j = 1:length(Wtstar)
    
    % build block load
    H(xstar < Wtstar(j)) = height;
    
    for i = 1:length(D1star)
        
        % build dimless beam with varying Dstar
        Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
        
        % solve for the dimless deflection
        w = solveW_dimOnVertical(dxstar,Dstar,rho_star,H);
        
        % find dimless depth/width ratio
        [depth,widthstar] = findDepthWidthofBasin(xstar,w,Wtstar(j));
        
        ratio(i,j) = (-depth/widthstar) / alpha;
    end
end

 figure;
for k = 1:length(Wtstar)
   plot(ratio(:,k),D1star)
   hold on
end
hold on

load('ratioFromBasin.mat');
load('D1starFromBasin.mat');
load('labels.mat');
scatter(ratioFromBasin,D1starFromBasin);
text(ratioFromBasin, D1starFromBasin + 0.02, labels)
axis([0,0.12,0,1]);
xlabel('basin depth/width (km)');
ylabel('D1star');