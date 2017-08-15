function GraphPhase(Time,Comp)

lambda = 3e8/5.8e9;

N = length(Comp);

%% UnWrap
RelRange = UnWrap(angle(Comp)/2/pi, -0.5,0.5) * (lambda/2);

%% Plot
plot(Time, RelRange);

axis tight
xlabel('Time in Seconds');
ylabel('Relative Range in Meters')