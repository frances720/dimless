function w = solveW_dimOnVertical(dxstar,Dstar,rho_star,H)

w = zeros(length(Dstar),1);

% calc residuals
R = calcR_dimOnVertical(dxstar,Dstar,rho_star,H,w);
J = sparse(length(w),length(w));

% populate jacobian matrix
for i = 1:length(w)
    J(:,i) = calcdRdw_dimOnVertical(dxstar,Dstar,rho_star,H,i,w,R);
end
w = w - J'\R;
end