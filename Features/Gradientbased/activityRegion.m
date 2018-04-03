function f=activityRegion(power,thr)

P_dbm_gray=mat2gray(power,[-60 60]);

bw=P_dbm_gray>thr;
CC=bwconncomp(bw);
num=CC.NumObjects;

f(1)=num;
end
