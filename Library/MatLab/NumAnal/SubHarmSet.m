function FiltData = SubHarmSet(Data,Rate, BaseFreq, NumHarm)

N = length(Data);
DeltaF = Rate/N;

Mask = zeros(1,N);
for i = 1 : NumHarm
  PosIndex = round(BaseFreq/i/DeltaF) + 1;
  Mask(PosIndex) = 1;
  
  NegIndex = N - round(BaseFreq/i/DeltaF) + 1;
  Mask(NegIndex) = 1;
end

Trans = fft(Data);
Trans(find(~Mask)) = 0;

FiltData = ifft(Trans);