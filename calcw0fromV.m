function w0 = calcw0fromV(V,alpha,D)
w0 = (V .* alpha.^3) ./ (8 .* D);