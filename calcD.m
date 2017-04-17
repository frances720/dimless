function D = calcD(Te, E, v)
D = (Te.^3.*E)./(12.*(1-v.^2));

