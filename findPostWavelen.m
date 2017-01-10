function postWavelen = findPostWavelen(dxstar, wstar, WtstarFin)
wstar = [wstar(1);wstar;wstar(end)];
slope = abs((wstar(3:end) - wstar(1:end-2)) ./ (2*dxstar));
bulgePos = [];

for i = 2:length(slope)-1
    if slope(i) < slope(i - 1) && slope(i) < slope(i + 1)
        bulgePos = [bulgePos,i];
    end
end

threshold = 5;
[vmax,imax] = max(wstar);
[vmin,imin] = min(wstar);
bulgePos = [-999 bulgePos -999];
result = [0;0];

for i = 1:length(bulgePos)
    if abs(bulgePos(i) - imax) < threshold && abs(bulgePos(i+1) - imin) < threshold
        result = [bulgePos(i);bulgePos(i+1)];
    end
end
postWavelen = 2*(result(2)*dxstar-WtstarFin);
end
    