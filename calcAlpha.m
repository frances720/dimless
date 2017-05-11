function alpha = calcAlpha(D,rho_m,rho_s)
g = 9.8;
alpha = (4.*D./((rho_m-rho_s).*g)).^(1/4);