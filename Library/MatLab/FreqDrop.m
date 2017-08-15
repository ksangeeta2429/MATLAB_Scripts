function FreqOut = FreqDrop(FreqIn, NOut)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FreqPad -- Zero pad in the frequency domain
%
%   NOut -- The number of samples in the padded freqency.  Which
%     is also ordered wiht an FFT ordering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NIn = length(FreqIn);

Mid = floor(NOut/2);
if (rem(NOut,2) == 1) %% is odd
  FreqOut([0 : Mid] + 1) = FreqIn([0 : Mid] + 1);
  FreqOut([NOut - Mid : NOut - 1] + 1) = ...
    FreqIn([NIn - Mid : NIn - 1] + 1);
  
else %% is even
  FreqOut([0 : Mid - 1] + 1) = FreqIn([0 : Mid - 1] + 1);
  FreqOut(Mid + 1) = (FreqIn(Mid + 1) + FreqIn(NOut - Mid + 1)) / 2;
  FreqOut([NOut - (Mid - 1) : NOut - 1] + 1) = ...
    FreqIn([NIn - (Mid - 1) : NIn - 1] + 1);
  
end