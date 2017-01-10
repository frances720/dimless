function w = solveW(dx,D,rho)
w = zeros(length(D),1);
R = calcR(dx,D,rho,w);
J = sparse(length(w),length(w));
for i = 1:length(w)
    J(:,i) = calcdRdw(dx,D,rho,i,w,R);
end
w = w - J'\R;
end