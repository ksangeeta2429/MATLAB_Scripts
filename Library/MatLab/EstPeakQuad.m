function Loc = EstPeakQuad(X,Y)

[X0,X1,X2] = Split(X);
[Y0,Y1,Y2] = Split(Y);

Num = -X1^2*Y0+Y2*X1^2+Y1*X0^2-Y2*X0^2+X2^2*Y0-Y1*X2^2;
Denom = -X2*Y1+Y2*X1-X0*Y2+X0*Y1+Y0*X2-Y0*X1;
Loc = 0.5 * Num/Denom;