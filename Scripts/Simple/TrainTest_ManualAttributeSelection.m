
SetEnvironment
SetPath

% round = 1014;
% round = 100;
% round = 101;
% round = 102;
% round = 103;

round = 104;

% path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/1456789'); % --Round1014
% path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/1_4_5_6_7_8_9_11'); % --Round100
path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/1_4_5_6_7_8_9_11_12'); % --Round104

path_to_combined_arff_scaled = strcat(path_to_scaled_arffs,'/combined'); % ATTENTION: You need the combined file in this folder
path_to_manual_train = strcat(path_to_combined_arff_scaled,'/ManuallySelectedAttributes');

if exist(path_to_manual_train, 'dir') ~= 7
    mkdir(path_to_manual_train);
    fprintf('INFO: created directory %s\n', path_to_manual_train);
end

path_to_test_arffs = strcat(path_to_scaled_arffs,'/test'); % ATTENTION: You need the original test files here
path_to_manual_test = strcat(path_to_test_arffs,'/ManuallySelectedAttributes');

if exist(path_to_manual_test, 'dir') ~= 7
    mkdir(path_to_manual_test);
    fprintf('INFO: created directory %s\n', path_to_manual_test);
end

% manual_features_csv = '16,39,40,41,42,44,59,60,61,62,64'; % Round1012: Jin's features other than maxAbsPhaseChangeInOneStep
% manual_features_csv = '5,6,7,10,16,21,24,44,45,52,64,74,76'; % Round1013: MAD minus velocity features (f13, f80)
% manual_features_csv = '5,6,7,10,21,24,44,45,52,64,74,76'; % Round1014 : MAD minus time and velocity features (minus f13, f16, f80) - Overall 88.57%, Outdoors 99.5%
% manual_features_csv = '5,6,7,10,13,16,21,24,44,45,52,64,74,76,80'; % Round1015: Original MAD (alpha=10) features - Overall 88%, Outdoors 100%
% manual_features_csv = '5,6,7,10,21,24,44,45,52,74,76'; % Round1016:  MAD minus time and velocity features (minus f13, f16, f80) and spectrogram feature f64 - 88.61%
% manual_features_csv = '5,6,7,10,21,24,44,45,74,76'; % Round1017: MAD minus time and velocity features (minus f13, f16, f80) and spectrogram features f64, f52 - 86.61%
% manual_features_csv = '5,6,7,10,21,24,44,45,52,74'; % Round1018: MAD minus f13, f16, f80, f64, f76 - 87.96%
% manual_features_csv = '5,6,10,21,24,44,45,52,74,76'; % Round1019: MAD minus time and velocity features (minus f13, f16, f80) and f64 and f7 - 87.72%
% manual_features_csv = '5,6,7,21,24,44,45,52,74,76'; % Round1020 (WORST): Round1016 minus f10 (most informative feature) - 82.23%

% manual_features_csv = '17,74,10,24,42,34,19,26,80,21,2,79,59,22,44'; % Round 100 (mRMRD): All animals + cattle (e11) data training
% manual_features_csv = '17,34,80,22,21,24,59,64,66,79,19,18,26,63,44'; % Round 100 (MAD 1.0): All animals + cattle (e11) data training
% manual_features_csv = '17,34,22,21,24,59,64,66,19,18,26,63,44'; % Round 101 (MAD 1.0): All animals + cattle (e11) data training minus velocity (f80) and acceleration (f79) features
% manual_features_csv = '17,34,22,21,24,59,64,66,19,18,26,44'; % Round 102 (MAD 1.0): All animals + cattle (e11) data training minus moment_sum (f63), velocity (f80) and acceleration (f79) features
%% Version Demo_1 of classifier
manual_features_csv = '17,34,22,21,24,59,64,66,19,18,26,44'; % Round 103/104 (MAD 1.0): All animals + cattle (e11) + Darree human and Sandeep's parking garage human data (e12) training minus moment_sum (f63), velocity (f80) and acceleration (f79) features
%% Version Demo_2 of classifier

%% Function body
manual_features_file_suffix = strcat('f_',strrep(manual_features_csv,',','_'));

cd(path_to_combined_arff_scaled);
fileFullNames=dir;

i=1;
Files={};
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(Files) % take every file from the set 'Files'
    infileFullName = strcat(path_to_combined_arff_scaled,'/',Files{i},'.arff');
    outfileName = strcat(path_to_manual_train,'/',Files{i},'_', manual_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, manual_features_csv);
end

clear Files fileFullNames

% Test files
cd(path_to_test_arffs);
testFileFullNames=dir;

i=1;
testFiles={};
for j=1:length(testFileFullNames)
    s=testFileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s)
        testFiles{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(testFiles) % take every file from the set 'Files'
    infileFullName = strcat(path_to_test_arffs,'/',testFiles{i},'.arff');
    outfileName = strcat(path_to_manual_test,'/',testFiles{i},'_', manual_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, manual_features_csv);
end

clear testFiles testFileFullNames

fprintf('Generating models for manually selected features\n');
fprintf('------------------------------------------------------\n');
crossval_manual = GenerateModels_IoTDI(g_str_pathbase_model, path_to_manual_train);
fprintf('------------------------------------------------------\n\n');

fprintf('Generating cross-environment validation from manually selected features\n');
fprintf('-----------------------------------------------------------------------------\n');
crossenvironment_manual = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_manual_train, path_to_manual_test);
% crossenvironment_InfoGain = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs, path_to_InfoGain_test);
fprintf('-----------------------------------------------------------------------------\n\n');