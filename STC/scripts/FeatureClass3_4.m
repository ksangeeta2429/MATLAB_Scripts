function f=FeatureClass3_4(P_dbm,sigma,thr)     % Gradient features
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/gaussgradient']);


f=zeros(1,1);
P_dbm_gray=mat2gray(P_dbm,[-60 60]);

[imx,imy]=gaussgradient(P_dbm_gray,sigma);
mat=abs(imx)+abs(imy);

bw=abs(imy)>thr; % returns matrix of size same as imy with 1 wherever value is > thr
CC=bwconncomp(bw); %finds the number of connected components in a binary image. returns a struct. 
num=CC.NumObjects;

f(1)=num;

%3.4 is 3.2 change x->y