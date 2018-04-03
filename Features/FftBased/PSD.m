function f = PSD(Data,window,overlap,Rate,NFFT)

%h = spectrum.welch;    % Create a Welch spectral estimator. 
%Hpsd = psd(h,Comp,'Fs',300);                % Calculate the PSD 
%P=Hpsd.Data;
%freq=Hpsd.Frequencies;

[pxx,freq] = pwelch(Data,window,overlap,NFFT,Rate);
%pxx = periodogram(Comp)
%abs(fft(Comp)).^2
%P

P=[pxx(129:256);pxx(1:128)];
P_dbm=10*log10(abs(P));
freq=[freq(129:256)-Rate;freq(1:128)];


%%% for candidacy slides figure
% plot(freq,P_dbm);
% xlabel('Frequency (Hz)','FontSize', 18);
% ylabel('Power (dB)','FontSize', 18);
% set(gca,'FontSize',14);
% 
% figure;cdfplot(P_dbm);
% xlabel('Power (dB)','FontSize', 18);
% ylabel('Possibility','FontSize', 18);
% set(gca,'FontSize',14);

    
    


f = zeros(1,25);

f(1)=max(P_dbm);
f(2)=sum(P_dbm);
f(3)=sum(P_dbm.*abs(freq))/sum(P_dbm); % 1st moment of freq over psd

f(4)=quantile(P_dbm(129:256),0.05);
f(5)=quantile(P_dbm(129:256),0.1);
f(6)=quantile(P_dbm(129:256),0.2);
f(7)=quantile(P_dbm(129:256),0.3);
f(8)=quantile(P_dbm(129:256),0.4);
f(9)=quantile(P_dbm(129:256),0.5);
f(10)=quantile(P_dbm(129:256),0.6);
f(11)=quantile(P_dbm(129:256),0.7);
f(12)=quantile(P_dbm(129:256),0.8);
f(13)=quantile(P_dbm(129:256),0.9);
f(14)=quantile(P_dbm(129:256),0.95);
f(15)=quantile(P_dbm(1:128),0.05);
f(16)=quantile(P_dbm(1:128),0.1);
f(17)=quantile(P_dbm(1:128),0.2);
f(18)=quantile(P_dbm(1:128),0.3);
f(19)=quantile(P_dbm(1:128),0.4);
f(20)=quantile(P_dbm(1:128),0.5);
f(21)=quantile(P_dbm(1:128),0.6);
f(22)=quantile(P_dbm(1:128),0.7);
f(23)=quantile(P_dbm(1:128),0.8);
f(24)=quantile(P_dbm(1:128),0.9);
f(25)=quantile(P_dbm(1:128),0.95);
 
 
 


%  figure;plot(freq,P_dbm);grid on
%  xlabel('Frequency'), ylabel('Power Spectrum Magnitude (dB)');
%  title('Power Spectral Density');
%  axis([-150 150 0 60]);
end