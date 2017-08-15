function CompTrim = TestFreq(Comp, Rate)

%% Constants
lambda = 299792458/5.8e9;

%% Argument processing
N = length(Comp);

Time = [0 : N-1] / Rate;


%% Pick Region
subplot(3,1,1);

[Index, CompTrim] = TestNoise(Time,Comp, Rate);
NTrim = length(CompTrim);

%% Do 
subplot(3,1,2);
TestDrift(Time(Index),CompTrim, lambda)

%% Do frequencies
subplot(3,1,3);

Trans = fft(CompTrim) / NTrim;
GraphFFT(Trans, Rate);