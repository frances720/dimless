dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 7; % number of data points

%Wtstar = linspace(2*dxstar,1000*dxstar,pt);
%Wtstar = logspace(log10(500*dxstar),log10(1500*dxstar),pt);
Wtstar = 6:0.2:14;
%Wtstar = 10;
WtstarFin = snapWtstar2Grid(dxstar,Wtstar);
RMS = zeros(length(WtstarFin),pt);
wavelen = zeros(length(WtstarFin),pt);
anteWavelen = zeros(length(WtstarFin),pt);
postWavelen = zeros(length(WtstarFin),pt);

for j = 1:length(WtstarFin)
    Hstar = uniformHstar(xstar,WtstarFin(j));
    
    Dstar_bench = ones(size(xstar))';
    wstar_bench = solveW(dxstar,Dstar_bench,Hstar);
    %Dstar = ((1+0.01)/2.*ones(size(xstar)))';
    
    D1star = logspace(-2,0,pt);
    %D1star = 0.1;
    Lcstar = 10.5;
    Ltstar = 1;
    
%     wavelen = zeros(1,pt);
%     amp = zeros(1,pt);
%     fbPos = zeros(1,pt);
%     fbHeight = zeros(1,pt);
%     antifbHeight = zeros(1,pt);
%     %zeroxing = zeros(1,pt);
%     %w = zeros(length(x),length(pt));
%     %w0 = zeros(1,pt);
%     w = zeros(length(xstar),pt);
    
    %figure;
    for i = 1:pt
        Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
        %Hstar = uniformHstar(xstar,WtstarFin(i));
        % plot(xstar,Hstar);
        % w0(i) = calcw0(2900,3350,2600,F);
        wstar = solveW(dxstar,Dstar,Hstar);
        RMS(j,i) = findRMS(wstar, wstar_bench);
        wavelen(j,i) = findWavelen(dxstar, wstar);
        anteWavelen(j,i) = findAnteWavelen(dxstar, wstar, WtstarFin(j));
        postWavelen(j,i) = findPostWavelen(dxstar, wstar, WtstarFin(j));
        %plot(xstar,-wstar);
        %plot(xstar - WtstarFin(j),-wstar);
        %hold on;
    end
    %axis([-4,4,-2.2,0.2]);
    %grid on;
    
    % %grid on;
    %
    % % axis([0,5,-inf,1]);
    %xlabel('xstar normalized wrt Wtstar'); ylabel('wstar'); title(sprintf('Wt* = %0.1f, Lt* = %d, Lc* = %0.1f', WtstarFin(j), Ltstar, Lcstar));
    %legend(sprintf('D1* = %f',D1star(1)),sprintf('D1* = %f',D1star(2)),sprintf('D1* = %f',D1star(3)),sprintf('D1* = %f',D1star(4)),sprintf('D1* = %f',D1star(5)),'Location','southeast');
end
for i = 1:pt
        %plot(WtstarFin,RMS(:,i));
        %plot(WtstarFin,wavelen(:,i));
        plot(WtstarFin,anteWavelen(:,i));
        %plot(WtstarFin,postWavelen(:,i));
        hold on
end
hold off
xlabel('Wtstar'); 
%ylabel('RMS');
%ylabel('Wavelength');
ylabel('Ante-Wavelength');
%ylabel('Post-Wavelength');
title(sprintf('Wt* (lin) = %0.1f~%0.1f, D1* (log) = %0.2f~%0.2f, Lt* = %d, Lc* = %0.1f', WtstarFin(1),WtstarFin(end),D1star(1),D1star(end), Ltstar, Lcstar));
legend(sprintf('D1* = %f',D1star(1)),sprintf('D1* = %f',D1star(2)),sprintf('D1* = %f',D1star(3)),sprintf('D1* = %f',D1star(4)),sprintf('D1* = %f',D1star(5)),sprintf('D1* = %f',D1star(6)),sprintf('D1* = %f',D1star(7)),'Location','southeast');

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
