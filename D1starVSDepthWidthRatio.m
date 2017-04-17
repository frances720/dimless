% dimless model base
dxstar = 0.01;
xstar = 0:dxstar:20;

% dimless beam properties
Lcstar = 4;
Ltstar = 2;
D1star = logspace(-3,0,20);

% dimless load properties
Wtstar = 3:0.5:5;
Hstar = zeros(size(xstar))';

ratio = zeros(length(D1star),length(Wtstar));

% dimensional values for w0 and alpha
rho_c = 2700;
rho_m = 3300;
rho_s = 2400;
E = 70e9;
v = 0.25;

% elastic thickness of distal plate
T2 = 20e3;

D = calcD(T2,E,v);
alpha = calcAlpha(D,rho_m,rho_s);

for j = 1:length(Wtstar)
    
    % build dimless block load
    Hstar(xstar < Wtstar(j)) = 2e3;
    F = sum(Hstar) * dxstar;
    Hstar = Hstar ./ F;
    
    for i = 1:length(D1star)
        
        % build dimless beam with varying Dstar
        Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
        
        % solve for the dimless deflection
        wstar = solveW(dxstar,Dstar,Hstar);
        
        % find dimless depth/width ratio
        [depthstar,widthstar] = findDepthWidthofBasin(xstar,wstar,Wtstar(j));
        
        deltaT = calcdeltaT(D1star(i),T2);
        w0 = calcw0(rho_c,rho_m,rho_s,deltaT);
        
        ratio(i,j) = (-depthstar/widthstar) * (w0/alpha);
    end
end



 figure;
for k = 1:length(Wtstar)
   plot(ratio(:,k),D1star)
   hold on
end
hold on
scatter(ratioFromBasin,D1starFromBasin);
text(ratioFromBasin, D1starFromBasin + 0.02, labels)