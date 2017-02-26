function Result = RunMax(Data, WindSize)

Assert(mod(WindSize,2) == 1, 'Assumes odd window lenght.')
N = length(Data);
M = WindSize/2 - 0.5;  % 2*M + 1 = N

for i = 1 : M + 1
  Result(i) = max(Data(1 : i + M));
end

Index = [-M : M];
for i = M + 2 : N - M - 1
  Result(i) = max(Data(Index + i));
end

for i = N - M : N
  Result(i) = max(Data(i - M : N));
end