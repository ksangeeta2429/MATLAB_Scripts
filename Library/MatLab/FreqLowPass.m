function OutFreq = FreqLowPass(InFreq, DeltaF,Band)

N = length(InFreq);
Lim = floor(Band/DeltaF);

%% Move the data, Matlab must move it
LowIndex = [0:Lim] + 1;
OutFreq(LowIndex) = InFreq(LowIndex);

MidIndex = [Lim + 1 : N - Lim - 1] + 1;
OutFreq(MidIndex) = 0;

HighIndex = [N - Lim : N - 1] + 1;
OutFreq(HighIndex) = InFreq(HighIndex);