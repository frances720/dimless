%% set up dimless space
dxstar = 0.01;
xstar = 0:dxstar:20;

%% range of Wtstar
Wtstar = linspace(dxstar,6,10);
WtstarFin = snapWtstar2Grid(dxstar,Wtstar); % make sure it falls on the finite mesh

%%
diffValueOfBestfit = zeros(length(Wtstar),1)';
posOfBestfit = zeros(length(Wtstar),1)';

for j = 1:length(Wtstar)
    
    % block load
    H = zeros(size(xstar));
    H(xstar < WtstarFin(j)) = 1;
    Hstar = (H./WtstarFin(j))';
    
    % run block load model
    Dstar = ones(size(xstar))';
    wstar = solveW(dxstar,Dstar,Hstar);
    
    % find the rangefront index
    width = round(WtstarFin(j)/dxstar);
    
    % truncate w* to rangefront while maintaining vector length
    wstar = wstar((width + 1):end); 
    tail = zeros(width,1);
    wstar = cat(1,wstar,tail)';
    
    % normalize to wstar at xstar = 0
    wstar = wstar ./ wstar(1);
    
    % find where the curve intersects with wstar = 0
    [forebulge,forebulgeind] = min(wstar);
    [zeroxing,zeroxingind] = min(abs(wstar(1:forebulgeind)));
    basinArea = sum(abs(wstar(1:zeroxingind)));
    
    % run line load model between mid and end pts
%     pts = 50;
%     
%     if pts > width
%         gap = 1;
%     else
%         gap = round(width/pts);
%     end
    
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
        
        % normalize to the deflection at xstar = 0
        wstarline = wstarline ./ wstarline(1);
        
        % find the difference from block load curve
        diff(i) = sum(abs(wstarline - wstar)) / basinArea;
        
        wstarmat(:,i) = wstarline;
        %hold on
        %plot(xstar,-wstarline);
    end
    
    [bestfit,bestfitind] = min(diff);
    diffValueOfBestfit(j) = bestfit;
   
    posOfBestfit(j) = bestfitind;
end

plot(Wtstar,diffValueOfBestfit.*100);
xlabel('Wtstar');
ylabel('% of L1-norm relative to basin area defined by block load');

figure;
plot(Wtstar,posOfBestfit);

