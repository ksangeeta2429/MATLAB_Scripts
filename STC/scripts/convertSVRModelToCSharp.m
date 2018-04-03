% note: at the end of line, there is two charactors that is not displayed
% for example,
% 123
% 45
% data(1)='1'
% data(2)='2'
% data(3)='3'
% data(4)= char(13)   ----- char(13) is in fact \r, char(10) is in fact \n
% but you cannot use them directly
% data(5)= char(10)
% data(6)= '4'
% data(7)= '5'
% However, the str2double function can parse a string even in it there are such empty charactors

% function [SV_matlab, param, omega, sigma, rho, nSV] = convertSVRModelToCSharp(fileName,nRow,nCol)

OutIndex = 89;

nRow = 405;
nCol = 632;


omega=0.1;
sigma=200;


cd('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\records');
fid = fopen('BestModelFor160sFrame.txt','r');
data = fread(fid,inf,'*char');
data = data';

left = strfind(data,'[');
right = strfind(data,']');
nSV = length(left);

param = zeros(1,nSV);
indexSV = zeros(1,nSV);
for i=1:nSV
    if i==1
        tmp = data(1 : left(i)-5);
        tmp(tmp==' ') = ''; % remove space
        param(i) = str2double(tmp);
    else
        tmp =  data(right(i-1)+3 : left(i)-5);
        tmp(tmp==' ') = '';
        param(i) = str2double(tmp);
    end
    indexSV(i) = str2double(data(left(i)+1 : right(i)-1));
end
tmp = data(right(nSV)+1 : length(data));
tmp(tmp==' ') = '';
rho =  - str2double(tmp);

omega
sigma
rho



cd('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\arff files');
fid = fopen('radar',num2str(OutIndex),'.arff','r');
data = fread(fid,inf,'*char');
data = data';
data = data( strfind(data,'@data')+5 : length(data));

% SV_matlab = zeros(nSV,nCol-1);
featureVector = zeros(nRow,nCol);
for i=1:nRow
    i
    for j=1:nCol-1
        commaPos = strfind(data,',');
        featureVector(i,j) = str2double(data(1 : commaPos-1));
        data = data(commaPos+1 : length(data));
    end
    
    endOfLinePos = strfind(data,char(13));
    featureVector(i,nCol) = str2double(data(1:endOfLinePos-1));
    data = data(endOfLinePos+2 : length(data));
end
        
SV_matlab=featureVector(indexSV+1,1:nCol-1); % remove the last column which is the label , +1 because indexSV are from 0
feature_min = min(SV_matlab);
feature_max = max(SV_matlab);
scalingFactors = 1./(feature_max-feature_min);

save(['SVRModel',num2str(OutIndex)])

Generate2DArrInCsharp(OutIndex,SV_matlab,param,sigma,omega,rho,feature_min,scalingFactors);
nSV = nRow

    
