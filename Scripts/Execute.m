
% clc; close all; clear all

% gamma bigger, the exp(-gamma*x) curve is more curly,otherwise more
% straight

SetEnvironment
SetPath

%path_data_human = strcat(g_str_pathbase_data,'\training\test_human_onedata'); %REPLACE: human - 406
%path_data_dog   = strcat(g_str_pathbase_data,'\training\test_dog_onedata'); %REPLACE: ball - 408

% Index = [17,18,19,20]; %205 246
% data_human = {'\IPSNdata\loc_17','\IPSNdata\AveryPark_18','\IPSNdata\NearForest_19','NIL'};
% data_dog = {'NIL','NIL','NIL','\IPSNdata\RadarPendulumData-ParkingLot_20'};



% Index = [3]; %205 246
% data_human = {'\IPSNdata\kh_3\Human'};
% data_dog = {'\IPSNdata\kh_3\Dog'};

% Index = [6,7,8,9,10,11];
% data_human = {'\IPSNdata\9603_6','\IPSNdata\Glacier_Ridge_7','\IPSNdata\Ballantrae_8','\IPSNdata\Coffman_9','\IPSNdata\ceiling_238_10\Human','NIL'};
% data_dog =   {'NIL',             'NIL',                      'NIL',                   'NIL',                '\IPSNdata\ceiling_238_10\Dog',  '\IPSNdata\dog_cut_11'};

% Index = [11,10,9,8,7,6];
% data_human = {'NIL',                 '\IPSNdata\ceiling_238_10\Human','\IPSNdata\Coffman_9','\IPSNdata\Ballantrae_8','\IPSNdata\Glacier_Ridge_7','\IPSNdata\9603_6'};
% data_dog =   {'\IPSNdata\dog_cut_11','\IPSNdata\ceiling_238_10\Dog',  'NIL',                'NIL',                   'NIL',                      'NIL'};

% Index = [12,13,14,15,16,17,18,19,20];
% data_human = { 'NIL'                , '\IPSNdata\kwon_milling_13', '\IPSNdata\r012_14', 'NIL'                      , '\IPSNdata\BryanPark_16', '\IPSNdata\loc_17', '\IPSNdata\AveryPark_18', '\IPSNdata\NearForest_19', 'NIL'};
% data_dog =   { '\IPSNdata\gudiya_12', 'NIL'                      , 'NIL'              , '\IPSNdata\rambling_rmc_15', 'NIL'                   , 'NIL'             , 'NIL'                   , 'NIL'                    , '\IPSNdata\RadarPendulumData-ParkingLot_20'};

%Index = [13,14,15,16,17,18,19,20];
%data_human = { '\IPSNdata\kwon_milling_13', '\IPSNdata\r012_14', 'NIL'                      , '\IPSNdata\BryanPark_16', '\IPSNdata\loc_17', '\IPSNdata\AveryPark_18', '\IPSNdata\NearForest_19', 'NIL'};
%data_dog =   { 'NIL'                      , 'NIL'              , '\IPSNdata\rambling_rmc_15', 'NIL'                   , 'NIL'             , 'NIL'                   , 'NIL'                    , '\IPSNdata\RadarPendulumData-ParkingLot_20'};

% Index = [20,19,18,17,16,15,14,13,12];
% data_human = {  'NIL'                                     , '\IPSNdata\NearForest_19', '\IPSNdata\AveryPark_18', '\IPSNdata\loc_17', '\IPSNdata\BryanPark_16', 'NIL'                      , '\IPSNdata\r012_14', '\IPSNdata\kwon_milling_13', 'NIL' };
% data_dog =   { '\IPSNdata\RadarPendulumData-ParkingLot_20', 'NIL'                    , 'NIL'                   , 'NIL'             , 'NIL'                   , '\IPSNdata\rambling_rmc_15', 'NIL'              , 'NIL'                      , '\IPSNdata\gudiya_12' };

