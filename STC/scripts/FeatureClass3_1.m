%P_dbm_sum statistics

function f=FeatureClass3_1(P_dbm)
f=[];
% peak_intensity=quantile(P_dbm(:),0.95);
% thr=peak_intensity*0.8;


thr=median(P_dbm(:))+2*std(P_dbm(:));
P_dbm_thr=(P_dbm>thr).*P_dbm;
P_dbm_sum=sum(P_dbm_thr);

% f(1)=sum(P_dbm_sum);
% f(2)=max(P_dbm_sum);
% f(3)=min(P_dbm_sum);
% f(4)=mean(P_dbm_sum); 
% f(5)=var(P_dbm_sum); 


% f(4)=skewness(P_dbm_sum); 
% f(5)=kurtosis(P_dbm_sum);  

[n,xout]=hist(P_dbm_sum,0:10:1000);  
f=n;