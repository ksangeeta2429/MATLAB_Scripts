% input a matrix: spectrogram P
% output a vector: 1 features

function f=FeatureClass5(P_dbm_01,F,order,quan)

everActiveFreq=ones(size(P_dbm_01,1),1);
for i=1:size(P_dbm_01,2)
    moment(i)=sum(P_dbm_01(:,i).*(F.^order));  % moment: a time series
    everActiveFreq=everActiveFreq & P_dbm_01(:,i);
end
everActiveFreqWidth=sum(everActiveFreq);

f(1)=median(moment);
f(2)=var(moment);                                                       
f(3)=quantile(moment,quan);
f(4)=quantile(moment,1-quan);
f(5)=everActiveFreqWidth;