%% Final set - uncomment block when not running a test extraction
% Index = [11302011,4,9,10,11,19,18,17,16,15,14,13,12,5,1,2,3,8,5152011,5162011];
% data_human = { '\IPSNdata\11-30-2011\Human\cut' , '\IPSNdata\bv_4\Human', '\IPSNdata\Coffman_9', '\IPSNdata\ceiling_238_10\Human', 'NIL',                  '\IPSNdata\NearForest_19', '\IPSNdata\AveryPark_18', '\IPSNdata\loc_17', '\IPSNdata\BryanPark_16', 'NIL' ,                      'NIL',               '\IPSNdata\kwon_milling_13', 'NIL',                 '\IPSNdata\combined_5\Human', '\IPSNdata\arc_1\Human', '\IPSNdata\prb_2\Human', '\IPSNdata\kh_3\Human', '\IPSNdata\Ballantrae_8', '\IPSNdata\5-15-2011\Human\cut', 'NIL'};
% data_dog =   { 'NIL',                             '\IPSNdata\bv_4\Dog',   'NIL',                 '\IPSNdata\ceiling_238_10\Dog',   '\IPSNdata\dog_cut_11', 'NIL',                     'NIL',                    'NIL',              'NIL',                    '\IPSNdata\rambling_rmc_15', '\IPSNdata\r012_14', 'NIL',                       '\IPSNdata\gudiya_12', '\IPSNdata\combined_5\Dog',   '\IPSNdata\arc_1\Dog',   '\IPSNdata\prb_2\Dog',   '\IPSNdata\kh_3\Dog',   'NIL',                    '\IPSNdata\5-15-2011\Car\cut',   '\IPSNdata\5-16-2011\Car\cut'};

%% Test folder - comment block when not running a test extraction
% Index = [999]; %205 246
% data_human = {'\FeatureTest'};
% data_dog = {'NIL'};

%% Cow datasets
% Index = [0220161, 0220162, 0524163];
% data_human = {'NIL', 'NIL', 'NIL'};
% data_dog = {'/IPSNdata/Baltimore_cattle_Feb_20_2016/Radar_site_1_hilltop/cut', '/IPSNdata/Baltimore_cattle_Feb_20_2016/Radar_site_2_creamery/cut',...
%     '/IPSNdata/Waterman_cattle_May_24_2016/osu_farm_meadow_may24-28_2016/cut'};

%% OSU Wetlands human data
% Index = [112016];
% data_dog = {'NIL'};
% data_human = {'/IPSNdata/Wetlands_radar_data/cut'};

%% Darree Fields human and group data, and Sandeep's parking garage data
%Index = [09102016, 03232010, 03292010];
%data_dog = {'NIL', 'NIL', 'NIL'};
%data_human = {'/Darree_Fields/cut', '/Parking garage radial ortho (Sandeep)/radial/cut' , '/Parking garage radial ortho (Sandeep)/ortho/cut'};

% Index = [09102016];
% data_dog = {'NIL'};
% data_human = {'/Darree_Fields/cut'};

%% 2014.08 Bike data
 Index = [201408];
 %data_dog = {'/Human_vs_bike_training_new_detector/height1p0_256Hz/aus/'};
 %data_dog = {'/empty/'};
 %data_dog = {'/Human_vs_bike_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/Bike_558/'};
 %data_dog = {'/Human_vs_non_human_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/austere_304_cow/'};
 %data_dog = {'/IPSNdata/5-15-2011/Human'};
 %data_human = {'NIL'};
 %data_human = {'/Bike data/Oct 21 2017/humans_no_0.5/'};
 data_dog = {'/final_bike_radial_full_cuts/'};
 %data_dog = {'NIL'}
 %data_dog = {'/IPSNdata/5-15-2011/Human'};
 data_human = {'/empty/'};
 %data_human = {'/final_human_radial_full_cuts/'};
 %data_human = {'/Human_vs_non_human_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/austere_404_human/'};
 %data_human = {'/Synthetic/20180505/walking_250hz/rank5/cut/'};
 %data_human = {'/Human_vs_non_human_training_new_detector/linearmotion_walking_512hz/rank5/cut_4s_aus/'};
 %data_human = {'/Human_vs_non_human_training_new_detector/Synthetic_cut_4s_aus/'};
 %data_human = {'/Human_vs_non_human_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/final_390_human/'};
 %data_human = {'/Bike data/Oct 21 2017/cut_manual/all_humans/test2/'};
 %data_dog = {'/Bike data/Aug 9 2017/Detect_begs_and_ends/param0.9/cut/humans only radar y'};
 %data_dog = {'/Bike data/Oct 21 2017/bikes_no_0.5/'};
 %data_dog = {'NIL'};
 %data_dog = {'/IPSNdata/5-15-2011/Human'};
 %data_human = {'NIL'};
 %data_human = {'/Bike data/Oct 21 2017/humans_no_0.5/'};

