dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 7; % number of data points

Wtstar = 10;
WtstarFin = snapWtstar2Grid(dxstar,Wtstar);
Hstar = uniformHstar(xstar,WtstarFin);

%D1star = linspace(0.001,1,20);
D1star = logspace(-3,0,30);
%Dstar = ones(size(xstar))';
%Dstar = ((1+0.01)/2.*ones(size(xstar)))';
% RMS = zeros(length(D1star),pt);
wavelen = zeros(length(D1star),pt);
% anteWavelen = zeros(length(D1star),pt);
% postWavelen = zeros(length(D1star),pt);

for j = 1:length(D1star)
    
    Dstar_bench = ones(size(xstar))';
    wstar_bench = solveW(dxstar,Dstar_bench,Hstar);
%     wavelen = zeros(1,pt);
%     amp = zeros(1,pt);
%     fbPos = zeros(1,pt);
%     fbHeight = zeros(1,pt);
%     antifbHeight = zeros(1,pt);
%     %zeroxing = zeros(1,pt);
%     %w = zeros(length(x),length(pt));
%     %w0 = zeros(1,pt);
%     w = zeros(length(xstar),pt);
    %Ltstar = logspace(-2,log10(5),pt);
    Ltstar = linspace(0.01,5,pt);
    for i = 1:length(Ltstar)
        
        Lcstar = 10 + Ltstar(i) / 2;
        
        Dstar = computeDstar(xstar,D1star(j),Lcstar,Ltstar(i));
        %Hstar = uniformHstar(xstar,WtstarFin(i));
        % plot(xstar,Hstar);
        % w0(i) = calcw0(2900,3350,2600,F);
        wstar = solveW(dxstar,Dstar,Hstar);
        ww = -wstar;
        [vmax,imax] = max(ww);
        [vcross,icross] = min(abs(ww(1:imax)));
        wavelen(j,i) = xstar(icross);
        
%         RMS(j,i) = findRMS(wstar, wstar_bench);
%         wavelen(j,i) = findWavelen(dxstar, wstar);
%         anteWavelen(j,i) = findAnteWavelen(dxstar, wstar);
%         postWavelen(j,i) = findPostWavelen(dxstar, wstar);
        %plot(xstar,-wstar);
        %plot(xstar - WtstarFin,-wstar);
        %hold on;
    end
end
for i = 1:pt
        %plot(D1star,RMS(:,i));
        plot(D1star,wavelen(:,i));
        %plot(D1star,anteWavelen(:,i));
        %plot(D1star,postWavelen(:,i));
        hold on
end
hold off
xlabel('D1star'); 
%ylabel('RMS');
ylabel('Wavelength');
%ylabel('Ante-Wavelength');
%ylabel('Post-Wavelength');
title(sprintf('Wt* = %d, Lt* (lin) = %0.2f ~ %0.1f, D1* (log) = %0.3f ~ %0.1f', WtstarFin,Ltstar(1),Ltstar(end),D1star(1),D1star(end)));
legend(sprintf('Lt* = %f',Ltstar(1)),sprintf('Lt* = %f',Ltstar(2)),sprintf('Lt* = %f',Ltstar(3)),sprintf('Lt* = %f',Ltstar(4)),sprintf('Lt* = %f',Ltstar(5)),sprintf('Lt* = %f',Ltstar(6)),sprintf('Lt* = %f',Ltstar(7)),'Location','southeast');
grid on


% %
% %figure;
% %subplot(2,2,1);
%
%figure;
%loglog(WtstarFin,wavelen,'.-'); axis tight;
%xlabel('Wtstar'); ylabel('wavelength'); title('Wtstar-wavelength'); grid on;
%hold on
% %yTick = [4.71 4.71 4.71]; set(gca,'yTickLabel',yTick);
% %
% %subplot(2,2,2);
% %figure;
% %plot(WtstarFin,amp,'k.-'); grid on
% %loglog(WtstarFin,amp,'.-'); grid on; axis tight
% %xlabel('Wtstar'); ylabel('amplitute'); title('Wtstar-amplitutde');
%
% %subplot(2,2,3);
% %figure;
%loglog(WtstarFin,fbHeight,'.-'); grid on; axis tight
% xlabel('Wtstar'); ylabel('Height of Forebulge'); title('Wtstar-forebulge height');
%hold on;
%
% %subplot(2,2,4);
% %plot(WtstarFin,zeroxing,'k.-'); grid on
%loglog(WtstarFin,antifbHeight,'.-'); grid on; axis tight
%hold on;
% xlabel('Wtstar'); ylabel('anti-forebulge height'); title('Wtstar-anti-forebulge height');
% legend('forebulge','anti-forebulge');
%
% % figure;
% % % subplot(2,2,4);
% %plot(WtstarFin,zeroxing,'.-'); grid on
% %loglog(WtstarFin,zeroxing,'.-'); grid on; axis tight
% %xlabel('Wtstar'); ylabel('zero-crossing'); title('Wtstar-zero crossing of w curve');
