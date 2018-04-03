function f=FeatureClass3_5(P_dbm,sigma,thr)     % Gradient features
%root='C:/Users/heji/Dropbox/MyMatlabWork/';
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/gaussgradient']);

f=zeros(1,1);

P_dbm_gray=mat2gray(P_dbm,[-60 60]);

[imx,imy]=gaussgradient(P_dbm_gray,sigma);
mat=abs(imx)+abs(imy);

bw=mat>thr;
CC=bwconncomp(bw);
num=CC.NumObjects;

f(1)=num;

%3.5 is 3.2 change x->y+x