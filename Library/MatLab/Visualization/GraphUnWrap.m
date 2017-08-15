function GraphUnWrap(Comp,Rate, TimeRange)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GraphUnWrap -- Graph the unwrapped phase in units of distance.

N = length(Comp);
BumbleBee;

if nargin == 2
  Time = [0 : N-1]/Rate;
  Data = Comp;
else
  Time = [0 : N-1]/Rate;
  Index = find((TimeRange(1) <= Time) && (Time <= TimeRange(2)));

  Time = Time(Index);
  Data = Comp(Index);
end

WrapPhase = atan2(imag(Data), real(Data));
WrapRot = WrapPhase / 2/pi;
WrapRange = WrapRot * (lambda/2);

UnRange = UnWrap(WrapRange, -lambda/4,lambda/4);

plot(Time,UnRange);
xlabel('Time in Sec.')
ylabel('Range in Meters');