% convert result of ProcessingSpect to [f1 f2 f3 ...], then will be called
% by FeatureExtract in a loop (change parameters get different features)

% 这一步可以跳过不要的其实

function f=ParamFeature(I, Q, WINDOW,NOVERLAP,NFFT,sampRate, thrPower,lag,sum_P_dbm,sum_P_dbm_thr,quan)


% [T F P sum_P_dbm sum_P_dbm_thr P_dbm P_dbm_thr numOfBins ...
%  expectedFreq activeFreqWidth activeFreqDist everActiveFreqWidth ...
%  xout n xout_rightmost max_n xout_peak ...  % height area_hist % xout_bg n_bg P_dbm_bg P_dbm_resid n_resid ... %height_tail area_tail length_tail ratio_tail
%  ] = ProcessingSpect(I, Q, WINDOW,NOVERLAP,NFFT,sampRate, thrPower, 0);     

%f=FeatureClass1(P);
%f=FeatureClass2(P,lag);
f=FeatureClass3(sum_P_dbm,sum_P_dbm_thr,lag,quan);









% %%%%%%%%%%%%%%% freq info included
% f(17)=mean(expectedFreq);
% f(18)=var(expectedFreq);
% f(19)=max(expectedFreq);                                                   % 3
% f(20)=min(expectedFreq);
% 
% f(21)=mean(activeFreqWidth);
% f(22)=var(activeFreqWidth);
% f(23)=max(activeFreqWidth);
% f(24)=min(activeFreqWidth);                                                % 4
% 
% f(25)=mean(activeFreqDist);
% f(26)=var(activeFreqDist);
% f(27)=max(activeFreqDist);
% f(28)=min(activeFreqDist);
% 
% f(29)=everActiveFreqWidth;
% %%%%%%%%%%%%%%%%%%%%%%%%% histogram features %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f(30)=skewness(P_dbm(:));   %                                               %%%%%% used as f(6)  5
% f(31)=kurtosis(P_dbm(:));   %
% f(32)=skewness(P_dbm_thr(:)); %
% f(33)=kurtosis(P_dbm_thr(:));
% 
% f(34)=xout_rightmost;       %
% % % f(35)=height;
% % % f(36)=area_hist;
% f(37)=max_n;
% 
% f(38)=xout_peak;


%%%%%%%% resid
% f(39)=height_tail;
% f(40)=area_tail;
% f(41)=length_tail;
% f(42)=ratio_tail;        %

%%%%%%%%%%%%%%%%%%%%%%%%% auto correlation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% spectrogram
% [ACF,lags] = autocorr(sum_P_dbm,nLags);
% f(43)=ACF(2);           %
% f(44)=ACF(3);           %
% f(45)=ACF(4);           % 
% f(46)=ACF(5);           %
% f(47)=ACF(6);           %
% 
% f(48)=ACF(10);
% f(49)=ACF(15);
% f(50)=ACF(20);
% 
% [ACF,lags] = autocorr(sum_P_dbm_thr,nLags);
% f(51)=ACF(2);
% f(52)=ACF(3);
% f(53)=ACF(4);
% f(54)=ACF(5);
% f(55)=ACF(6);
% 
% f(56)=ACF(10);
% f(57)=ACF(15);
% f(58)=ACF(20);
% 
% [ACF,lags] = autocorr(activeFreqWidth,nLags);
% f(59)=ACF(2);
% f(60)=ACF(3);
% f(61)=ACF(4);
% f(62)=ACF(5);
% f(63)=ACF(6);
% 
% f(64)=ACF(10);
% f(65)=ACF(15);
% f(66)=ACF(20);
% 
% [ACF,lags] = autocorr(activeFreqDist,nLags);
% f(67)=ACF(2);
% f(68)=ACF(3);
% f(69)=ACF(4);
% f(70)=ACF(5);
% f(71)=ACF(6);
% 
% f(72)=ACF(10);
% f(73)=ACF(15);
% f(74)=ACF(20);

%%%%%%%%%%% time domain
% [ACF,lags] = autocorr(I,nLags);
% f(75)=ACF(25);         %
% [ACF,lags] = autocorr(Q,nLags);
% f(76)=ACF(25);         %                                                   %%%%%% used as f(2) 6
% [ACF,lags] = autocorr((I.^2+Q.^2).^0.5,nLags);
% f(77)=ACF(25);         %                                                   %%%%%% used as f(3) 7 



