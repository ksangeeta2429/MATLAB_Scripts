function Moment(C,F,T)

M = length(T);
N = length(F);

Freq = repmat(F, 1,M);
FreqIndex = find(abs(F) < 40);

NumFreq = length(FreqIndex);
Index = repmat(FreqIndex, M,1) + N*repmat([0:M-1]', 1,NumFreq);

Moment = sqrt(sum(C(Index) .* Freq(Index).^2, 2));

plot(T, Moment)