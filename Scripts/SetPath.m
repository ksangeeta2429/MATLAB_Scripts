% SetPath.m
% Adds standard set of script paths to MATLAB's path.
% See also SETENVIRONMENT
% Michael McGrath, 2015-10-16

%% early return. comment out if something breaks.
if exist('g_path_is_set','var') == 1
    if g_path_is_set == true
        return
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
else
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/Scripts'));
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/Scripts/matlab2weka'));
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/Features'));
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/Features/VelocityBased'));
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/Features/PhaseBased'));
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/Features/FftBased'));
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/Features/AcclnBased'));
    addpath(strcat(g_str_pathbase_radar,'/IIITDemo/MatlabLibrary'));
    addpath(strcat(g_str_pathbase_radar,'/eMote_scripts'));
    addpath(strcat(g_str_pathbase_radar,'/Haar Features'));
end

g_path_is_set = 1;