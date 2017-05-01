%% InfoGains and InfoGainMAD training

MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 1),01); % Datasets single environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),02); % Datasets 2-combo environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),03); % Datasets 3-combo environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),04); % Datasets 4-combo environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),05); % Datasets 5-combo environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),06); % Datasets 6-combo environments

%% mRMR_D and mRMR_MAD_D training

MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 1),01); % Datasets single environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),02); % Datasets 2-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),03); % Datasets 3-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),04); % Datasets 4-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),05); % Datasets 5-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),06); % Datasets 6-combo environments

%% NOT DOING THESE ANYMORE - CrossEnvironment validation re-training after above scripts are run
% MASS_CrossEnv_Validation_script(2,[10 15 20 25 30 35 40]);
% MASS_CrossEnv_Validation_script(3,[10 15 20 25 30 35 40]);
% MASS_CrossEnv_Validation_script(4,[10 15 20 25 30 35 40]);
MASS_CrossVal_10foldstats_script(2,[10 15 20 25 30 35 40]);
MASS_CrossVal_10foldstats_script(3,[10 15 20 25 30 35 40]);
MASS_CrossVal_10foldstats_script(5,[10 15 20 25 30 35 40]);
MASS_CrossVal_10foldstats_script(4,[10 15 20 25 30 35 40]);

%% CrossEnvironment testing after above scripts are run

MASS_TestEnvs_script(2,[10 15 20 25 30 35 40],'crossval');
MASS_TestEnvs_script(3,[10 15 20 25 30 35 40],'crossval');
MASS_TestEnvs_script(4,[10 15 20 25 30 35 40],'crossval');
MASS_TestEnvs_script(5,[10 15 20 25 30 35 40],'crossval');

%% Aggregate results - open world
MASS_Paper_Results_Crossval(2,[10 15 20 25 30 35 40],'mRMR','prctile',10,'diff');
MASS_Paper_Results_Crossval(3,[10 15 20 25 30 35 40],'mRMR','prctile',10,'diff');
MASS_Paper_Results_Crossval(4,[10 15 20 25 30 35 40],'mRMR','prctile',10,'diff');
MASS_Paper_Results_Crossval(5,[10 15 20 25 30 35 40],'mRMR','prctile',10,'diff');

MASS_Paper_Results_Crossval(2,[10 15 20 25 30 35 40],'mRMR','prctile',10,'all');
MASS_Paper_Results_Crossval(3,[10 15 20 25 30 35 40],'mRMR','prctile',10,'all');
MASS_Paper_Results_Crossval(4,[10 15 20 25 30 35 40],'mRMR','prctile',10,'all');
MASS_Paper_Results_Crossval(5,[10 15 20 25 30 35 40],'mRMR','prctile',10,'all');

MASS_Paper_Results_Crossval(2,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'diff');
MASS_Paper_Results_Crossval(3,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'diff');
MASS_Paper_Results_Crossval(4,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'diff');
MASS_Paper_Results_Crossval(5,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'diff');

MASS_Paper_Results_Crossval(2,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'all');
MASS_Paper_Results_Crossval(3,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'all');
MASS_Paper_Results_Crossval(4,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'all');
MASS_Paper_Results_Crossval(5,[10 15 20 25 30 35 40],'InfoGain','prctile',10,'all');

%% Aggregate results - 10foldstats
%MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'mRMR','all');
MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'mRMR','all');
MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'mRMR','all');
MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'mRMR','all');

%MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'InfoGain','all');
MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'InfoGain','all');
MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'InfoGain','all');
MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'InfoGain','all');