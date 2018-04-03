function Result = Wrap(Phase, Min,Max)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wrap -- Computes the Wrapped phase. Uses units or Rotations

if (nargin < 2)
  Result = mod(Phase + 0.5, 1) - 0.5;
else
  Result = mod(Phase - Min, Max - Min) + Min;
end    