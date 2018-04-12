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
cost = [0.001,0.01,0.1,1,10,100,1000,10000,100000];
o = [0.1,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,100,200];
s = [0.1,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,100,200];

%only for testing purpose
%cost = [10,100,1000];
%o = [0.1,1.5,4,10,100];
%s = [0.1,4,10,200];

cd(path_arff);
fd = fopen('results.txt','a');


min_meanAbsError = 1;
best_omega = 0;
best_sigma = 0;
best_cost = 0;
error = [];
best_result = '';
for c = cost
    for omega = o
        for sigma = s
            [meanAbsError result confusionmatrix]=Crossval_new(root, OutIndex,ifReg,c,omega,sigma,path_arff);
            meanAbsError
            error = [error meanAbsError];
            if(min_meanAbsError > meanAbsError)
                min_meanAbsError = meanAbsError;
                best_cost = c; best_sigma = sigma; best_omega = omega;
                best_result = result;
            end
        end
    end
end


fprintf(fd,'--------------------------------\n');
fprintf(fd,datestr(datetime));
fprintf(fd,'\n\nBest result : \n');
fprintf(fd,'%s',best_result);
fprintf(fd,'\nBest omega : %f\n',best_omega);
fprintf(fd,'Best sigma : %f\n',best_sigma);
fprintf(fd,'Best C : %f\n',best_cost);
fprintf(fd,'--------------------------------\n');

plot(error);
ylabel('Mean Absolute Error For differnt parameter settings');
xlabel('Number of combinations of parameters');

%[result confusionmatrix]=Crossval_new(root, OutIndex,ifReg,c,omega,sigma,path_arff)

