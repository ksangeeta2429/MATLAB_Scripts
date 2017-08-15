function TestDrift(Time,Comp, lambda)

N = length(Comp);

%% UnWrap
Rot = angle(Comp) / (2*pi);
UnRot = UnWrap(Rot, -0.5,0.5);
RelRange = UnRot * (lambda/2);

%% Plot
plot(Time, RelRange);
hold on

xlabel('Time in Seconds');
ylabel('Relative Range in Meters')

%% Comput fit
T0 = mean(Time);

Fit = polyfit(Time - T0,RelRange, 1);
T = [Time(1), Time(N)];
Line = polyval(Fit, T - T0);

%% plot fit
plot(T, Line, 'r--')
hold off

axis tight;
Axis = axis;

Drift = Fit(1)*60;
Msg = sprintf('Drift = %.1f m/min', Drift);

XPos = RelToAbsPos(0.1, Axis(1:2));
if sign(Drift) < 0
  text(XPos, RelToAbsPos(0.1, Axis(3:4)), Msg);
else
  text(XPos, RelToAbsPos(0.9, Axis(3:4)), Msg);
end;

Axis = axis;
if abs(Drift) < 1
  Grade = 'Good';
elseif abs(Drift) < 2
  Grade = 'Poor';
else
  Grade = 'Broke';
end

XPos = RelToAbsPos(0.4, Axis(1:2));
YPos = RelToAbsPos(0.5, Axis(3:4));
text(XPos,YPos,Grade, 'Color','Green', 'FontSize',20)