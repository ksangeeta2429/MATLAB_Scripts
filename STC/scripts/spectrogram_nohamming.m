function s = spectrogram_nohamming(X,WINDOW,NOVERLAP,NFFT,Fs)
nx = length(X);
ncol = fix((nx-NOVERLAP)/(WINDOW-NOVERLAP));
colindex = 1 + (0:(ncol-1))*(WINDOW-NOVERLAP);
rowindex = (1:WINDOW)';
xin = zeros(WINDOW,ncol);
xin(:) = X(rowindex(:,ones(1,ncol))+colindex(ones(WINDOW,1),:)-1);

%% no hamming !!
% win=hamming(nwind);
% win(:,ones(1,ncol));
% xin = win(:,ones(1,ncol)).*xin;

% tmp1 = xin(:,1);
% GenerateArrInCsharp(tmp1,'fftinput')
s = fft(xin,NFFT);
% tmp2 =s(:,1);
% GenerateArrInCsharp(tmp2,'fftonput')

