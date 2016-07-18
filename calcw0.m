% for benchmarking wstar to dimensional space
% checking airy isostasy
function w0 = calcw0(rho_c,rho_m,rho_s,F)
w0 = rho_c*F/(2*(rho_m-rho_s));