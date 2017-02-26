function [Real, Imag] = InterToReIm(RawInter)

N = length(RawInter);

AllIndex = [2 : N-1];
ReIndex = [1 : 2 : N];
ImIndex = [2 : 2 : N];

Real = interp1(ReIndex, RawInter(ReIndex), AllIndex);
Imag = interp1(ImIndex, RawInter(ImIndex), AllIndex);