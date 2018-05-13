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

% problem: unwrapped phase should start at zero.  adding Start phase will
% cause displacement to be off by (Start phase * wavelength), or whatever
% is used in lieu of wavelength for numerical stability. So for
% displacement detector, high starting phase could give advantage to some
% files. - MAM 2018-05-12.
