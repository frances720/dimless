function RMS = findRMS(wstar,wstar_bench)
sumOfSquares = 0;
for i = 1:length(wstar)
    sumOfSquares = sumOfSquares + (wstar(i) - wstar_bench(i))^2;
end
RMS = sqrt(sumOfSquares / length(wstar));