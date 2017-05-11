% horizontal dimless model
dxstar = 0.01;
xstar = 0:dxstar:20;

% beam properties
D1star = ones(size(xstar));
Te = linspace(4,70,100) * 1e3;

% load properties
Wtstar = 1;
H = zeros(size(xstar))';
height = (1:1:5)*1e3;

ratio = zeros(length(Te),length(height));

% dimensional values
rho_c = 2700;
rho_m = 3300;
rho_s = 2400;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

E = 70e9;
v = 0.25;

D = calcD(Te,E,v);
alpha = calcAlpha(D,rho_m,rho_s);

for j = 1:length(height)
    
    % build block load
    H(xstar < Wtstar) = height(j);
    
    for i = 1:length(Te)
        
        % solve for the dimless deflection
        w = solveW_dimOnVertical(dxstar,Dstar,rho_star,H);
        
        % find dimless depth/width ratio
        [depth,widthstar] = findDepthWidthofBasin(xstar,w,Wtstar);
        
        ratio(i,j) = (-depth/widthstar) / alpha(i);
    end
end

figure;
for k = 1:length(height)
   loglog(ratio(:,k),D)
   hold on
end
xlabel('log scaled depth to width ratio')
ylabel('log scaled rigidity')
heightkm = height ./ 1e3;
legend(sprintf('height = %d km',heightkm(1)), sprintf('height = %d km',heightkm(2)),...
    sprintf('height = %d km',heightkm(3)), sprintf('height = %d km',heightkm(4)),...
    sprintf('height = %d km',heightkm(5)));
axis([1e-3,1e0,1e20,1e25]);
grid on
title('contours with different elevation for Wt* = 1')

