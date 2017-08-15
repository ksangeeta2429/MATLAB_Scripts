function TestSpike(Time,Comp, Rate)

%% Paramtiers
N = length(Comp);

%% FFT
Trans = fft(Comp) / N;

DeltaF = Rate/N;

if mod(N,2) % i.e., is odd
  Mid = (N + 1)/2;
  Order = [[Mid + 1 : N], [1 : Mid]];
  FStep = [[-Mid + 1 : -1], [0 : Mid - 1]];  %% not quite right
else
  Mid = N/2;
  Order = [[Mid + 1 : N], [1 : Mid + 1]];
  FStep = [[-Mid : -1], [0 : Mid]];
end;

%% 1/F Equivalance
F = FStep*DeltaF;
MagHz = abs(F) .* abs(Trans(Order));

plot(F,MagHz, 'b.-')
axis tight
Axis = axis;

xlabel('Freq in Hz');
ylabel('1/f Equivlance')

MaxMagHz = max(MagHz);
Message = sprintf('Max = %.1f ADCs * Hz', MaxMagHz);

XPos = RelToAbsPos(0.4, Axis(1:2));
YPos = RelToAbsPos(0.9, Axis(3:4));
text(XPos,YPos, Message);