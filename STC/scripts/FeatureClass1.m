% input a matrix: spectrogram P
% output a vector: 8 features

function f=FeatureClass1(P,quan)

[tmp, index]=max(P);
P_max=quantile(P,quan);

f(1)=median(abs(index));
f(2)=var(abs(index));                                                       
f(3)=quantile(abs(index),quan);
f(4)=quantile(abs(index),1-quan);

f(5)=median(index);
f(6)=var(index);                                                       
f(7)=quantile(index,quan);
f(8)=quantile(index,1-quan);

f(9)=median(P_max);                                              
f(10)=var(P_max);
f(11)=quantile(P_max,quan);
f(12)=quantile(P_max,1-quan);


