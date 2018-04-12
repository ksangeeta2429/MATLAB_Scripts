function Result = Wrap(Phase)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wrap -- Computs the Wrapped phase. Uses units or Rotations

Result = mod(Phase + 0.5, 1) - 0.5;