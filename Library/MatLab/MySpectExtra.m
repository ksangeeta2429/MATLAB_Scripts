function MySpectExtra(Comp, BaseName)

Rate = 1024/3;
WindowSize = 96;
OverLap = WindowSize * (1 - 1/8);
FftSize = 128;

[SpecData,Freq,Time] = ...
  spectrogram(Comp, WindowSize,OverLap,FftSize,Rate);

NF = length(Freq);
NT = length(Time);

FreqIndex = [NF/2 : NF, 1 : NF/2];
Index = repmat(FreqIndex, NT,1) + repmat([0 : NT-1]' * NF, 1,NF+1);

UnWrapFreq = [Freq(NF/2 : NF)' - Rate, Freq(1 : NF/2)'];

Result = SpecData(Index);
Mag = abs(Result);
Dir = diff(angle(Result), 1);

%% Draw the main graph
figure(1)
GraphMag(WindowSize, UnWrapFreq,Time,Mag,BaseName)

%% Draw the phase figure
% figure(2)
% GraphPhase(UnWrapFreq,Time,Dir,BaseName);

%%%%%%%%%%%%%%%%%%%%%%%%%%
function GraphMag(WindowSize, UnWrapFreq,Time,Mag,BaseName)

M = 256;
colormap(hot(M));

Scale0 = 1/sqrt(WindowSize);
Scale1 = 256/1024;

image(UnWrapFreq,Time, Mag*Scale0*Scale1);

xlabel('Frequency in Hz')
ylabel('Time in Sec')

FileName = sprintf('%s (mag)', BaseName);
% SaveFigure(FileName, 5,7);

%%%%%%%%%%%%%%%%%%%%%%%%%%
function GraphPhase(UnWrapFreq,Time,Dir,BaseName)

Scale2 = 256/2/pi;
image(UnWrapFreq,Time, Dir*Scale2)

xlabel('Frequency in Hz')
ylabel('Time in Sec')

FileName = sprintf('%s (phase)', BaseName);
SaveFigure(FileName, 5,7);