dxstar = 0.01;
xstar = 0:dxstar:20;

D1star = logspace(-3,0,20);
Wtstar = [0.5,0.7,1,2,5,10];
%Wtstar = [0.01,0.02,0.05,0.1,0.2,0.3,0.4];
%Wtstar = [0.01,0.5,1,2,3,10];

Lcstar = 5;
Ltstar = 5;

for j = 1:length(Wtstar)
    
    depth = zeros(size(D1star));
    width = zeros(size(D1star));
    
    Hstar = zeros(size(xstar))';
    Hstar(xstar < Wtstar(j)) = 1;
    F = sum(Hstar)*dxstar;
    Hstar = Hstar ./ F;
    test = sum(Hstar);
    
    for i = 1:length(D1star)
        Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
        wstar = solveW(dxstar,Dstar,Hstar);
        [depth(i),width(i)] = findDepthWidthofBasin(xstar,wstar,Wtstar(j));
    end
    
    loglog(D1star,depth)
    %loglog(D1star,width)
    hold on
    
end
grid on
title('Basin depth in relation to thinning ratio as thrust loading progresses')
%title('Basin width in relation to thinning ratio as thrust loading progresses')
xlabel('Thinning ratio D1*'); 
ylabel('Normalized basin depth');
%ylabel('Normalized basin width (in terms of alpha)');
legend(sprintf('Wt* = %0.2f',Wtstar(1)), sprintf('Wt* = %0.2f',Wtstar(2)),...
    sprintf('Wt* = %0.2f',Wtstar(3)), sprintf('Wt* = %0.2f',Wtstar(4)),...
    sprintf('Wt* = %0.2f',Wtstar(5)), sprintf('Wt* = %0.2f',Wtstar(6)),'Location','southeast');