%% function CutFile_Manual_RadarAlgorithmGraph

% Cuts input data file manually, using detect_beginnings and detect_ends files output from the C# app ReadRadarAlgorithmGraph
% (https://dhruboroy29@bitbucket.org/dhruboroy29/wwf-baseline-classifier.git, commit# 899402cc6d61620a0cf3faa81a770d264107a0c9 [899402c])
% For access to this repository, contact Dhrubojyoti Roy (royd@cse.osu.edu)
% Optional arguments: min_length_secs: (minimum allowed walk length, in seconds
%                     cutoff_halfsecs: Cutoff time instant (in half seconds) beyond which walks should no longer be considered

function nCuttedFiles=CutFile_Manual_RadarAlgorithmGraph(fileName,walk_beg_file,walk_end_file,min_length_secs, cutoff_halfsecs)

% Defaults
if nargin == 3
    min_length_secs = 0;
    cutoff_halfsecs = 999999;
end

% Get file path
filePath_tmp = strrep(fileName,'\','/');
pathIndex = strfind(filePath_tmp,'/');
if isempty(pathIndex) % If unqualified filename
    filePath = './';
else
    filePath = filePath_tmp(1:pathIndex(end));
end

% Get file name without extension
fileExtBbsIndex = strfind(filePath_tmp, '.bbs');
fileExtDataIndex = strfind(filePath_tmp, '.data');

if isempty(fileExtBbsIndex) && ~isempty(fileExtDataIndex)
    fileExtIndex = fileExtDataIndex(1);
elseif ~isempty(fileExtBbsIndex) && isempty(fileExtDataIndex)
    fileExtIndex = fileExtBbsIndex(1);
else
    error('Error: Input data file extensions can be .bbs or .data only')
end

fileNameOnly = filePath_tmp(pathIndex(end)+1:fileExtIndex-1);

%Create cut folder if it doesn't exist already
%cut_folder = [filePath,'/cut'];
cut_folder = [filePath,'cut/c2/r3/']; %disp(cut_folder);
if exist(cut_folder, 'dir') ~= 7
    mkdir(cut_folder);
    fprintf('INFO: created directory %s\n', cut_folder);
end

[I,Q,N]=Data2IQ(ReadBin([fileName]));

walk_begs = dlmread(walk_beg_file);
walk_ends = dlmread(walk_end_file);

walk_begs = round(walk_begs,1);
walk_ends = round(walk_ends,1);
%walk_begs = uint64(walk_begs);
%walk_ends = uint64(walk_ends);

%disp(walk_begs(3)); disp(walk_ends(3));

%walk_lengths = (walk_ends - walk_begs)/2; % since unit is half-seconds
walk_lengths = (walk_ends - walk_begs); % if unit is in seconds
%disp(walk_lengths);
start = walk_begs(walk_lengths > min_length_secs & walk_begs < cutoff_halfsecs)*250; %use 125 if unit is half sec
stop = walk_ends(walk_lengths > min_length_secs & walk_ends < cutoff_halfsecs)*250;

k=0;
for j=1:length(start)
    k=k+1;
    I_cut = I(start(j):stop(j));
    Q_cut = Q(start(j):stop(j));
    Data_cut = zeros(1,2*(floor(stop(j)-start(j))+1));
    Data_cut(1:2:length(Data_cut)-1) = I_cut;
    Data_cut(2:2:length(Data_cut)) = Q_cut;
    WriteBin([cut_folder,fileNameOnly,'_cut',num2str(j),'.data'],Data_cut);
    %WriteBin(['/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Aug 9 2017/Detect_begs_and_ends/param0.9/cut/bikes humans radar z/',fileName,'_cut',num2str(j),'.data'],Data_cut);

end

nCuttedFiles = length(start);
