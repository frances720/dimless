pt = 10;
Lcstar = 1;
Ltstar = linspace(0.01,Lcstar,pt);

for i = 1:pt
    varyingD1star(Lcstar,Ltstar(i));
end

%legend('0.01','0.12','0.23','0.34','0.45','0.56','0.67','0.78','0.89','1');