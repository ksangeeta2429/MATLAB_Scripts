function [T, Spread, Rot] = PhaseSpread(PartVals, Freq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PhaseSpread -- Computes phase spread from part values.

CP = 6e-12;
CB = 16e-12;

[R30,R10,R9,C13] = Split(PartVals);

Tau = ParRes(R30, R10, R9) * C13;

LimRatio00 = ParRes(R10,R9) / (R30 + ParRes(R10,R9));
LimRatio01 = R9 / (ParRes(R30, R10) + R9);
LimRatio10 = R10 / (ParRes(R30, R9) + R10); 
LimRatio11 = 1;

T = Tau * -log(1/2);
T00 = Tau * -log(0.5 * LimRatio00);
T01 = Tau * -log(0.5 * LimRatio01);
T10 = Tau * -log(0.5 * LimRatio10);
T11 = Tau * -log(0.5 * LimRatio11);

Spread = [T00, T01, T10, T11];

Period = 1/Freq;
Rot = (Spread - Spread(1)) ./ Period;

fprintf('%.3f  ', Rot);
fprintf('\n');