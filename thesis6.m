dxstar = 0.01;
xstar = 0:dxstar:20;

D1star = logspace(-2,0,7);
%D1star = linspace(dxstar,1,7);
Wtstar = 5;

Lcstar = 20;
Ltstar = 20;

Hstar = zeros(size(xstar))';
Hstar(xstar < Wtstar) = 1;
%     F = sum(Hstar)*dxstar;
%     Hstar = Hstar ./ F;
%     test = sum(Hstar);
figure;
for i = 1:length(D1star)
    Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
    wstar = -solveW(dxstar,Dstar,Hstar);
    plot(xstar,wstar);
    hold on
end

plot(xstar,Hstar,'k--');
axis([Wtstar-1,Wtstar+3,-1.1,1.05]);

%title('Basin depth in relation to thinning ratio as thrust loading progresses')
% title('Basin width in relation to thinning ratio as thrust loading progresses')
xlabel('Dimensionless distance across basin');
ylabel('Normalized basin depth');
% ylabel('Normalized basin width (in terms of alpha)');
legend(sprintf('D1* = %0.2f',D1star(1)), sprintf('D1* = %0.2f',D1star(2)),...
    sprintf('D1* = %0.2f',D1star(3)), sprintf('D1* = %0.2f',D1star(4)),...
    sprintf('D1* = %0.2f',D1star(5)), sprintf('D1* = %0.2f',D1star(6)),...
    sprintf('D1* = %0.2f',D1star(7)),'Location','northeast');