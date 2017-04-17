function RMS = fitToMeasuredPts(pts,x,w)
x_pts = pts(:,1);
w_pts = pts(:,2);
RMS = 0;

for i = 1:length(x_pts)
    [value,ind] = min(abs(x - x_pts(i)));
    RMS = RMS + (w(ind) - w_pts(i))^2;
end

RMS = sqrt(RMS) / length(x_pts);