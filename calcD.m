function D = calcD(Te,E,v)
D = (E*Te.^3) / (12*(1-v^2));