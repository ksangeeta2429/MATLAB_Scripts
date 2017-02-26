function FiltData = HarmSet(Data,Rate, BaseFreq, NumHarm, W)

N = length(Data);
DeltaF = Rate/N;

Mask = zeros(1,N);
Wind = [-W : W];

for i = 1 : NumHarm
  Index = round(i * BaseFreq/DeltaF);

  Mask(Wind + Index + 1) = 1;
  Mask(Wind + N - Index + 1) = 1;
end

Trans = fft(Data);
Trans(find(~Mask)) = 0;

FiltData = ifft(Trans);