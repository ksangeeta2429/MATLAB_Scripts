%% InfoGains and InfoGainMAD training

MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 1),01); % Datasets single environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),02); % Datasets 2-combo environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),03); % Datasets 3-combo environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),04); % Datasets 4-combo environments
MASS_2017_InfoGains_and_InfoGainMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),05); % Datasets 5-combo environments

%% mRMR_D and mRMR_MAD_D training

MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 1),01); % Datasets single environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 2),02); % Datasets 2-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 3),03); % Datasets 3-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 4),04); % Datasets 4-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 5),05); % Datasets 5-combo environments
MASS_2017_mRMR_and_mRMRMAD_Training(Generate_Env_Combinations([1 2 3 4 5 10], 6),06); % Datasets 6-combo environments

%% CrossEnvironment validation re-training after above scripts are run
MASS_CrossEnv_Validation_script(2,[10 15 20 25 30 35 40]);
MASS_CrossEnv_Validation_script(3,[10 15 20 25 30 35 40]);
MASS_CrossEnv_Validation_script(4,[10 15 20 25 30 35 40]);

%% CrossEnvironment testing after above scripts are run

MASS_TestEnvs_script(2,[10 15 20 25 30 35 40],'crossenv');
MASS_TestEnvs_script(3,[10 15 20 25 30 35 40],'crossenv');
MASS_TestEnvs_script(4,[10 15 20 25 30 35 40],'crossenv');

%% Aggregate results
