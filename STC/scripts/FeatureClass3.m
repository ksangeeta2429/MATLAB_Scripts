% input a matrix: matrix sum_P_dbm sum_P_dbm, quantile
% output a vector: 8 features

function f=FeatureClass3(P_dbm, S)        % sum_P_dbm,sum_P_dbm_thr,quan);
sum_P_dbm=sum(P_dbm);
max_P_dbm=max(P_dbm);

f(1)=median(sum_P_dbm);
f(2)=var(sum_P_dbm);
f(3)=max(sum_P_dbm);
f(4)=min(sum_P_dbm);
f(5)=quantile(sum_P_dbm,0.95);
f(6)=quantile(sum_P_dbm,0.05);


f(7)=sum(median(P_dbm,2));
f(8)=median(median(P_dbm,2));
f(9)=sum(std(P_dbm,0,2));
f(10)=median(std(P_dbm,0,2));

f(11)=mean(mean(S));
f(12)=var(var(S));




% f(1)=median(sum_P_dbm);
% f(2)=var(sum_P_dbm);                                                       
% f(3)=quantile(sum_P_dbm,quan);
% f(4)=quantile(sum_P_dbm,1-quan);
% 
% f(5)=median(sum_P_dbm_thr);
% f(6)=var(sum_P_dbm_thr);                                                       
% f(7)=quantile(sum_P_dbm_thr,quan);
% f(8)=quantile(sum_P_dbm_thr,1-quan);

