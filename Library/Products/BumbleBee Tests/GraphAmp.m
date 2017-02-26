function Time = GraphAmp(Comp, Rate)

N = length(Comp);

if size(Comp,1) == 1
  Time = [0 : N-1] / Rate;
else
  Time = [0 : N-1]' / Rate;
end

GraphAmpTime(Time,Comp);