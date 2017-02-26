function CompFilt = BalancedFilter(Comp, InRate,OutRate)

NIn = length(Comp);
OutNyq = OutRate/2;

%% Time Selection
subplot(4,1,1);

Time = [0 : NIn - 1]/InRate;
plot(Time, abs(Comp))
hold on

xlabel('Time in Seconds')
ylabel('ADC units')
axis tight

[TimeRange, TimeIndex] = SelectRange(Time);

Axis = axis;
plot(repmat(TimeRange', 2,1), repmat(Axis(3:4)', 1,2), 'r', 'LineWidth',3);
hold off

Temp = Comp(TimeIndex);
CompTrunc = Temp - mean(Temp);
NTrunc = length(CompTrunc);

%% Graph Frequency
subplot(4,1,2)

TransIn = fft(CompTrunc)/NTrunc;
[DeltaF,Assend] = GraphFFT(TransIn, InRate);
hold on

Axis = axis;
plot(...
  repmat([-OutNyq, OutNyq], 2,1), repmat(Axis(3:4)', 1,2), ...
  'r', 'LineWidth',3);
hold off

%% down sampled FFT
subplot(4,1,3);

OutTrans = FftFreqTrunc(TransIn, round(NTrunc * OutRate/InRate));
[OutDeltaF,OutAssend] = GraphFFT(OutTrans, OutRate);

NOut = length(OutTrans);
CompOut = ifft(OutTrans) / NOut;

%% Graph result
subplot(4,1,4)

lambda = 3e8/5.8e9;
OutTime = [0 : NOut - 1]/OutRate + ceil(TimeRange(1));

TestDrift(OutTime, CompOut, lambda)