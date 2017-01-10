dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 20; % number of data points

%Wtstar = linspace(dxstar,2000*dxstar,pt);
Wtstar = logspace(log10(1500*dxstar),log10(2700*dxstar),pt);
%Wtstar = 10;
WtstarFin = snapWtstar2Grid(dxstar,Wtstar);

%Dstar = ones(size(xstar))';

D1star = 0.001;
Lcstar = 21;
Ltstar = 2;
%Lcstar = 40;
%Ltstar = 40;
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

wavelen = zeros(1,pt);
amp = zeros(1,pt);
fbPos = zeros(1,pt);
fbHeight = zeros(1,pt);
antifbHeight = zeros(1,pt);
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
    %plot(xstar - WtstarFin(i),-wstar);
     ww = -wstar;
     [vmax,imax] = max(ww);
     [vmin,imin] = min(ww);
     amp(i) = vmax - vmin;
     wavelen(i) = xstar(imax) - xstar(imin);
     fbPos(i) = xstar(imax);
     fbHeight(i) = vmax;
     antifbHeight(i) = ww(1) - vmin;
     [vcross,icross] = min(abs(ww(1:imax)));
     zeroxing(i) = xstar(icross);
%     w(:,i) = -wstar.*w0(i);
    %plot(xstar,w);
end
%axis([-1,3,-3.5,0.2]); 
%grid on;

% axis([0,5,-inf,1]);
%xlabel('xstar - Wtstar'); ylabel('wstar'); title('Magallanes case'); 
% 
%figure; 
%subplot(2,2,1);

%figure;
%loglog(WtstarFin,wavelen,'.-'); axis tight;
%xlabel('Wtstar'); ylabel('wavelength'); title('Wtstar-wavelength'); grid on;
%yTick = [4.71 4.71 4.71]; set(gca,'yTickLabel',yTick);
% 
%subplot(2,2,2);
%figure;
%plot(WtstarFin,amp,'k.-'); grid on
%loglog(WtstarFin,amp,'.-'); grid on; axis tight
%xlabel('Wtstar'); ylabel('amplitute'); title('Wtstar-amplitutde'); 

%subplot(2,2,3); 
%figure;
loglog(WtstarFin,fbHeight,'.-'); grid on; axis tight
xlabel('Wtstar'); ylabel('Height of Forebulge'); title('Wtstar-forebulge height');
hold on;

%subplot(2,2,4); 
%plot(WtstarFin,zeroxing,'k.-'); grid on
loglog(WtstarFin,antifbHeight,'.-'); grid on; axis tight
xlabel('Wtstar'); ylabel('anti-forebulge height'); title('Wtstar-anti-forebulge height');
legend('forebulge','anti-forebulge');

% figure;
% % subplot(2,2,4); 
%plot(WtstarFin,zeroxing,'.-'); grid on
%loglog(WtstarFin,zeroxing,'.-'); grid on; axis tight
%xlabel('Wtstar'); ylabel('zero-crossing'); title('Wtstar-zero crossing of w curve');

