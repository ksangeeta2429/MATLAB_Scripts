function GraphTranfer(Transfer, Special)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 500;
LowF = 0.1;
HighF = 10e3;

%% Compute complex gain over freqnecy range
LogLowF = log(LowF);
RangeLogF = log(HighF) - LogLowF;

Freq = exp(RangeLogF * [0 : N-1] / (N-1) + LogLowF);
Omega = 2*pi*Freq * i;

CompGain = Transfer(Omega);

%% Graph Amp
subplot(2,1,1)

Y = abs(CompGain);
loglog(Freq, Y)
hold on

% annotate max
[MaxAmp,MaxIndex] = max(Y);
MinAmp = min(Y);

Text = sprintf('Max = %.1f', MaxAmp);
text(Freq(MaxIndex)*0.9, MaxAmp, Text)

plot([LowF HighF], MaxAmp/2 * [1 1], 'r');

Axis = [LowF,HighF, 10^floor(log10(MinAmp)), 10^(ceil(log10(MaxAmp)))];
axis(Axis);
    
% annotate specials
if nargin > 1
  M = length(Special);
  loglog(repmat(Special, 2,1), repmat(Axis(3:4)', 1,M), 'g--')


  SpecialAmp = interp1(Freq,Y, Special);
  for Count = 1 : M
    Text = sprintf('%.1f x', MaxAmp/SpecialAmp(Count));
    text(Special(Count)*1.1, SpecialAmp(Count), Text)
  end
end
hold off
    
xlabel('Frequency in Hz')
ylabel('Gain')

%% Graph Phase
subplot(2,1,2)

Quad = 2*angle(CompGain)/pi;
UnQuad = UnWrap(Quad, -2,2);

semilogx(Freq, UnQuad)
hold on

Axis = [LowF, HighF, floor(min(UnQuad)), ceil(max(UnQuad))];
axis(Axis)

GridY = repmat([Axis(3) + 1 : Axis(4) - 1], 2,1);
M = length(GridY);
GridX = repmat(Axis(1:2)', 1,M);

semilogx(GridX,GridY, 'g--')

semilogx(repmat([1 100], 2,1), repmat(Axis(3:4)', 1,2), 'r');
hold off

xlabel('Frequency in Hz')
ylabel('Phase Delay in Quadrants')