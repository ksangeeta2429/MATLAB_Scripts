function [Mag,Freq,Time] = SamSpect(Data, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SamSpect -- Samraksh replacement for spectrogram.
%    Deals with the paramiter list and calls SamSpecCore.

if isreal(Data)
  ERROR('This funciton only works for complex data')
end

%% Setup default values
Param.LogScale = false;
Param.Rate = 1024/3;
Param.FftSize = 512;
Param.OverLap = 7/8;
Param.FullScale = 1;
Param.WindowSize = 1024;

%% Overwrite Default
Flag = varargin;
NumFlag = length(Flag);

Index = 1;
while (Index <= NumFlag)
  Temp = lower(Flag(Index));
  switch Temp{:}
    case 'logscale'
      Param.LogScale = true;
    case 'fftsize'
      Param.FftSize = Flag{Index + 1};
      Index = Index + 1;    
    case 'windowsize'
      Param.WindowSize = Flag{Index + 1};
      Index = Index + 1;
    case 'rate'
      Param.Rate = Flag{Index + 1};
      Index = Index + 1;
    case 'overlap'
      Param.OverLap = Flag{Index + 1};
      Index = Index + 1;
    case 'fullscale'
      Param.FullScale = Flag{Index + 1};
      Index = Index + 1;
    otherwise
      ERROR('Argument not recognized')
  end
  Index = Index + 1;
end

%% Do the core operation
[MagInternal,FreqInternal,TimeInternal] = SamSpectCore(Data, Param);

if nargout == 3
  Mag = MagInternal;
  Freq = FreqInternal;
  Time = TimeInternal;
end