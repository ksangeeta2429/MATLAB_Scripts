function CompTrim = BatchNoiseProd(Comp,Rate, Title)

%% Constants
lambda = 299792458/5.8e9;

%% Graph Amp and pick region
subplot(4,2, [1,2]);

CompTrim = TestNoise(Comp,Rate);
NTrim = length(CompTrim);

title(Title);

%% Do phase
subplot(4,2, 3);
TestPhasing(CompTrim);

%% Do frequencies
Trans = fft(CompTrim)/NTrim;

subplot(4,2,4);
GraphFFT(Trans, Rate);
Axis = axis;

subplot(4,2,5);
GraphFFT(Trans, Rate);
axis([-5e3 5e3, Axis(3:4)]);

%% Do Drift
subplot(4,2, 6);

if Rate > 800
  N = length(CompTrim);
  TimeOrigSamp = [0 : N-1] / Rate;
  TimeReSamp = [0 : 1/800 : NTrim/Rate];
  CompReSamp = interp1(TimeOrigSamp,CompTrim, TimeReSamp);
  
else
  TimeReSamp = [0 : NTrim - 1]' / Rate;
  CompReSamp = CompTrim;

end

TestDrift(TimeReSamp,CompReSamp, lambda);
title('At 256 Hz')

subplot(4,2, [7,8])

GraphDisp(TimeReSamp,CompReSamp, [1],[8 10 12.5]);