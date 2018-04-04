close all;
fileName='369_35p_class_lb';
path_data='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/data files/new_radar_dataset/full';
% path_data='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\data files\candidacy';
cd(path_data);
data=ReadBin(fileName);
nSample=length(data)/2;
I=data(1:2:nSample-1);
Q=data(2:2:nSample);

f=FeatureClass9_1(I,Q);