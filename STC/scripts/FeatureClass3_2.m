function f=FeatureClass3_2(P_dbm,sigma,thr)     % Gradient features
%root='C:/Users/heji/Dropbox/MyMatlabWork/';
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/gaussgradient']);


f=zeros(1,1);

P_dbm_gray=mat2gray(P_dbm,[-60 60]); %Values less than -60 become 0, and values greater than 60 become 1

[imx,imy]=gaussgradient(P_dbm_gray,sigma);
mat=abs(imx)+abs(imy);

bw=abs(imx)>thr; %imx > thr? Is there an error, should it be mat > thr ? -> Neel
CC=bwconncomp(bw);
num=CC.NumObjects;

% f(1)=sum(abs(imx(:)));
% f(2)=sum(abs(imy(:)));
% f(3)=sum(mat(:));
% f(4)=sum(abs(imx(find(abs(imx)>thrx))));    
% f(5)=sum(abs(imy(find(abs(imy)>thry))));
% f(6)=sum(mat(find(mat>thr)));
% f(7)=length(find(abs(imx)>thrx));
% f(8)=length(find(abs(imy)>thry));
% f(9)=length(mat(find(mat>thr)));
% 
% f(10)=max(abs(imx(:)));
% f(11)=max(abs(imy(:)));
% f(12)=max(mat(:));
% 
% f(13)=median(abs(imx(:)));
% f(14)=median(abs(imy(:)));
% f(15)=median(mat(:));
% 
% f(16)=var(abs(imx(:)));
% f(17)=var(abs(imy(:)));
% f(18)=var(mat(:));
% 
% f(19)=num;
f(1)=num;
