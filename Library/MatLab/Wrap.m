function WrapPhase = Wrap(Phase, Min,Max)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wrap -- Computs the wrapped phase.

if (nargin < 2)
  WrapPhase = mod(Phase + 0.5, 1) - 0.5;
else
  WrapPhase = mod(Phase - Min, Max - Min) + Min;
end