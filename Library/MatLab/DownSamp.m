function OutData = DownSamp(InData, OutN)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DownSamp -- Truncate in the frequency domain
%
%   OutN -- The number of samples in the padded freqency.  Which
%     is also ordered wiht an FFT ordering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InN = length(InData);

InTrans = fft(InData);
OutTrans = FreqDrop(InTrans, OutN);

Scale = 1;
OutData = Scale * real(ifft(OutTrans));