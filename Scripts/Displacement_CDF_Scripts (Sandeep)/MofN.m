function Feat = MofN(Data, M,N)

Len = length(Data);
Feat = zeros(1,Len - N + 1);

for i = 1 : Len - N + 1
  Win = i + [0 : N-1];
  Temp = sort(Data(Win), 'descend');
  Feat(i) = Temp(M);
end

if size(Data,2) == 1
  Feat = Feat';
end