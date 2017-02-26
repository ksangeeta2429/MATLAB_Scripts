function CompTrim = BatchWalk(Comp,StopRange, Rate,Title)

%% Constants
lambda = 299792458/5.8e9;

%% Argument processing
N = length(Comp);
NStop = length(StopRange);

%% Graph Amp and pick region
subplot(3,1, 1);

Time = [0 : N-1]/Rate;
plot(Time, abs(Comp));
hold on

xlabel('Time in Seconds');
ylabel('Amplitude in ADC Units')

[Range,Index] = SelectRange(Time);

Temp = Comp(Index);
CompTrim = Temp - mean(Temp);
NTrim = length(CompTrim);

title(Title);

%% Do phase
subplot(3,1, 2);
GraphPhase(CompTrim);

for WalkNum = 1 : NumStop
  [Time,Trash] = ginput(2)
  StartTime(WalkNum) = Time(1);
  OutTime(WalkNum) = Time(2);
  
  subplot(3,1,1);
  MarkRange(Time)
  
  subplot(3,1,2);
  MarkRange(Time)
end

%% Do Power
subplot(
for WalkNum = 1 : NumStop
  
end

