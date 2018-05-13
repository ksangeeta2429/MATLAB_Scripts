function [ ncut_all, time_start_all, time_stop_all, Files ] = CutFilesInFolder( dir_bbs, dir_out, sampleRate, str_cuttingAlgorithm )
%CutFilesInFolder - cut all bbs files in a directory
%
% Input:
% dir_bbs - path to folder containing bbs data files. optional. default=pwd
% dir_out - output directory to place 'cut' folder in. optional. default=pwd
% sampleRate - sample rate of bbs files. optional. default=256;
% str_cuttingAlgorithm - name of Cut* function to call. default='CutFile'
%
% Output:
% Files - names of input files.
% time_start_all - 2-row index and time of cut starts (or index if sampleRate=1)
% time_stop_all -  2-row index and time of cut stops (or index if sampleRate=1)
%
% See Also: CutFile, CutFiles, Visualize_all

%TODO: accept cell array of dir_bbs and dir_out

if nargin < 1 || exist('dir_bbs','var') ~= 1 || isempty(dir_bbs)
    warning('Expected input argument dir_bbs containing char path.');
    dir_bbs = pwd;
end

if nargin < 2 || exist('dir_out','var') ~= 1 || isempty(dir_out)
    dir_out = pwd;
end

if nargin < 3 || exist('sampleRate','var') ~= 1 || isempty(sampleRate)
    sampleRate = 256;
end

if nargin < 4 || exist('str_cuttingAlgorithm','var') ~= 1 || isempty(str_cuttingAlgorithm)
    str_cuttingAlgorithm = 'CutFile';
end

fh_cuttingAlgorithm = str2func(str_cuttingAlgorithm);

if exist(dir_bbs,'dir') ~= 7
    error('input directory does not exist.');
end

if exist(dir_out, 'dir') ~= 7
    error('output directory does not exist.');
end

cut_folder = [ dir_out filesep 'cut' ];
if exist(cut_folder, 'dir') ~= 7
    mkdir(cut_folder);
    if exist(cut_folder,'dir') ~= 7
        error( [ 'Could not create output directory. ' ...
            'Ensure parent folder exists and MATLAB has permissions. '
            cut_folder ] );
    else
        fprintf('INFO: created directory %s\n', cut_folder);
    end
end


fileFullNames=dir(dir_bbs);
Files={};  % first 2 file is '.' and '..'
Paths = cell(0);
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    p = fileFullNames(j).folder;
    %% Also change line# 17-18 in CutFile.m
    k=strfind(s,'.bbs');
    if ~isempty(k) && k>=2 && k+3==length(s)
        Files{i}=s(1:k-1);
        Paths{i} = p;
        i=i+1;
    end
end

ncut_all = cell(1,length(Files));
time_start_all = cell(1,length(Files));
time_stop_all = cell(1,length(Files));
for i=1:length(Files) % take every file from the set 'Files'
    disp( [ 'Processing file ' num2str(i) ' of ' num2str(length(Files)) ] );
    fileName=Files{i};
    filePath = Paths{i};
    disp( fileName );
    [ncut, idx_start, idx_stop] = fh_cuttingAlgorithm(fileName, filePath, dir_out);
    time_start = idx_start / sampleRate;
    time_stop  = idx_stop  / sampleRate;
    ncut_all{1,i} = ncut;
    time_start_all{1,i} = time_start;
    time_stop_all{1,i} = time_stop;
% % DEBUG:
%     disp(allstarts);
%     disp(allstops);
%     for itr=1:ncut
%         disp( [ num2str(itr, '%d') ' ' ...
%             num2str(idx_start(1,itr),'%d') ' '  num2str(idx_stop(1,itr),'%d') ' ' ...
%             num2str(time_start(1,itr),'%d') ' ' num2str(time_stop(1,itr),'%d') ] );
%     end
end
