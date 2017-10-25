dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 100; % number of data points

%Wtstar = linspace(dxstar,2000*dxstar,pt);
Wtstar = logspace(log10(dxstar),log10(2000*dxstar),pt);
%Wtstar = 10;
WtstarFin = snapWtstar2Grid(dxstar,Wtstar);

Dstar = ones(size(xstar))';

%wavelen = zeros(1,pt);
amp = zeros(1,pt);
%fbPos = zeros(1,pt);
%fbHeight = zeros(1,pt);
%zeroxing = zeros(1,pt);
%w = zeros(length(x),length(pt));
%w0 = zeros(1,pt);
w = zeros(length(xstar),pt);


for i = 1:length(Wtstar)
    Hstar = buildBlockLoad(xstar,dxstar,WtstarFin(i));
    % plot(xstar,Hstar);
    % w0(i) = calcw0(2900,3350,2600,F);

    %hold on
    wstar = solveW(dxstar,Dstar,Hstar);
    %plot(xstar,-wstar);
     ww = -wstar;
%     [vmax,imax] = max(ww);
     [vmin,imin] = min(ww);
     amp(i) = -vmin;
%     wavelen(i) = xstar(imax)-xstar(imin);
%     fbPos(i) = xstar(imax);
%     fbHeight(i) = vmax;
%     [vcross,icross] = min(abs(ww(1:imax)));
%     zeroxing(i) = xstar(icross);
%     w(:,i) = -wstar.*w0(i);
    %plot(xstar,w);
end
%axis([0,10,-inf,3]);

% axis([0,5,-inf,1]);
% xlabel('xstar'); ylabel('wstar'); title('full range of Wtstar')
% 
% figure; subplot(2,2,1); title('Wtstar-forebulge position'); hold on; grid on
% plot(Wtstar,fbPos); xlabel('Wtstar'); ylabel('Forebulge Position on xstar');
% 
% subplot(2,2,2);
%figure;
%plot(WtstarFin,amp,'k.-'); grid on
loglog(WtstarFin,amp,'k.-'); grid on
%xlabel('Wtstar'); ylabel('w0star (amplitude)'); title('Wtstar-amplitutde');

% subplot(2,2,3); 
% plot(Wtstar,fbHeight); grid on
% xlabel('Wtstar'); ylabel('Height of Forebulge'); title('Wtstar-forebulge height');
% 
% subplot(2,2,4); 
%plot(WtstarFin,zeroxing,'k.-'); grid on
%loglog(WtstarFin,zeroxing,'k.-'); grid on
%xlabel('Wtstar'); ylabel('xstar Position of where wstar is closest to 0'); title('Wtstar-zero crossing of w curve');

