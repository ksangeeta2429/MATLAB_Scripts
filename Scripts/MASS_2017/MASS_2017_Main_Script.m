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

%% Generating models 10fold stats for above
MASS_CrossVal_10foldstats(2,[10 15 20 25 30 35 40]);
MASS_CrossVal_10foldstats(3,[10 15 20 25 30 35 40]);
MASS_CrossVal_10foldstats(4,[10 15 20 25 30 35 40]);
MASS_CrossVal_10foldstats(5,[10 15 20 25 30 35 40]);

%% CrossEnvironment testing after above scripts are run - real environments
MASS_TestEnvs_script(2,[10 15 20 25 30 35 40]);
MASS_TestEnvs_script(3,[10 15 20 25 30 35 40]);
MASS_TestEnvs_script(4,[10 15 20 25 30 35 40]);
MASS_TestEnvs_script(5,[10 15 20 25 30 35 40]);

%% MAD feature selection with random environment splits - second argumment * 10 represents the round, last argument is the pseudorandom seed
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),2,10); % Round 20
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),3,10); % Round 30
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),4,10); % Round 40
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),5,10); % Round 50
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),6,10); % Round 60

MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),2,50); % Round 20
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),3,50); % Round 30
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),4,50); % Round 40
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),5,50); % Round 50
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),6,50); % Round 60

MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),2,100); % Round 20
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),3,100); % Round 30
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),4,100); % Round 40
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),5,100); % Round 50
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),6,100); % Round 60

MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),2,150); % Round 20
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),3,150); % Round 30
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),4,150); % Round 40
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),5,150); % Round 50
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),6,150); % Round 60

MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),2,200); % Round 20
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),3,200); % Round 30
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),4,200); % Round 40
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),5,200); % Round 50
MASS_2017_RandomSplits_MAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),6,200); % Round 60

%% Generating models 10fold stats for above
MASS_RandomSplits_CrossVal_10foldstats(20,10,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(30,10,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(40,10,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(50,10,[10 15 20 25 30 35 40]);

MASS_RandomSplits_CrossVal_10foldstats(20,50,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(30,50,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(40,50,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(50,50,[10 15 20 25 30 35 40]);

MASS_RandomSplits_CrossVal_10foldstats(20,100,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(30,100,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(40,100,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(50,100,[10 15 20 25 30 35 40]);

MASS_RandomSplits_CrossVal_10foldstats(20,150,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(30,150,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(40,150,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(50,150,[10 15 20 25 30 35 40]);

MASS_RandomSplits_CrossVal_10foldstats(20,200,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(30,200,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(40,200,[10 15 20 25 30 35 40]);
MASS_RandomSplits_CrossVal_10foldstats(50,200,[10 15 20 25 30 35 40]);

%% CrossEnvironment testing after above scripts are run - random split environments
MASS_RandomSplits_TestEnvs_script(20,10,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(30,10,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(40,10,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(50,10,[10 15 20 25 30 35 40]);

MASS_RandomSplits_TestEnvs_script(20,50,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(30,50,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(40,50,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(50,50,[10 15 20 25 30 35 40]);

MASS_RandomSplits_TestEnvs_script(20,100,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(30,100,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(40,100,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(50,100,[10 15 20 25 30 35 40]);

MASS_RandomSplits_TestEnvs_script(20,150,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(30,150,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(40,150,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(50,150,[10 15 20 25 30 35 40]);

MASS_RandomSplits_TestEnvs_script(20,200,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(30,200,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(40,200,[10 15 20 25 30 35 40]);
MASS_RandomSplits_TestEnvs_script(50,200,[10 15 20 25 30 35 40]);

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
% All environments
[med_mRMR_2, iqr_mRMR_2, ~, ~]=MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'mRMR','all');
[med_mRMR_3, iqr_mRMR_3, ~, ~]=MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'mRMR','all');
[med_mRMR_4, iqr_mRMR_4, ~, ~]=MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'mRMR','all');
[med_mRMR_5, iqr_mRMR_5, ~, ~]=MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'mRMR','all');

[med_ig_2, iqr_ig_2, ~, ~]=MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'InfoGain','all');
[med_ig_3, iqr_ig_3, ~, ~]=MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'InfoGain','all');
[med_ig_4, iqr_ig_4, ~, ~]=MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'InfoGain','all');
[med_ig_5, iqr_ig_5, ~, ~]=MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'InfoGain','all');

% "Different" environments - 1, 2, 3, and 10 can't be in the train-test
[med_mRMR_diff_2, iqr_mRMR_diff_2, ~, ~]=MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'mRMR','diff');
[med_mRMR_diff_3, iqr_mRMR_diff_3, ~, ~]=MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'mRMR','diff');
[med_mRMR_diff_4, iqr_mRMR_diff_4, ~, ~]=MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'mRMR','diff');
[med_mRMR_diff_5, iqr_mRMR_diff_5, ~, ~]=MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'mRMR','diff');

[med_ig_diff_2, iqr_ig_diff_2, ~, ~]=MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'InfoGain','diff');
[med_ig_diff_3, iqr_ig_diff_3, ~, ~]=MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'InfoGain','diff');
[med_ig_diff_4, iqr_ig_diff_4, ~, ~]=MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'InfoGain','diff');
[med_ig_diff_5, iqr_ig_diff_5, ~, ~]=MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'InfoGain','diff');

% "Similar" environments - 1, 2, 3, and 10 must be in the train-test
[med_mRMR_sim_2, iqr_mRMR_sim_2, ~, ~]=MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'mRMR','sim');
[med_mRMR_sim_3, iqr_mRMR_sim_3, ~, ~]=MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'mRMR','sim');
[med_mRMR_sim_4, iqr_mRMR_sim_4, ~, ~]=MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'mRMR','sim');
[med_mRMR_sim_5, iqr_mRMR_sim_5, ~, ~]=MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'mRMR','sim');

[med_ig_sim_2, iqr_ig_sim_2, ~, ~]=MASS_Paper_Results_10foldstats(2,[10 15 20 25 30 35],'InfoGain','sim');
[med_ig_sim_3, iqr_ig_sim_3, ~, ~]=MASS_Paper_Results_10foldstats(3,[10 15 20 25 30 35],'InfoGain','sim');
[med_ig_sim_4, iqr_ig_sim_4, ~, ~]=MASS_Paper_Results_10foldstats(4,[10 15 20 25 30 35],'InfoGain','sim');
[med_ig_sim_5, iqr_ig_sim_5, ~, ~]=MASS_Paper_Results_10foldstats(5,[10 15 20 25 30 35],'InfoGain','sim');