%% Anomalous data
% Index = [03202017, 030230670]
% data_dog = {'/Anomalous_WLN/3-2 30670 overnight cold/cut', '/Anomalous_WLN/close zoom/cut'};
% data_human = {'NIL', 'NIL'};

% Index=[03022018]
% data_dog={'/Close zoom/Anomaly'};
% data_human={'/Close zoom/Human'};

%% Any test data, such as a single walk cut
%Index = [12345];
%data_dog = {'/Test/cow'};
%data_human = {'/Test/human'};
%% Execute.m
featureClass = 0 % use class 0 for classification features, also include

%
% these two lines put here because when the below two lines are commented
% out, without these two lines the program does not run
% nFeatures = 18;
% feature_min = zeros(1,nFeatures);
% scalingFactors=zeros(1,nFeatures);

% Comment these two lines if doing feature collection instead of data
% collection (which means build the arff file manually), for example create
% a radar77.arff in text editor and record the feature values there using
% real time classifier and display the feature value in MFDeploy

for i=1:length(Index)
    OutIndex = Index(i);
    fprintf('Processing OutIndex=%d...\n', OutIndex);
    if strcmp(data_human{i},'NIL')==1
        [feature_min, scalingFactors] = Build_arff_dog(OutIndex,0,featureClass, 0, 0, data_dog{i}); %Compute unscaled features
        %Build_arff_dog(OutIndex,1,featureClass, feature_min, scalingFactors, data_dog{i}); %Compute scaled features, cross-validate (suppressed, refer to RunResultScript_IoTDI.m)
    elseif strcmp(data_dog{i},'NIL')==1
        [feature_min, scalingFactors] = Build_arff_human(OutIndex,0,featureClass, 0, 0, data_human{i}); %Compute unscaled features (suppressed, refer to RunResultScript_IoTDI.m)
        %Build_arff_human(OutIndex,1,featureClass, feature_min, scalingFactors, data_human{i}); %Compute scaled features, cross-validate (suppressed, refer to RunResultScript_IoTDI.m)
    else
        [feature_min, scalingFactors] = Build_arff(OutIndex,0,featureClass, 0, 0, data_human{i}, data_dog{i}); %Compute unscaled features (suppressed, refer to RunResultScript_IoTDI.m)
        %Build_arff(OutIndex,1,featureClass, feature_min, scalingFactors, data_human{i}, data_dog{i}); %Compute scaled features, cross-validate (suppressed, refer to RunResultScript_IoTDI.m)
    end
    
    %% Uncomment this block to train a model
%         fileName=[g_str_pathbase_radar,'\IIITDemo\Models\human_dog_model',int2str(OutIndex),'.txt'];%,int2str(OutIndex)
%         [SV_matlab, param, gamma, rho, nRow]=Model2Matrix(fileName,length(feature_min));
%     
%         % for j=1:size(SV_matlab,1)
%         %     GenerateArrInCsharp(SV_matlab(j,:),['sv',int2str(j-1)]);
%         % end
%         Generate2DArrInCsharp(OutIndex,SV_matlab,param,gamma,rho,feature_min,scalingFactors);
%         nSV = nRow;
%     
%         % save model parameters MATLAB variables
%         str_fftsource = strcat('_',getenv('USERNAME'),'_eMote');
%     
%         str_pathbase_modelparameters = strcat(g_str_pathbase_radar,'\IIITDemo\Models\ModelParameters');
%         if exist(str_pathbase_modelparameters, 'dir') ~= 7
%             mkdir(str_pathbase_modelparameters);
%             printf('INFO: created directory %s\n', str_pathbase_modelparameters);
%         end
%         fname_modelparameter = [str_pathbase_modelparameters,'\ModelParameter',str_fftsource,num2str(OutIndex)];
%         save(fname_modelparameter,'SV_matlab','param','gamma','rho','feature_min','scalingFactors');
end

fprintf('All done!\n');
% param = GenerateArrInCsharp(param)
% feature_min = GenerateArrInCsharp(feature_min)
% scalingFactors = GenerateArrInCsharp(scalingFactors)

% DistributionOnFeature
% pause;
% FrameAndTestFiles