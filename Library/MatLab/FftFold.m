function [FoldToAssend, Assend] = FftFold(N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FftFold -- Create a map and its inverse for the FFT fold.

Mid = N/2;
  
if mod(N,2) == 0 % even case
  FoldToAssend = Wrap([0 : N-1], -Mid,Mid) + Mid + 1;
  Assend = [-Mid + 1 : Mid];
else
  Assend = [-Mid + 0.5 : Mid - 0.5];
  FoldToAssend = Wrap([0 : N-1], -Mid,Mid) + Mid + 0.5;
end