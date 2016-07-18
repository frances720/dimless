pt = 20;
x = 0:0.01:20;
dx = x(2)-x(1);
%Wt = 20;
Wt = dx:dx:10*dx;
%Wt = linspace(0.2605,5.4096,20);

Dstar = ones(size(x))';

for i = 1:length(Wt)
    
    plot(x,H);

    hold on
    w = solveW(dx,Dstar,H);
    plot(x,-w);
end
axis([0,10,-inf,3]);

% axis([0,5,-inf,1]);
xlabel('xstar'); ylabel('wstar'); title('full range of Wt')
% 
% legend('Wtstar = 1*dx','Wtstar = 2*dx','Wtstar = 3*dx','Wtstar = 4*dx',...
%     'Wtstar = 5*dx','Wtstar = 6*dx'); title('dx = 0.005');
% see if benchmarks to the dimensional case at very long wavelengths, look
% at w0, see if it increases with Wt
% initial deepening--towards isostasy, then fully isostattically
% compensated
