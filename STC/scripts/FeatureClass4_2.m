function f=FeatureClass4_2(P_dbm,n,xout,hist_thr)
[tmp, max_ind]=max(n);
hist_thr=hist_thr+(max_ind-20);   % shift the curve

xout_rightmost=xout(max(find(n~=0)));
tail_width=xout_rightmost-hist_thr;
thr_index=find(abs(xout-hist_thr)<0.01);
tail_height=median(n(thr_index-5:thr_index+5)); 
tail_area=sum(n(find(abs(xout-hist_thr)<0.01):max(find(n~=0))));
skew=skewness(P_dbm(:));

f(1)=xout_rightmost;
f(2)=tail_width;
f(3)=tail_height;
f(4)=tail_area;
f(5)=skew;