% GOAL: find line load that could replace block load from rangefront

%% width of the block load
Wtstar = 10;


%% dimensionless space
dxstar = 0.01;
xstar = 0:dxstar:20;


%% block load
H = zeros(size(xstar));
H(xstar < Wtstar) = 1;
Hstar = (H./Wtstar)';

%% run block load model
Dstar = ones(size(xstar))';
wstar = solveW(dxstar,Dstar,Hstar); % model 0 is profile 0

width = round(Wtstar/dxstar);

wstar = wstar((width + 1):end); % take the wstar after rangefront
tail = zeros(width,1); % attach zeros to remain the length
wstar = cat(1,wstar,tail)';

wstar = wstar ./ wstar(1); % normalize so that w* at x* = 0 is 1

% find where the curve intersects with wstar = 0
[forebulge,forebulgeind] = min(wstar);
[zeroxing,zeroxingind] = min(abs(wstar(1:forebulgeind)));
basinArea = sum(abs(wstar(1:zeroxingind)));

figure;
plot(xstar,-wstar,'k');
hold on;


%% run line load model between mid and end pts

wstarmat = zeros(length(xstar),width);
diff = zeros(width,1);

for i = 1:width
    % advancing line load through the whole extent of block load
    Hstarline = zeros(size(xstar))';
    Hstarline(i) = 100;
    
    % treat wstar to exclude the area under the block load
    wstarline = solveW(dxstar,Dstar,Hstarline);
    wstarline = wstarline((width + 1):end);
    wstarline = cat(1,wstarline,tail)';
    
    wstarline = wstarline ./ wstarline(1);
    
    % find the difference from block load curve
    diff(i) = sum(abs(wstarline - wstar)) / basinArea;
    
    wstarmat(:,i) = wstarline;
    %hold on
    %plot(xstar,-wstarline);
end

[bestfit,bestfitind] = min(diff);
plot(xstar,-wstarmat(:,bestfitind));

axis([0,4,-1,0.2]);




