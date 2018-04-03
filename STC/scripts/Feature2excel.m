%close all;

numOfFeatures=100;

x=[];
y1=[];
y2=[];
y3=[];
y4=[];
y5=[];
y6=[];
y7=[];
y8=[];
y9=[];
     
ChooseFile;

for i=1:numOfFiles    
    fileName=Files{i};
    STCParse;                        %%%% TO DO %%%
end

result=[x;y1;y2;y3;y4;y5;y6;y7;y8;y9];
csvwrite('1.csv',result);


result=csvread('1.csv');

figure;plot(x,y1,'.');
title('');xaxis('');yaxis('');

% figure;plot(x,y2,'.');
% figure;plot(x,y3,'.');
% figure;plot(x,y4,'.');
% figure;plot(x,y5,'.');
% figure;plot(x,y6,'.');
% figure;plot(x,y7,'.');
% figure;plot(x,y8,'.');
% figure;plot(x,y9,'.');