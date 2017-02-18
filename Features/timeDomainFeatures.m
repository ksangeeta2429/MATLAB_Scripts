function res = timeDomainFeatures(Data)

f1 = sum(abs(Data));
f2 = sum(abs(Data).^2);
f3 = max(abs(Data));
f4 = max(abs(Data).^2);
f5 = mean(abs(Data));
f6 = mean(abs(Data).^2);
f7 = std(abs(Data));
f8 = std(abs(Data).^2);

res = [f1,f2,f3,f4,f5,f6,f7,f8];

