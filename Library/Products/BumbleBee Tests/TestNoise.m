function CompTrim = TestNoise(Comp, Rate)
close all

N = length(Comp);
[Time,Unit] = PickTimeScale(N,Rate);
plot(Time,abs(Comp));

xlabel(sprintf('Time in %s', Unit));
ylabel('Amp (ADC Units)')

%% Select Range
axis tight

[Range,Index] = SelectRange(Time);

Temp = Comp(Index);
CompTrim = Temp - MedComp(Temp);

MarkRange(Range)

Axis = axis;

%% Compute Noise
Median = median(abs(CompTrim));

Message = sprintf('Median = %.1f\n', Median);
XPos = RelToAbsPos(0.4, Axis(1:2));
YPos = RelToAbsPos(0.9, Axis(3:4));
text(XPos,YPos, Message)

if abs(Median) < 30
  Grade = 'Good';
elseif abs(Median) < 90
  Grade = 'OK';
elseif abs(Median) < 200
  Grade = 'Poor';
else
  Grade = 'Broke';
end

YPos = RelToAbsPos(0.8, Axis(3:4));
text(XPos,YPos,Grade, 'Color','Green', 'FontSize',20)
