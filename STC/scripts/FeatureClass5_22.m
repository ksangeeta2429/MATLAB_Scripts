function f=FeatureClass5_22(P_dbm,nDelta) % relative threshold, frequency variant
thr=mean(P_dbm,2)+nDelta*std(P_dbm,0,2);
bw=zeros(size(P_dbm));
for i=1:size(P_dbm,2)
    bw(:,i)=P_dbm(:,i)>thr;    
end
CC=bwconncomp(bw);
num=CC.NumObjects;

f=zeros(1,1);
f(1)=num;