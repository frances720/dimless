dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 7; % number of data points

%Wtstar = linspace(2*dxstar,1000*dxstar,pt);
%Wtstar = logspace(log10(500*dxstar),log10(1500*dxstar),pt);
%Wtstar = 9:0.1:11;
Wtstar = 10;
WtstarFin = snapWtstar2Grid(dxstar,Wtstar);
Hstar = uniformHstar(xstar,WtstarFin);

D1star = logspace(-3,0,pt);
%Dstar = ones(size(xstar))';
%Dstar = ((1+0.01)/2.*ones(size(xstar)))';

for j = 1:length(D1star)
    
%     wavelen = zeros(1,pt);
%     amp = zeros(1,pt);
%     fbPos = zeros(1,pt);
%     fbHeight = zeros(1,pt);
%     antifbHeight = zeros(1,pt);
%     %zeroxing = zeros(1,pt);
%     %w = zeros(length(x),length(pt));
%     %w0 = zeros(1,pt);
%     w = zeros(length(xstar),pt);
    Ltstar = logspace(-2,log10(5),pt);
    %Ltstar = linspace(0.01,5,pt);
    figure;
    for i = 1:length(Ltstar)
        
        Lcstar = 10 + Ltstar(i) / 2;
        
        Dstar = computeDstar(xstar,D1star(j),Lcstar,Ltstar(i));
        %Hstar = uniformHstar(xstar,WtstarFin(i));
        % plot(xstar,Hstar);
        % w0(i) = calcw0(2900,3350,2600,F);
        wstar = solveW(dxstar,Dstar,Hstar);
        %plot(xstar,-wstar);
        plot(xstar - WtstarFin,-wstar);
        hold on;
%         ww = -wstar;
%         [vmax,imax] = max(ww);
%         [vmin,imin] = min(ww);
%         amp(i) = vmax - vmin;
%         wavelen(i) = xstar(imax) - xstar(imin);
%         fbPos(i) = xstar(imax);
%         fbHeight(i) = vmax;
%         antifbHeight(i) = ww(1) - vmin;
%         [vcross,icross] = min(abs(ww(1:imax)));
%         zeroxing(i) = xstar(icross);
        %     w(:,i) = -wstar.*w0(i);
        %plot(xstar,w);
    end
    axis([-4,4,-2.2,0.2]);
    grid on;
    
    % %grid on;
    %
    %axis([0,5,-inf,1]);
    xlabel('xstar normalized wrt Wtstar'); ylabel('wstar'); title(sprintf('D1* = %f, Wt* = 10', D1star(j)));
    legend(sprintf('Lt* = %f',Ltstar(1)),sprintf('Lt* = %f',Ltstar(2)),sprintf('Lt* = %f',Ltstar(3)),sprintf('Lt* = %f',Ltstar(4)),sprintf('Lt* = %f',Ltstar(5)),sprintf('Lt* = %f',Ltstar(6)),sprintf('Lt* = %f',Ltstar(7)),'Location','southeast');
end
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
