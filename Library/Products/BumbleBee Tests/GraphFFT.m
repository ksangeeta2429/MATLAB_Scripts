function [DeltaF,RelFreq] = GraphFFT(CompF, Rate)

%% Paramtiers
N = length(CompF);

%% Graph FFT
DF = Rate/N;
[FoldToAssend, RF] = FftFold(N);

Freq = DF * RF;
plot(Freq, abs(CompF(FoldToAssend)), 'b.-')

axis tight
Axis = axis;

xlabel('Freq in Hz');
ylabel('ADC Units')

%% Assign optional output arguments
if nargout > 0
  DeltaF = DF;
end
if nargout > 1
  RelFreq = RF;
end