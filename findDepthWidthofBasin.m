function [depth,width] = findDepthWidthofBasin(x,w,Wt)
w = -w;
[tmp,rangeFront] = min(abs(x - Wt));
depth = w(rangeFront);
[tmp,fbLoc] = max(w);
width = x(fbLoc) - Wt;

