dxstar = 0.01;
xstar = 0:dxstar:20;

Hstar = buildBlockLoad(xstar,dxstar,10);

D1star = 0.01;
Lcstar = 11.58;
Ltstar = 3.14;
Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
%Dstar = ones(size(xstar))';
wstar = solveW(dxstar,Dstar,Hstar);
plot(xstar,-wstar,'k');
hold on

left = wstar(1);
right = wstar(end);
threshold = 2e-4;
intersect = [];

for i = 1:length(wstar) 
    if abs(wstar(i) - left) < threshold || abs(wstar(i) - right) < threshold
        intersect = [intersect,i];
    end 
end
scatter(xstar(intersect),-wstar(intersect)); grid on
xlabel('xstar');ylabel('wstar');title('Points close to the value of the unaffected ends of wstar');

range = [];
for j = 2:length(intersect)-1
    if (intersect(j+1) - intersect(j) ~= 1) || (intersect(j) - intersect(j-1) ~= 1)
        range = [range,intersect(j)];
    end
end
    

        