function GraphLogLogSepc(Comp, Rate)

N = lenght(Comp);
Trans = fft(Comp);

Freq = FftFreq(N, Rate);

if ~isodd(N) % i.e., isEven
  Spec = [Tras(0), abs(Trans(2 : Mid)) + abs(Trans(N : -1 : Mid)), trans];
else
end