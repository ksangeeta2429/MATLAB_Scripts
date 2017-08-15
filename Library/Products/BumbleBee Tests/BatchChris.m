function Trimed = BatchChris(Comp,Rate, Title)

%% Constants
lambda = 299792458/5.8e9;
NumSubY = 4;
NumSubX = 1;

%% Argument processing
N = length(Comp);
Time = [0 : N-1]' / Rate;

%% Graph Amp and pick region
subplot(NumSubY,NumSubX, 1);
GraphAmp(Comp, Rate)

title(Title);

%% Optional Trim
[Range,Index] = SelectRange(Time);
Trimed = ~isempty(Range);

if Trimed
  Temp = Comp(Index);
  Comp = Temp - mean(Temp);

  Axis = axis;
  WasHold = ishold;
  
  hold on
  plot(repmat(Range', 2,1), repmat(Axis(3:4)', 1,2), 'r', 'LineWidth',3);
  
  if ~WasHold
    hold off
  end

  N = length(Index);
  Time = Time(Index);
end

%% Graph Amp and pick region
subplot(NumSubY,NumSubX, 2);
GraphPhase(Time,Comp, lambda);

%% Do Drift
subplot(NumSubY,NumSubX, 3);
GraphDisp(Time,Comp, [1 3]);

%% Do frequencies
Trans = fft(Comp)/N;

subplot(NumSubY,NumSubX, 4);
GraphFFT(Trans, Rate);