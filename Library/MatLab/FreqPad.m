function OutFreq = FreqPad(InFreq, OutN)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FreqPad -- Zero pad in the frequency domain
%
%   InFreq -- The unpadded frequency with  an FFT ordering.
%
%   OutN -- The number of samples in the padded freqency.  Which
%     is also ordered wiht an FFT ordering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InN = length(InFreq);

Mid = floor(InN/2);
if (rem(InN,2) == 1) %% is odd
  OutFreq([0 : Mid] + 1) = InFreq([0 : Mid] + 1);
  OutFreq([Mid + 1 : OutN - Mid - 1] + 1) = 0;
  OutFreq([OutN - Mid : OutN - 1] + 1) = ...
    InFreq([InN - Mid : InN - 1] + 1);
  
else %% is even
  OutFreq([0 : Mid - 1] + 1) = InFreq([0 : Mid - 1] + 1);
  OutFreq(Mid + 1) = InFreq(Mid + 1) / 2;
  
  OutFreq([Mid + 1 : OutN - Mid - 1] + 1) = 0;
  
  OutFreq(OutN - Mid + 1) = InFreq(Mid + 1) / 2;
  OutFreq([OutN - (Mid - 1) : OutN - 1] + 1) = ...
    InFreq([InN - (Mid - 1) : InN - 1] + 1);
  
end