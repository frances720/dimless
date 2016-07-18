x = 0:0.01:30;
Wtspan = [10e3,300e3];
pt = 20;
Wt = linspace(Wtspan(1),Wtspan(2),pt);

T1 = 15e3;
T2 = 45e3;
Lc = 260e3;
Lt = 260e3;

[w,wavelen,amp,fbPos,fbHeight,zeroxing] = rangeOfWt(x,T1,T2,Lc,Lt,Wt,20);

axis([0,5,-inf,5]);
xlabel('x'); ylabel('w'); title('T1 = 45km, T2 = 45km, Lc = 260km, Lt = 160km');

figure; subplot(2,2,1); title('Wt-forebulge position'); hold on
plot(Wt,fbPos); xlabel('Wt (10km-300km)'); ylabel('Forebulge Position on x');

subplot(2,2,2);
plot(Wt,amp); 
xlabel('Wt (10km-300km)'); ylabel('w0 (amplitude)'); title('Wt-amplitutde');

subplot(2,2,3); 
plot(Wt,fbHeight); 
xlabel('Wt (10km-300km)'); ylabel('Height of Forebulge'); title('Wt-forebulge height');

subplot(2,2,4); 
plot(Wt,zeroxing); 
xlabel('Wt (10km-300km)'); ylabel('x Position of where w is closest to 0'); title('Wt-zero crossing of w curve');

% figure; title('Wt-wavelength');
% plot(Wt,wavelen); xlabel('Wt (10km-300km)'); ylabel('Wavelength (trough-peak)');

