function nCuttedFiles = CutFile_Manual_From_Sample_Index(fileName,beg_index_file, end_index_file,date,output_folder)

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
cut_folder = [filePath,output_folder,'/']; %disp(cut_folder);
if exist(cut_folder, 'dir') ~= 7
    mkdir(cut_folder);
    fprintf('INFO: created directory %s\n', cut_folder);
else
    [status, message, messageid] = rmdir(cut_folder,'s');
    if status == 1
        fprintf('Successfully deleted %s\n',cut_folder);
        mkdir(cut_folder);
        fprintf('INFO: created new directory %s\n', cut_folder);
    else
        disp(message);
        return;
    end
end
    

[I,Q,N]=Data2IQ(ReadBin([fileName]));

walk_begs = dlmread(beg_index_file);
walk_ends = dlmread(end_index_file);

start = round(walk_begs,1);
stop = round(walk_ends,1);

k=0;
for j=1:length(start)
    k=k+1;
    I_cut = I(start(j):stop(j));
    Q_cut = Q(start(j):stop(j));
    Data_cut = zeros(1,2*(floor(stop(j)-start(j))+1));
    Data_cut(1:2:length(Data_cut)-1) = I_cut;
    Data_cut(2:2:length(Data_cut)) = Q_cut;
    WriteBin([cut_folder,fileNameOnly,'_',date,'_cut',num2str(j),'.data'],Data_cut);
    %WriteBin(['/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Aug 9 2017/Detect_begs_and_ends/param0.9/cut/bikes humans radar z/',fileName,'_cut',num2str(j),'.data'],Data_cut);

end

nCuttedFiles = length(start);

end