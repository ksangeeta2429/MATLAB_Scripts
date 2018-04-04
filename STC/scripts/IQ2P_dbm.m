function [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate)

for t=2:length(I)-1
    if abs(I(t)-I(t-1))>400 && abs(I(t)-I(t+1))>400 && abs(I(t-1)-I(t+1))<200
        I(t)=0.5*(I(t-1)+I(t+1));
    end
end

for t=2:length(Q)-1
    if abs(Q(t)-Q(t-1))>400 && abs(Q(t)-Q(t+1))>400 && abs(Q(t-1)-Q(t+1))<200
        Q(t)=0.5*(Q(t-1)+Q(t+1));
    end
end

Comp = (I-median(I)) + i*(Q-median(Q));
Comp = padSignalWithZeros(Comp,WINDOW,NOVERLAP,NFFT,sampRate);
[S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,NFFT,sampRate); 
% S = spectrogram_nohamming(Comp,WINDOW,NOVERLAP,NFFT,sampRate);%change to nohamming in 10/24/2014      
                     
F=F-sampRate/2;                       
P=[P(NFFT/2+1:NFFT,:);     
   P(1:NFFT/2,:)];                                                      
P_dbm=10*log10(abs(P)+eps);  
