function Loc = EstPeakQuadReg(Y)

[Y0,Y1,Y2] = Split(Y);

% Loc = 1/2*(-Y2+Y0)/(-2*Y1+Y2+Y0);
Loc = 0.5 * (Y2 - Y0) ./ (2*Y1 - Y2 - Y0);