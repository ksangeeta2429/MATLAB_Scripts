function [C,F,T] = MySpect(Comp, FullScale)

if nargin < 2
  FullScale = 1024;
end
    
Rate = 1024/3;
WindowSize = 96;
OverLap = WindowSize * (1 - 1/8);
FftSize = 128;

[SpecData,Freq,Time] = spectrogram(Comp, WindowSize,OverLap,FftSize,Rate);

NF = length(Freq);
NT = length(Time);

if mod(NF,2) == 0
  Mid = NF/2 + 1;
  FreqIndex = [Mid : NF, 1 : Mid];
else
  Mid = (NF + 1)/2;
  FreqIndex = [Mid + 1 : NF, 1 : Mid];
end

NumFreq = length(FreqIndex);
Index = repmat(FreqIndex, NT,1) + repmat([0 : NT-1]' * NF, 1,NumFreq);

UnWrapFreq = [Freq(NF/2 : NF)' - Rate, Freq(1 : NF/2)'];

Result = SpecData(Index);
Mag = abs(Result);
Dir = diff(angle(Result), 1);

%% Draw the main graph
GraphMag(WindowSize,FullScale, UnWrapFreq,Time,Mag)

if nargout == 3
  C = Mag;
  F = UnWrapFreq;
  T = Time;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
function GraphMag(WindowSize,FullScale, UnWrapFreq,Time,Mag)

M = 256;
colormap(hot(M));

Scale0 = 1/sqrt(WindowSize);
Scale1 = 256/FullScale;

image(UnWrapFreq,Time, Mag*Scale0*Scale1);

xlabel('Frequency in Hz')
ylabel('Time in Sec')