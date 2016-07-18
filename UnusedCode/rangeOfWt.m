function [w,wavelen,amp,fbPos,fbHeight,zeroxing] = rangeOfWt(x,T1,T2,Lc,Lt,Wt,pt)
%square load
dx = x(2)-x(1);
[D1star,D2star,Lcstar,Ltstar,Wtstar] = dimToDimless(T1,T2,Lc,Lt,Wt);

wavelen = zeros(1,pt);
amp = zeros(1,pt);
fbPos = zeros(1,pt);
fbHeight = zeros(1,pt);
zeroxing = zeros(1,pt);
w = zeros(length(x),length(pt));

for i = 1:pt
    Dstar = (x > Lcstar).*D2star + (x < Lcstar - Ltstar).*D1star +...
        ((x <= Lcstar) & (x >= (Lcstar - Ltstar))).*...
        (((x - Lcstar).*(1 - D1star.^(1/3))./Ltstar + 1).^3);
    Dstar = Dstar';
    
    H = zeros(size(x));
    H(x <= Wtstar(i)) = 1./dx;
    F = 1.*Wtstar(i)./dx;
    H = H./F;
    H = H';
    plot(x,H);
    hold on
    
    w(:,i) = -solveW(dx,Dstar,H);
    ww = w(:,i);
    plot(x,ww);
    hold on
    [vmax,imax] = max(ww);
    [vmin,imin] = min(ww);
    amp(i) = -vmin;
    wavelen(i) = x(imax)-x(imin);
    fbPos(i) = x(imax);
    fbHeight(i) = vmax;
    [vcross,icross] = min(abs(ww(1:imax)));
    zeroxing(i) = x(icross);
end
end
