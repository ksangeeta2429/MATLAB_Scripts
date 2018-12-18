function UnPhase = UnWrap(WrapPhase)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UnWrap -- Unwraps the phase. Uses units or Rotations

Diff = diff(WrapPhase);
WrapDiff = Wrap(Diff);

Start = WrapPhase(1);
if (size(WrapPhase,1) == 1)
  UnPhase = [Start, cumsum(WrapDiff) + Start];
else
  UnPhase = [Start; cumsum(WrapDiff) + Start];
end