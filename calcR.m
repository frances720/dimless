function R = calcR(dx,D,H,w)
wdiff = [w(3);w(2);w;0;0];
D = [D(2);D;D(end)];
d2wdx2 = (wdiff(3:end) - 2.*wdiff(2:end-1) + wdiff(1:end-2))./dx.^2;
M = -D.*d2wdx2;
d2Mdx2 = (M(3:end) - 2.*M(2:end-1) + M(1:end-2))./dx.^2;
R = d2Mdx2 - 4.*w + 8.*H;

