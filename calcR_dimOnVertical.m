function R = calcR_dimOnVertical(dxstar,Dstar,rho_star,H,w)

% extend for reflective boundary conditions
wdiff = [w(3); w(2); w; 0; 0];
Dstar = [Dstar(2); Dstar; Dstar(end)];

% finite diff for 2nd derivative
d2wdx2 = (wdiff(3:end) - 2.*wdiff(2:end-1) + wdiff(1:end-2)) ./ dxstar.^2;

% bending moment
M = -Dstar .* d2wdx2;

% take the second 2nd derivative
d2Mdx2 = (M(3:end) - 2.*M(2:end-1) + M(1:end-2)) ./ dxstar.^2;

% calculate the residual based on governing eqn
R = d2Mdx2 - 4.*w + 4.*rho_star.*H;

