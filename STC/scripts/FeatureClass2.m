% input a matrix: spectrogram P
% output a vector: 1 features

function f=FeatureClass2(P,lag)
nLags=50;

[P_max,index]=max(P);
[ACF, Lags]=xcorr(P_max,nLags);
n=(length(Lags)-1)/2; %(1:n) Lags is (-n:n)
f(1)=ACF(n+1+lag);

[ACF, Lags]=xcorr(index,nLags);
f(2)=ACF(n+1+lag);