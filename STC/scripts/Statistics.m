% get the statistics (mean square error and correlation coefficient and others)
% and plot the figure showing the prediction vs ground truth
% 89_89 is the best


function Statistics()

addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts/matlab2weka');
addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts');

close all;clc;
fileNumTrain=89;  %89  194
fileNumTest=89; %89  194
nFeatures=631; %631  67

cd('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/arff files/');
Arff2csv(fileNumTrain,fileNumTest);
data=csvread(sprintf('radar%d_%d.csv',fileNumTrain,fileNumTest),0,nFeatures);

num_true=data(:,2);
num_est=data(:,1);

rsquare = ComputeRSquare(num_true,num_est)
ConfusionMatrix_01 = ComputeConfusionMatrix_01(num_true,num_est)

plotStat(num_true,num_est);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% after removing anomaly %%%%%%%%%%
% indexRemove=[];
% for i=2:length(number)-1
%     if number(i-1)==number(i) && number(i)==number(i+1)
%         if abs(number_pred(i)-number_pred(i-1))>4 && abs(number_pred(i)-number_pred(i+1))>4
%             indexRemove=[indexRemove i];
%         end
%     end
% end              
% number(indexRemove)=[];
% number_pred(indexRemove)=[];         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plotStat(number,number_pred);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% after average filtering %%%%%%%
% for i=2:length(number)-1
%     if number(i-1)==number(i) && number(i)==number(i+1)
%         number_pred(i)=(number_pred(i-1)+number_pred(i)+number_pred(i+1))/3;
%     end
% end
% 
% plotStat(number,number_pred);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% after average filtering %%%%%%%
% number_pred_round=round(number_pred);
% plotStat(number,number_pred_round);
% number_pred_floor=floor(number_pred);
% plotStat(number,number_pred_floor);
% number_pred_ceil=ceil(number_pred);
% plotStat(number,number_pred_ceil);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rsquare = ComputeRSquare(num_true,num_est)
    rsquare = 1-sum((num_est-num_true).^2)/(sum((num_true-mean(num_true)).^2));
end
    
function ConfusionMatrix_01 = ComputeConfusionMatrix_01(num_true,num_est)
    ConfusionMatrix_01 = zeros(2,2);
    for i=1:length(num_true)
        if num_true(i)==0 && num_est(i)<0.5
            ConfusionMatrix_01(1,1)=ConfusionMatrix_01(1,1)+1;
        end
        if num_true(i)==0 && num_est(i)>0.5
            ConfusionMatrix_01(1,2)=ConfusionMatrix_01(1,2)+1;
        end
        if num_true(i)~=0 && num_est(i)<0.5
            ConfusionMatrix_01(2,1)=ConfusionMatrix_01(2,1)+1;
        end
        if num_true(i)~=0 && num_est(i)>0.5
            ConfusionMatrix_01(2,2)=ConfusionMatrix_01(2,2)+1;
        end
    end
end
