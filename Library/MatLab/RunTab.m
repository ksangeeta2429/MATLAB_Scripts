function Result = RunTab(Data, M)

N = length(Data);
L = N - M + 1;

Index = 1 + repmat([0:M-1], L,1) + repmat([0 : L-1]', 1,M);
Result = Data(Index);