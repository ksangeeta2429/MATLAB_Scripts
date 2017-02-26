function OutData = UpSamp(InData, OutN)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FreqPad -- Zero pad in the frequency domain
%
%   InFreq -- The unpadded frequency with  an FFT ordering.
%
%   OutN -- The number of samples in the padded freqency.  Which
%     is also ordered wiht an FFT ordering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InN = length(InData);

InTrans = fft(InData);
OutTrans = FreqPad(InTrans, OutN);

Scale = OutN/InN;
OutData = Scale * real(ifft(OutTrans));