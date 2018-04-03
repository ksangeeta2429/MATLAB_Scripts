% Input: file name
% Do: draw histogram of spectrogram


function plotHist(fileName,WINDOW,NOVERLAP,NFFT,sampRate, plotOffset)
data = ReadBin(fileName);
data=data(1+plotOffset:18000+plotOffset);       % only display 1 frame
[I,Q,N]=Data2IQ(data);

[T F P sum_P_dbm sum_P_dbm_thr P_dbm P_dbm_thr numOfBins ...
 expectedFreq activeFreqWidth activeFreqDist everActiveFreqWidth ...
 xout n xout_rightmost max_n xout_peak ... %height area_hist    % xout_bg n_bg P_dbm_bg P_dbm_resid n_resid ... %height_tail area_tail length_tail ratio_tail
 ] = ProcessingSpect(I, Q, WINDOW,NOVERLAP,NFFT,sampRate, zeros(256,1));

bar(xout,n/sum(n));                        % histogram of P_dbm after shift 
axis([-60 80 0 0.01]);
