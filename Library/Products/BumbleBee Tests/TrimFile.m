function Aborted = TrimFile(InFile,OutFile,Rate, Range)

lambda = 3e8/5.8e9;

[Real,Imag] = ReadRadarReIm(InFile);
N = length(Real);

if 3 < nargin
  LocRange = Range;
else
  Comp = (Real - median(Real)) + i*(Imag - median(Imag));
  LocRange = GetTimeRange(Comp, Rate);
end

if isempty(LocRange)
  Aborted = true;
else
  Aborted = false;
  WriteTrimedFile(Real,Imag, LocRange,Rate, OutFile,InFile)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function WriteTrimedFile(Real,Imag, LocRange,Rate, OutFile,InFile)
    
Low = round(LocRange(1)*Rate) + 1;
High = round(LocRange(2)*Rate) + 1;
NTrim = High - Low + 1;

Index = [Low : High];
ReTrim = Real(Index);
ImTrim = Imag(Index);

%% Output trimed file
[OutDir,OutBase,OutExt] = FileNameSplit(OutFile);
[InDir,InBase,InExt] = FileNameSplit(InFile);
  
if isempty(OutExt)
  if strcmp(InExt,'bbsu')
    OutExt = 'bbs';
  else
    OutExt = Ext;
  end
end

if strcmp(OutExt,'bbs')
  OddIndex = 2*[1 : NTrim] - 1;
  EvenIndex = 2*[1 : NTrim];

  Data(OddIndex) = ReTrim;
  Data(EvenIndex) = ImTrim;
  
elseif strcmp(Ext,'bbi')
  ReStart = floor((Low + 1)/2) + 1;  %% real is odd
  ImStart = floor((Low + 1)/2) + 1;

  RealIndex = [Low : 2 : High];
  ImIndex = [Low + 1 : 2 : High];

  Data(ReIndex) = Real(ReIndex);
  Data(EvenIndex) = Imag(ImIndex);

else
  error(sprintf('Extension type "%s" not supported', OutExt));
  
end;

if isempty(OutDir)
  OutDir = InDir;
end
OutName = sprintf('%s\\%s.%s', OutDir,OutBase,OutExt);

WriteRaw(OutName, uint16(Data));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Range,Abort] = GetTimeRange(Comp,Rate)

subplot(2,1,1)
Time = GraphAmp(Comp,Rate);
N = length(Time);

subplot(2,1,2)

lambda = 3e8/5.8e9;
UnRot = UnWrap(angle(Comp)/2/pi, -0.5,0.5);
RelRange = UnRot * lambda/2;

plot(Time,RelRange,'r');

axis tight
xlabel('Time in Sec.');
ylabel('Rel. Range in Meters');

%% Select range
[Range,Trash] = ginput(2);

if length(Range) < 2
  Range = [];
else
  Range(1) = max(Range(1),Time(1));
  Range(2) = min(Range(2),Time(N));

  subplot(2,1,1);
  MarkRange(Range)

  subplot(2,1,2);
  MarkRange(Range)
end



