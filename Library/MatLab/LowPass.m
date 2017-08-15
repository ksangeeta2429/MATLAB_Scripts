function Filt = LowPass(Data, Rate,Band)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LowPass -- Hard filter above a specified frequency

N = length(Data);

Trans = fft(Data);

Freq = FftFreq(N,Rate);
Mask = (Band < Freq);

Trans(find(Mask)) = 0;

Filt = iff(Trans);