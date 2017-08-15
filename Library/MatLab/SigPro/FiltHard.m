function Out = FiltHard(In, Rate, RuleHand)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FiltHard -- Apply a hard filter.

N = length(In);
Freq = FftFreq(N,Rate);
Mask = feval(RuleHand, Freq);

Trans = fft(In);
Trans(find(Mask)) = 0;
Out = ifft(Trans);