function w = stress_solveW(dx,D,H)
w = zeros(length(D),1);
R = stress_calcR(dx,D,H,w);
J = sparse(length(w),length(w));
for i = 1:length(w)
    J(:,i) = stress_calcdRdw(dx,D,H,i,w,R);
end
w = w - J'\R;
end