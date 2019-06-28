function train_row = getdata(fileName, path_dir)

addpath('/scratch/sk7898/MATLAB_Scripts/Scripts')
cd(path_dir);
[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));

%dcI = 2044;   % enable when do test on dummy data
				  %dcQ = 2048;
dcI = median(I); %median or mean
dcQ = median(Q);
Data = (I-dcI) + 1i*(Q-dcQ);

Rate=512;
FftWindow = Rate;
Nfft = Rate;
FftStep = round(1/4*FftWindow);

%DeltaF = Rate/Nfft;
%RelFreq = Wrap([0 : Nfft-1], -Nfft/2, Nfft/2);
%Freq = DeltaF * RelFreq;

%s = spectrogram(x,window,noverlap,nfft)
  S = spectrogram(Data, FftWindow, FftWindow - FftStep, Nfft);
A = abs(S);
phi = angle(S);
A = A';
phi = phi';
train_row = horzcat(A,phi);
