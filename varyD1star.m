%function varyingD1star(Lcstar,Ltstar)
dxstar = 0.01;
xstar = 0:dxstar:20;

pt = 20; % number of data points 

%D1star = linspace(1e-3,1,pt);
D1star = logspace(-3,0,pt);
Hstar = buildBlockLoad(xstar,dxstar,10);
%Hstar = buildLineLoad(xstar);
Lcstar = 11;
Ltstar = 2;


wavelen = zeros(1,pt);
amp = zeros(1,pt);
%fbPos = zeros(1,pt);
%fbHeight = zeros(1,pt);
%zeroxing = zeros(1,pt);
%w = zeros(length(x),length(pt));
%w0 = zeros(1,pt);
%wstar = zeros(length(xstar),pt);

for i = 1:pt
    %Dstar = ones(size(xstar))';
    %Dstar = D1star(i).*ones(size(xstar))';
    Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
    % plot(xstar,Hstar);
    % w0(i) = calcw0(2900,3350,2600,F);

    hold on
    wstar = solveW(dxstar,Dstar,Hstar);
    plot(xstar,-wstar);
     ww = -wstar;
     [vmax,imax] = max(ww);
     [vmin,imin] = min(ww);
     amp(i) = -vmin;
     wavelen(i) = xstar(imax)-xstar(imin);
%     fbPos(i) = xstar(imax);
     %fbHeight(i) = vmax;
     %[vcross,icross] = min(abs(ww(1:imax)));
     %zeroxing(i) = xstar(icross);
%     w(:,i) = -wstar.*w0(i);
    %plot(xstar,w);
end
%axis([0,10,-inf,3]);
figure;
% axis([0,5,-inf,1]);
% xlabel('xstar'); ylabel('wstar'); title('full range of Wtstar')
% 
% figure; subplot(2,2,1); title('Wtstar-forebulge position'); hold on; grid on
% plot(Wtstar,fbPos); xlabel('Wtstar'); ylabel('Forebulge Position on xstar');
% 
% subplot(2,2,2);
%figure;
%plot(D1star,amp,'k.-'); grid on
loglog(D1star,wavelen,'k.-'); 
%hold on
grid on; 
xlabel('D1star'); ylabel('w0star (amplitude)'); title('D1star-amplitutde');

% subplot(2,2,3); 
% plot(Wtstar,fbHeight); grid on
%loglog(D1star,fbHeight); hold on
%xlabel('D1star'); ylabel('Height of Forebulge'); title('D1star-forebulge height');
% 
% subplot(2,2,4); 
%plot(D1star,zeroxing,'k.-'); grid on
%loglog(D1star,zeroxing,'k.-'); grid on
%xlabel('D1star'); ylabel('xstar Position of where wstar is closest to 0'); title('D1star-zero crossing of w curve');
