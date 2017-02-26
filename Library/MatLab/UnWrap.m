function UnPhase = UnWrap(WrapPhase, Min,Max)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UnWrap -- Unwraps the phase for one vector.

Diff = diff(WrapPhase);
WrapDiff = Wrap(Diff, Min,Max);

Start = WrapPhase(1);
if (size(WrapPhase,1) == 1) %% Row vector
  UnPhase = [Start, cumsum(WrapDiff) + Start];
elseif (size(WrapPhase,2) == 1) %% Column vector
  UnPhase = [Start; cumsum(WrapDiff) + Start];
else
  ERROR('UnWrap works on one vector at a time.')
end