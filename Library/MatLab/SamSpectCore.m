function [Mag,Freq,Time] = SamSpectCore(Comp, Param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SamSpectCore -- The core of Samraksh replacement for spectrogram.

if isreal(Comp)
  ERROR('This funciton only works for complex data')
end

OverLap = Param.WindowSize * Param.OverLap;

[SpecData,Freq,Time] = spectrogram( ...
  Comp, Param.WindowSize, OverLap, Param.FftSize, Param.Rate);

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

UnWrapFreq = [Freq(NF/2 : NF)' - Param.Rate, Freq(1 : NF/2)'];

Result = SpecData(Index);
Mag = abs(Result);
Dir = diff(angle(Result), 1);

%% Draw the main graph
GraphMag( ...
  Param.WindowSize,Param.FullScale, UnWrapFreq,Time,Mag, Param.LogScale)

%%%%%%%%%%%%%%%%%%%%%%%%%%
function GraphMag(WindowSize,FullScale, UnWrapFreq,Time,Mag, LogScale)

M = 256;
colormap(hot(M));

Scale0 = 1/WindowSize;

if LogScale
  MinLog = log(min(min(Mag)));
  Scale1 = M / (log(FullScale) - MinLog);
  image(UnWrapFreq,Time, (log(Mag) - MinLog)*Scale0*Scale1);
  
else
  Scale1 = M / FullScale;
  image(UnWrapFreq,Time, Mag*Scale1*Scale0);
  
end

xlabel('Frequency in Hz')
ylabel('Time in Sec')