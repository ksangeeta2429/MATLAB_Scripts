%% function CutFile_Manual_noise

% Extract noise from data collect (.bbs file)
% Written by neel
% Input: noiseFile - .bbs/.data file for data collect
%        eventTimes - Excel file containing two columns Start Time and End
%                    Time indication activity in the field of view.
%        Note: Times should be in HH:MM:SS format.
%              Last event should be human walking towards the radar to stop the collection.
%        sheetName : name of worksheet
%        range - range of cells to be read. Ex: 'A3:B35'. Range should only
%        contain 2 columns: start and stop times
%        sampRate - sampling rate
%        outputPath - entire path to output file
%        militaryForamt - This is a flag indicating if the input times are
%        in military format (HH:MM:SS). If it is 0, then the times are
%        expected to be in seconds (an integer).
%        givenIntervals - If this is 1, then extract data in this interval,
%        else extract data not in this interval

function nCuttedFiles=CutFile_Manual_noise(noiseFile, eventTimes, sheetName, range, sampRate, outputPath, givenIntervals, militaryFormat)

% Get file path
filePath_tmp = strrep(noiseFile,'\','/');
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
cut_folder = [filePath,'cut/']; %disp(cut_folder);
if exist(cut_folder, 'dir') ~= 7
    mkdir(cut_folder);
    fprintf('INFO: created directory %s\n', cut_folder);
end

[I,Q,N]=Data2IQ(ReadBin([noiseFile]));

[walk_begs,walk_ends] = convertTimestampsToSeconds(eventTimes,sheetName,range,militaryFormat)

%walk_begs = round(walk_begs,1);
%walk_ends = round(walk_ends,1);
%walk_begs = uint64(walk_begs);
%walk_ends = uint64(walk_ends);

%disp(walk_begs(3)); disp(walk_ends(3));

%walk_lengths = (walk_ends - walk_begs)/2; % since unit is half-seconds
walk_lengths = (walk_ends - walk_begs); % if unit is in seconds
%disp(walk_lengths);
start = []; stop = [];
for i = 1:length(walk_lengths)
    start = [start walk_begs(i)*sampRate];
    stop = [stop walk_ends(i)*sampRate];
end

start_t =[]; stop_t = [];
for i = 1:length(start)
    start_t = [start_t int32(start(i))];
    stop_t = [stop_t int32(stop(i))];
end
start;
stop;
start_t;
stop_t;
start = start_t;
stop = stop_t;

data = [];
k=0;
for j=1:length(start)-1
    k=k+1;
    if(givenIntervals == 0)
        I_cut = I(stop(j)+1:start(j+1)-1);
        Q_cut = Q(stop(j)+1:start(j+1)-1);
        fprintf('%d to %d\n',stop(j)+1,start(j+1)-1);
        start(j+1)-1-stop(j)-1+1;
        Data_cut = zeros(1,2*(start(j+1)-1-stop(j)-1+1));
    else
        I_cut = I(start(j):stop(j));
        Q_cut = Q(start(j):stop(j));
        fprintf('%d to %d\n',start(j),stop(j));
        Data_cut = zeros(1,2*(floor(stop(j)-start(j))+1));
    end
    Data_cut(1:2:length(Data_cut)) = I_cut;
    Data_cut(2:2:length(Data_cut)) = Q_cut;
    data = [data Data_cut];
end

WriteBin([outputPath],data);
%WriteBin(['/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Aug 9 2017/Detect_begs_and_ends/param0.9/cut/bikes humans radar z/',fileName,'_cut',num2str(j),'.data'],Data_cut);

nCuttedFiles = length(start);
