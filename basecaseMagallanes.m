dxstar = 0.01;
xstar = 0:dxstar:20;

[D1star, Wtstar, Lcstar, Ltstar] = dim2Dimless(20,40,360,260,70);
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
Hstar = buildBlockLoad(xstar,dxstar,Wtstar);
wstar = solveW(dxstar,Dstar,Hstar);

plot(xstar,-wstar);
hold on;
Dstar = ones(size(xstar))';
wstar = solveW(dxstar,Dstar,Hstar);
plot(xstar,-wstar);

axis([0,8,-3,0.5])
sea = zeros(size(xstar))';
plot(xstar,sea,'k--');
xlabel('xstar');ylabel('wstar');title('Magallanes basecase vs. benchmark case');
legend('Magallanes','benchmark');

%plot(xstar,Hstar);