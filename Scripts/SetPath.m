% SetPath.m
% Adds standard set of script paths to MATLAB's path.
% See also SETENVIRONMENT
% Michael McGrath, 2015-10-16

%% early return. comment out if something breaks.
if exist('g_env_is_set','var') == 1
    if exist('g_path_is_set','var') == 1
        if g_path_is_set == true
            return
        end
    end
end

%% grab global variables
SetEnvironment

%% set MATLAB path to scripts
% addpath(strcat(str_pathbase_radar,'\STC\scripts\matlab2weka')); %Mike: Jin's laptop only?
if strcmp(getenv('PBS_O_LOGNAME'),'osu8577')==1
    %% TODO: Uncomment!
    % javaaddpath('/nfs/16/osu8577/weka.jar','-end');
    % javaaddpath('/nfs/16/osu8577/libsvm.jar','-end');
    % javaaddpath('/nfs/16/osu8577/LibSVM.jar','-end');
    % javaaddpath('/nfs/16/osu8577/InfoTheoreticRanking_1.7.jar','-end');
elseif strcmp(getenv('USER'),'mcgrathm') == 1
        git_path = '/Users/mcgrathm/SDK/dhruboroy29';
        addpath(genpath([ git_path '/MATLAB_Scripts/' ]));
        rmpath(genpath([ git_path '/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/Radar/Jin' ]));
        rmpath(genpath([ git_path '/MATLAB_Scripts/STC/' ]));
        rmpath(genpath([ git_path '/MATLAB_Scripts/Deconv-Matlab/' ]));
end

g_path_is_set = 1;