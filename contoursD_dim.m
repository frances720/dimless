% horizontal dimless model
dxstar = 0.01;
xstar = 0:dxstar:20;

% beam properties
D1star = ones(size(xstar));
Te = linspace(4,70,100) * 1e3;

% load properties
Wtstar = logspace(log10(1),log10(3),4);
H = zeros(size(xstar))';
height = 3e3;

ratio = zeros(length(Te),length(Wtstar));

% dimensional values
rho_c = 2700;
rho_m = 3300;
rho_s = 2400;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

E = 70e9;
v = 0.25;

D = calcD(Te,E,v);
alpha = calcAlpha(D,rho_m,rho_s);

for j = 1:length(Wtstar)
    
    % build block load
    H(xstar < Wtstar(j)) = height;
    
    for i = 1:length(Te)
        
        % solve for the dimless deflection
        w = solveW_dimOnVertical(dxstar,Dstar,rho_star,H);
        
        % find dimless depth/width ratio
        [depth,widthstar] = findDepthWidthofBasin(xstar,w,Wtstar(j));
        
        ratio(i,j) = (-depth/widthstar) / alpha(i);
    end
end

figure;
for k = 1:length(Wtstar)
   loglog(ratio(:,k),D)
   hold on
end
xlabel('log scaled depth to width ratio')
ylabel('log scaled rigidity')
legend(sprintf('Wt* = %.1f',Wtstar(1)), sprintf('Wt* = %.1f',Wtstar(2)),...
    sprintf('Wt* = %.1f',Wtstar(3)), sprintf('Wt* = %.1f',Wtstar(4)));
axis([1e-3,1e0,1e20,1e25]);
grid on

