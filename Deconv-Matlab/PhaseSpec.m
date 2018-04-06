function PhaseSpec(Comp, FullScale)

N = length(Comp);
Rate = 1024/3;

% Graph Spect
MySpect(Comp, FullScale);
hold on

% Graph Phase
UnPhase = UnWrap(angle(Comp)/2/pi);

M = round(Rate/2);
UnPhaseSmooth = filter(ones(1,M)/M,1, UnPhase);

Vol = Rate * diff(UnPhaseSmooth);
TimeSmooth = ([0 : N-2] - M/2)/Rate;

plot(Vol, TimeSmooth', 'b', 'LineWidth',2);
hold off

legend('Phase Unwrap', 'location', 'NorthWest');

% M = 330;
% Index = repmat([0 : M-1]', 1,N) + repmat();

% Max = max(UnPhase(Index));
% Min = min(UnPhase(Index));

% Window = Comp(Index);