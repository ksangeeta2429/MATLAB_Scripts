function Freq = FftFreq(N, Rate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FfTFreq -- Returnes the frequency for each element of the FFT.

DeltaF = Rate/N;
RelFreq = Wrap([0 : N-1], -N/2,N/2);

Freq = DeltaF * RelFreq;