function DeMod1(Comp)

Rate = 1024/3;
N = length(Comp);

UnPhase = UnWrap(angle(Comp)/2/pi);
Mod = exp(-i*UnPhase*2*pi);

Result = Comp .* Mod;

%% plot high pass
Freq = FftFreq(N, Rate);
Index = find(1 < (abs(Freq)) & (abs(Freq) < 20));

Trans = fft(Result);
TransFilt = zeros(1,N);
TransFilt(Index) = Trans(Index);

CompFilt = ifft(TransFilt)/N;

plot(abs(CompFilt))