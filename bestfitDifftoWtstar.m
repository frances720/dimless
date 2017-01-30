%% set up dimless space
dxstar = 0.01; %
xstar = 0:dxstar:20; %

%% range of Wtstar
pts = 30; %
Wtstar = linspace(dxstar,6,pts); %
WtstarFin = snapWtstar2Grid(dxstar,Wtstar); %

%%
diffValueOfBestfit = zeros(pts,1); %
posOfBestfit = zeros(pts,1); %

for j = 1:pts
    
    % block load
    H = zeros(size(xstar)); %
    H(xstar < WtstarFin(j)) = 1; %
    Hstar = (H./WtstarFin(j))'; %
    
    % run block load model
    Dstar = ones(size(xstar))'; %
    wstar = solveW(dxstar,Dstar,Hstar); %
    
    % find the rangefront index
    width = round(WtstarFin(j)/dxstar); %
    possibleRange = floor(width/2) + 1; %
    
    % truncate w* to rangefront while maintaining vector length
    wstar = wstar((width + 1):end); %
    tail = zeros(width,1); %
    wstar = cat(1,wstar,tail)'; %
    
    % normalize to wstar at xstar = 0
    wstar = wstar ./ wstar(1); %
    
    % find where the curve intersects with wstar = 0
    [forebulge,forebulgeind] = min(wstar); %
    [zeroxing,zeroxingind] = min(abs(wstar(1:forebulgeind))); %
    basinArea = sum(abs(wstar(1:zeroxingind))); %
    
    wstarmat = zeros(length(xstar),possibleRange); %
    diff = zeros(possibleRange,1); %
    
    for i = 1:possibleRange
        % advancing line load through the whole extent of block load
        Hstarline = zeros(size(xstar))'; %
        ind = floor(width/2) + i; %
        Hstarline(ind) = 1/dxstar; %
        
        % treat wstar to exclude the area under the block load
        wstarline = solveW(dxstar,Dstar,Hstarline); %
        wstarline = wstarline((width + 1):end); %
        wstarline = cat(1,wstarline,tail)'; %
        
        % normalize to the deflection at xstar = 0
        wstarline = wstarline ./ wstarline(1); %
        
        % find the difference from block load curve
        diff(i) = sum(abs(wstarline - wstar)) / basinArea; %
        
        wstarmat(:,i) = wstarline; %
        %hold on
        %plot(xstar,-wstarline);
    end
    
    [bestfit,bestfitind] = min(diff); %
    diffValueOfBestfit(j) = bestfit; %
    posOfBestfit(j) = (bestfitind + floor(width/2)) * dxstar; %
    
end

plot(Wtstar,diffValueOfBestfit.*100);
xlabel('Wtstar');
ylabel('% of L1-norm relative to basin area defined by block load');

figure;
plot(Wtstar,posOfBestfit);
xlabel('Wtstar');
ylabel('Position of line load for the bestfit curve');

