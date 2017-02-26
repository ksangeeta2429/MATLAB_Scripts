function FreqOut = FftFreqTrunc(FreqIn, OutN)

InN = length(FreqIn);
Mid = floor(OutN/2);

if (rem(InN,2) == 1) %% is odd
  FreqOut([0 : Mid] + 1) = FreqIn([0 : Mid] + 1);
  FreqOut([OutN - Mid : OutN - 1] + 1) = ...
    FreqIn([InN - Mid : InN - 1] + 1);
  
else %% is even
  FreqOut([0 : Mid - 1] + 1) = FreqIn([0 : Mid - 1] + 1);
  FreqOut(Mid + 1) = FreqIn(Mid + 1) + FreqIn(InN - Mid);
  FreqOut([OutN - (Mid - 1) : OutN - 1] + 1) = ...
    FreqIn([InN - (Mid - 1) : InN - 1] + 1);
  
end