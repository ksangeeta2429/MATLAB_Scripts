clc;
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/matlab2weka']);
addpath([root,'radar/STC/scripts']);

OutIndex = 501;  %% 89, the best one!
ifReg = 1;

% 
% c=100;
% omega=0.06;
% sigma=800;
result=cell(1,1000);
i=1;
for c=20:20:200
    for omega=0.02:0.02:0.2
        for sigma=200:200:2000
            result{i}=Crossval_new(root, OutIndex,ifReg,c,omega,sigma);
            i=i+1
        end
    end
end

% 41:
% c=20;
% omega=0.10;
% sigma=200;

%result=result(12:21);


len=length(result);
%tmp=1:len;

corrCoef=zeros(1,len);
absError=zeros(1,len);

min_error=10000;
min_i=1;
for i=1:len
    i
    str=char(result{i});
    ind1=strfind(str,'Correlation coefficient');
    corrCoef(i)=str2double(str(ind1+40:ind1+46));
    ind2=strfind(str,'Mean absolute error');
    absError(i)=str2double(str(ind2+40:ind2+46));
    if absError(i)<min_error
        min_error=absError(i);
        min_i=i;
    end
end

% figure;plot(tmp,corrCoef);
% figure;plot(tmp,absError);
save('gridsearch_160');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('gridsearch_160'); %enable this line when replot figure
figure;plot(corrCoef, absError,'.')
xlabel('Correlation Coefficient','FontSize', 18);
ylabel('Mean Absolute Error','FontSize', 18);
set(gca,'FontSize',14);

min_error=10000;
min_i=1;
max_corr=0;
max_i=1;
for i=1:length(absError)
    if absError(i)<min_error
        min_error=absError(i);
        min_i=i;
    end
    if corrCoef(i)>max_corr
        max_corr=corrCoef(i);
        max_i=i;
    end
end
min_i
min_error
max_i
max_corr
