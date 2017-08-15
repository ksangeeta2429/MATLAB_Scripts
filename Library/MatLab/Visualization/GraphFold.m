function GraphFold(Data, DeltaX, TickInc)

MinFracGap = 2/3;
Boarder = 0.02;

%%  Graph data
N = length(Data);
X = [0 : N]*DeltaX;
MaxX = N*DeltaX;

Data(N+1) = Data(1);
plot(X,Data, 'Marker','.');

%% Do folded tick markes
FoldX = N/2 * DeltaX;
M = floor(FoldX/TickInc - MinFracGap);

for Mult = 0 : M
  PosIndex = Mult + 1;
  Tick(PosIndex) = Mult * TickInc;
  %% This formating is lame
  Label{PosIndex} = FormatEngr(Tick(PosIndex), 2);  

  NegIndex = 2*M + 3 - Mult;
  Tick(NegIndex) = MaxX - Mult*TickInc;
  Label{NegIndex} = sprintf('-%s', Label{PosIndex});
end
Tick(M+2) = FoldX;
Label{M+2} = sprintf('%cNyq.', char(177));

AxisHand = gca;
set(AxisHand, 'XTick',Tick);
set(AxisHand, 'XTickLabel',Label);

%% Set Axis
MaxY = max(Data);
MinY = min(Data);
YRange = MaxY - MinY;

LowY = MinY - Boarder*YRange;
HighY = MaxY + Boarder*YRange;
LowX = -Boarder*MaxX;
HighX = (1 + Boarder)*MaxX;

axis([LowX HighX LowY HighY]);