function w = solveW(dx,D,H)
w = zeros(length(D),1);
R = calcR(dx,D,H,w);
J = sparse(length(w),length(w));
for i = 1:length(w)
    J(:,i) = calcdRdw(dx,D,H,i,w,R);
end
w = w - J'\R;
end