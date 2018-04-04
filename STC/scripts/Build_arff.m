% input: a path of the folder, 
% do: build the arff file from the .data files which is in this folder
% output: the 10-fold crossvalidation result (if the folder only contains 1 file, 
% then there are errors happening at the validation stage, but the arff file is still successfully built, that is enough)


function [result confusionmatrix]=Build_arff(root, OutIndex, fClass, ClassDef, ifReg, path_data,secondsPerFrame,ifTrimsample,path_arff)
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
%addpath([root,'radar/STC/scripts/matlab2weka']);
%addpath([root,'radar/STC/scripts']);

% OutIndex=21;
% fClass=[5.2 3.2 8.2];%[3.2 8.2]
% ClassDef=2;
% ifReg=1;

%secondsPerFrame = 30;


%path_data=[root,'radar/STC/data files/new_radar_dataset/clean/train'];
cd(path_data);
fileFullNames=dir(path_data);

Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if k>=2
        Files{i}=s(1:k-1);
        i=i+1;
    end
end
%% display useful info
OutIndex
fClass

%saveBackground();
%% build arff file for the data set 
f_set=[];
sprintf('the total num of files is: %d',length(Files))
    % display total num of files
    
for i=1:length(Files) % take every file from the set 'Files'
    %Files{i}
    %if mod(i,10)==0 
        sprintf('%dth file is processing\n',i) % the i-th file is processing
    %end
    fileName=Files{i}; 
    f_file=File2Feature(fileName, secondsPerFrame, fClass,ifReg,ifTrimsample,ClassDef,i);
    f_set=[f_set;f_file];     
end
sprintf('the total num of features is: %d',size(f_set,2)-1)


% Not finished. Try to use custom kernel functions. Matlab embeded
% svmtrain function can customize kernel function but only work for 2 classes not multi-classes.

% obtain f_set adding last column of labels
% % % % % save(sprintf('../arff files/radar%d.mat',OutIndex),'f_set');
% % % % % Crossval_matlab(OutIndex);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('tmp');
%load('tmp');
%% Weka Related
% featureNames is f1 f2 f3 ...., give these name to the n columns of f_set
nColumn=size(f_set,2);  
featureNames=cell(1,nColumn);
for i=1:nColumn
    featureNames{i}= sprintf('f%d',i);
end

instances=matlab2weka(sprintf('radar%d',OutIndex),featureNames,f_set,nColumn,ifReg);
%% save the wekaOBJ to arff file
%path_arff=[root,'radar/STC/arff files'];
cd(path_arff);
saveARFF(sprintf('radar%d.arff',OutIndex),instances);

%% Cross Validation

c=20;
omega=0.1;
sigma=200;
[result confusionmatrix]=Crossval_new(root, OutIndex,ifReg,c,omega,sigma,path_arff)

