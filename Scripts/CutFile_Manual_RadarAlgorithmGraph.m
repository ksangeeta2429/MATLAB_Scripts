%% function CutFile_Manual_RadarAlgorithmGraph

% Cuts input data file manually, using detect_beginnings and detect_ends files output from the C# app ReadRadarAlgorithmGraph
% (https://dhruboroy29@bitbucket.org/dhruboroy29/wwf-baseline-classifier.git, commit# 899402cc6d61620a0cf3faa81a770d264107a0c9 [899402c])
% For access to this repository, contact Dhrubojyoti Roy (royd@cse.osu.edu)

function nCuttedFiles=CutFile_Manual_RadarAlgorithmGraph(fileName,walk_beg_file,walk_end_file,min_length_secs, cutoff_halfsecs)
filePath_tmp = strrep(fileName,'\','/');
pathIndex = strfind(filePath_tmp,'/');
if isempty(pathIndex) % If unqualified filename
    filePath = '.';
else
    filePath = filePath_tmp(1:pathIndex(end));
end

cut_folder = [filePath,'/cut'];
%cut_folder = [filePath,'cut']; %disp(cut_folder);
if exist(cut_folder, 'dir') ~= 7
    mkdir(cut_folder);
    fprintf('INFO: created directory %s\n', cut_folder);
end

[I,Q,N]=Data2IQ(ReadBin([fileName]));

walk_begs = dlmread(walk_beg_file); %disp(walk_begs);
walk_ends = dlmread(walk_end_file); %disp(walk_ends);

walk_lengths = (walk_ends - walk_begs)/2; % since unit is half-seconds

start = walk_begs(walk_lengths > min_length_secs & walk_begs < cutoff_halfsecs)*128;
stop = walk_ends(walk_lengths > min_length_secs & walk_ends < cutoff_halfsecs)*128;
%fileName = 'South2';
for j=1:length(start)
    I_cut = I(start(j):stop(j));
    Q_cut = Q(start(j):stop(j));
    
    Data_cut = zeros(1,2*(stop(j)-start(j)+1));
    Data_cut(1:2:length(Data_cut)-1) = I_cut;
    Data_cut(2:2:length(Data_cut)) = Q_cut;
    WriteBin(['./cut/',fileName,'_cut',num2str(j),'.data'],Data_cut);
    %WriteBin(['/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/March 25 2017/cut/',fileName,'_cut',num2str(j),'.data'],Data_cut);

end

nCuttedFiles = length(start);
