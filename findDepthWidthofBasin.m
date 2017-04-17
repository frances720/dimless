function [depth,width] = findDepthWidthofBasin(x,w,Wt)
w = -w;
[tmp,rangeFront] = min(abs(x - Wt));
depth = w(rangeFront);
[tmp,fbLoc] = max(w);
[tmp,edgeLoc] = min(abs(w(1:fbLoc)));
width = x(edgeLoc) - Wt;

