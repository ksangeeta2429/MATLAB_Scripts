function f=FeatureClass5_21(P_dbm,nDelta) % relative threshold, not frequency variant
thr=mean(P_dbm(:))+nDelta*std(P_dbm(:));
bw=P_dbm>thr;
CC=bwconncomp(bw);
num=CC.NumObjects;

f=zeros(1,1);
f(1)=num;