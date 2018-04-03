function f=FeatureClass9_11(I,Q)
% data = ReadBin('266_1p_sc_rb');
% [I,Q,N]=Data2IQ(data);

Comp=(I-median(I))+i*(Q-median(Q));
h = spectrum.welch;    % Create a Welch spectral estimator. 
Hpsd = psd(h,Comp,'Fs',300);                % Calculate the PSD 
P=Hpsd.Data;
freq=Hpsd.Frequencies;
P=[P(129:256);P(1:128)];
P_dbm=10*log10(abs(P));
freq=[freq(129:256)-300;freq(1:128)];


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
f(15)=quantile(P_dbm(129:256),0.05);
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