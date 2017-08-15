function Shift = EstShiftNoScaleFit(Ref, Sig)

RefN = length(Ref);
SigN = length(Sig);

Index = [1 : SigN];
for i = 1 : RefN - SigN;
  Err(i) = var(Ref(Index + i - 1) - Sig);
end

[MinErr,OffSet] = min(Err);

X = [-1 0 1];
Frac = EstPeakQuadReg(Err(OffSet + X));

Shift = OffSet + Frac;