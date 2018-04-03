function f=FeatureClass3_7(P_dbm,sigma,thr)     % Gradient features
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/gaussgradient']);

f=zeros(1,1);

P_dbm_gray=mat2gray(P_dbm,[-60 60]);

[imx,imy]=gaussgradient(P_dbm_gray,sigma);
mat=(imx.^2+imy.^2).^0.5;     % change to mean square root

bw=mat>thr;
CC=bwconncomp(bw);
num=CC.NumObjects;

f = zeros(1,1);
f(1)=num;