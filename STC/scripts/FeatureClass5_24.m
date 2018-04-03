function f=FeatureClass5_24(P_dbm,thr) % absolute threshold
bw=P_dbm>thr;
CC=bwconncomp(bw);
num=CC.NumObjects;

f=zeros(1,1);
f(1)=num;