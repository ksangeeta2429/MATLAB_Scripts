function ModWave(I,Q, OutFile)

InRate = 1024/3;
OutRate = 1024;

InN = length(I);
OutN = round(InN * (OutRate/InRate));

Shift = round(100 * (2/OutRate) * OutN);
OutI = Mod(I, Shift,OutN);
OutQ = Mod(Q, Shift,OutN);

subplot(2,1,1)
plot(OutI)
axis tight

subplot(2,1,2)
plot(OutQ)
axis tight

[X,Y] = ginput(2);
Index = [round(X(1)) : round(X(2))];

subplot(2,1,1)
plot(OutI(Index))
axis tight

subplot(2,1,2)
plot(OutQ(Index))
axis tight

Max1 = max(max(OutI(Index)),max(OutQ(Index)));
wavwrite([OutI(Index),OutQ(Index)]/Max1, round(OutRate),16, OutFile)