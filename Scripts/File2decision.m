% function class = File2decision(fileName,fileName_model)
clc;

OutIndex = 26;
featureClass = 0;

% run this for build scaling
% factors, should run one time before repeated run this script for
% multiple times and then can comment this line to save time


%[~, ~, ~, feature_min, scalingFactors] = Build_arff(OutIndex,0,featureClass, 0, 0)
% should remember to change FIle2Feature first before run this, and after run this, change back.



cd ('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Dog');
fileName='.\cut\dog-across_cut';   % target1_1_7

% meanI = 2047;
% meanQ = 1924;
f_file = File2Feature(fileName, '', 0, featureClass, 0,0);
f = cell2mat(f_file)
% f_file = File2Feature(fileName, '', 1, featureClass, feature_min, scalingFactors);
% f = cell2mat(f_file)

% dummy test
% f(1:6) = [35102 12832 6598 221.31603624700801448 9.39153136425602496 3.89298524598416400];
% f=(f-feature_min).*scalingFactors;




%%%%% use model
% fileName_model = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Scripts\human_car_model';  % - Copy.txt
% [sv, param, gamma, rho]=Model2Matrix(fileName_model,18);
% 
% decision=0;
% for i=1:size(sv,1)
%     decision = decision + param(i)*exp(-gamma*sum((f - sv(i,:)).^2));
% end
% decision = decision-rho;
% 
% class=0;
% if (decision>0) class=1;
% else class=2;
% end
% class
% decision