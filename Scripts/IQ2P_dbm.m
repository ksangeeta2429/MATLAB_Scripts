% this script only used in visualize (called by plotSpect), not in feature
% computation (File2Feature)

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


% dcI = 2044;
% dcQ = 2048;

dcI = median(I);
dcQ = median(Q);

% step=128;
% dc_I = zeros(N,1);
% dc_Q = zeros(N,1);
% dc_I(1:step) = median(I);
% dc_Q(1:step) = median(Q);
% for i=step+1:N
%     dc_I(i) = median(I(i-step:i-1)); 
%     dc_Q(i) = median(Q(i-step:i-1));
% end

Comp= (I-dcI) + 1j*(Q-dcQ);


% by testing, I know that P is in fact abs(S).^2/25238
% except the top and bottom frequency: these two, the factor becomes 50476
% -2/19/2015

[S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,NFFT,sampRate);    
% S=spectrogram_nohamming(Comp,WINDOW,NOVERLAP,NFFT,sampRate);  
% P=abs(S).^2;


                     
F=F-sampRate/2;
% F=zeros(1,WINDOW)
% T=zeros(1,fix((length(I)-NOVERLAP)/(WINDOW-NOVERLAP)));


P=[P(NFFT/2+1:NFFT,:);     
   P(1:NFFT/2,:)];                                                      
P_dbm=10*log10(abs(P)+eps);  
