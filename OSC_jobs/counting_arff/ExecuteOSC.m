% Note: paper figures are generated by the following scripts:
% Fig. 1: Superposition of Two Complex Signals - PlotSuperposition.m
% Fig. 4: Superposition Motivates Gradient Based Feature - PlotSuperposition1.m
% Fig. 5-7: Visualize.m -> plotSpect.m, corresponding to figure 3 4 6
% Fig. 8: Mean Absolute Error vs Correlation Coefficient across Parameter
% Space - GridSearchParaForSVR.m
% Fig. 9: SVR Estimate vs True People Count  &
% Fig. 10: Mean Absolute Error vs True People Count - Statistics.m. In paper
% it is an earlier version, not the newest version, for sake of make the
% figure 10 look better.
% Fig. 11: Correlation Coefficient vs Frame Length, 
% Fig. 12: Mean Absolute Error vs Frame Length - plotFrameLengthInfluence.m
% radar89.arff is the best, should not replace it!!!!!

addpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts/STC/'));
addpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts/Features/'));
addpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts/Haar Features/'));

dpath = {'/users/PAS1090/osu10640/box.com/MATLAB_Scripts/JAR_files/weka.jar'};
javaclasspath('-v1');
javaclasspath(dpath);

g_str_pathbase_data = '/users/PAS1090/osu10640/box.com/Data_Repository/';

data_bike = '/Human_vs_bike_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/Bike_558/';
data_human = '/Human_vs_non_human_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/austere_404_human/';

ifTrain = 0; USE_CLASSIFICATION_FEAT = 0;
data_all = '/final_both_radial_full_cuts/';
%data_all = '/final_both_full_cuts/';
%data_all = '/final_bike_full_cuts/';
%data_all = '/final_bike_radial_full_cuts/';

output_arff = strcat(g_str_pathbase_data,data_all,'counting');
%output_arff = strcat(g_str_pathbase_data,'/data_with_count/','counting');
%output_arff = data_all;
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
%addpath([root,'radar/STC/scripts/matlab2weka']);
%addpath([root,'radar/STC/scripts']);

ClassDef=2;
ifReg=1;

ifTrimsample=0;

result=cell(1,1000);

%commented by neel
%path_data=[root,'radar/STC/data files/new_radar_dataset/full'];

path_data = strcat(g_str_pathbase_data,data_all);	%added by neel
%path_data = data_all;


% path_data='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\data files\candidacy\tmp';
OutIndex=501;
%secondsPerFrame=80;  % 160
secondsPerFrame=1;
fClass=[3.7 5.23 8.2 9.1];  % 
[feature_min scalingFactors]=Build_arff(root,OutIndex,0,fClass,0,0,ClassDef,ifReg,path_data,secondsPerFrame,ifTrimsample, output_arff,ifTrain,USE_CLASSIFICATION_FEAT);
%Build_arff(root, OutIndex,1, fClass, feature_min, scalingFactors,ClassDef, ifReg, path_data,secondsPerFrame,ifTrimsample, output_arff,ifTrain,USE_CLASSIFICATION_FEAT);

% convertSVRModelToCSharp


% c=20;
% omega=0.10;
% sigma=200;
% 
% OutIndex=95
% result{OutIndex}=Crossval_new(root, OutIndex,ifReg,c,omega,sigma)
% 
% OutIndex=96
% result{OutIndex}=Crossval_new(root, OutIndex,ifReg,c,omega,sigma)
% 
% OutIndex=99
% result{OutIndex}=Crossval_new(root, OutIndex,ifReg,c,omega,sigma)
% 
% OutIndex=97
% result{OutIndex}=Crossval_new(root, OutIndex,ifReg,c,omega,sigma)





%fClass=[3.7 5.23 8.2 9.1];
% %tmp=[30 80 120];  % 200 160 120 100 90 80 70 60 40 20
% %for i=1:length(tmp)
%     %secondsPerFrame=tmp(i);
%     OutIndex=100+i;
%     result{OutIndex}=Build_arff(root, OutIndex, fClass, ClassDef, ifReg, path_data,secondsPerFrame,ifTrimsample);
% %end
    



% class=0;
% offset=1;
% ifReg=1;
% ClassDef=2;
%Execute_rep;




