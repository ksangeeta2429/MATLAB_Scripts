% Input: file name
% Do: draw PSD 

function plotPSD(fileName,plotOffset)
data = ReadBin(fileName);
data=data(1+plotOffset:18000+plotOffset);       % only display 1 frame
[I,Q,N]=Data2IQ(data);

Comp=(I-median(I))+i*(Q-median(Q));
h = spectrum.welch;    % Create a Welch spectral estimator. 
Hpsd = psd(h,Comp,'Fs',300);                % Calculate the PSD 
P=Hpsd.Data;
freq=Hpsd.Frequencies;
P=[P(129:256);P(1:128)];
P_dbm=10*log10(abs(P));
freq=[freq(129:256)-300;freq(1:128)];

plot(freq,P_dbm);grid on
xlabel('Frequency'), ylabel('Power Spectrum Magnitude (dB)');
title('Power Spectral Density');
axis([-150 150 0 60]);
