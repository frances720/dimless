dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 10; % number of data points

%Wtstar = linspace(dxstar,2000*dxstar,pt);
%Wtstar = logspace(log10(dxstar),log10(2000*dxstar),pt);
Wtstar = 10;

D1star = logspace(log10(1e-2),log10(100),pt);
%wavelen = zeros(1,pt);
%amp = zeros(1,pt);
%fbPos = zeros(1,pt);
%fbHeight = zeros(1,pt);
%zeroxing = zeros(1,pt);
%w = zeros(length(x),length(pt));
%w0 = zeros(1,pt);
%w = zeros(length(xstar),pt);

ratio = zeros(1,pt);
tiespot_xstar = zeros(1,pt);
tiespot_wstar = zeros(1,pt);

for i = 1:pt
    Hstar = buildBlockLoad(xstar,dxstar,Wtstar);
    Dstar = D1star(i).*ones(size(xstar))';
    % plot(xstar,Hstar);
    % w0(i) = calcw0(2900,3350,2600,F);
    
    hold on
    wstar = solveW(dxstar,Dstar,Hstar);
    plot(xstar,-wstar);
    ww = -wstar;
    [vmax,imax] = max(ww);
    [vmin,imin] = min(ww);
    tiespot = round(imin + (imax - imin) / 2);
    tiespot_xstar(i) = xstar(tiespot);
    tiespot_wstar(i) = wstar(tiespot);
    amp = (vmax - vmin) / 2;
    wavelen = (xstar(imax) - xstar(imin))*2;
    ratio(i) = wavelen / amp;
    %     fbPos(i) = xstar(imax);
    %     fbHeight(i) = vmax;
    %     [vcross,icross] = min(abs(ww(1:imax)));
    %     zeroxing(i) = xstar(icross);
    %     w(:,i) = -wstar.*w0(i);
    %plot(xstar,w);
end
xlabel('xstar'); ylabel('wstar');
figure;
loglog(D1star,ratio,'k.-');
grid on;
xlabel('Dstar'); ylabel('Wavelength / Amplitutde');
