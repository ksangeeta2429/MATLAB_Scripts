%% Description:
%This script reads the cvs file created by the logic analyzer and saves the
%information in a binay format. The information can later be used to memory
%map the binary output
% 
% Output: --
% The output is saved into the file specified by MemMapFilename
%
% Input:
% filename      : The filename (together with path) of the cvs file
% MemMapFilename: The output filename of the mmap file
% ChunkSize     : Number of lines to be read at a time
% SamplePeriod  : The sample period for sampled read form the cvs file.
%               Setting this equal to ChunkSize reads all lines. Together with chunk size
%               allows duty cyled, undersampled reading. 
%% Author: Bora Karaoglu
%% Define Inputs
cur_directory = 'E:\HSI_16Mhz_1MSamples\';
InputFileName = [cur_directory 'HSI16Mhz1MSamples_32bit.csv'];
MemMapFilename = [cur_directory 'HSI16Mhz1MSamples_32bit.mmap'];

SamplePeriod = 1000;
ChunkSize = 1000;
%% Initialization
startRow = 2; % This determines the header lines
endRow = 125388938; % This is an estimate. It will be determined later 
numEntries = endRow-startRow;
% LAMemMap = memmapfile(MemMapFilename        ...               ...
%     ,'Format', { 'double' [1 1] 'LogicClock'     ...
%                  'uint64' [1 1] 'IndexNumber'
%                } ...
%     ,'Repeat',numEntries ...
%     ,'Writable', true ...
%     );
f = fopen(MemMapFilename, 'w');
fileID = fopen(InputFileName,'r');
formatSpec = '%s%[^\n\r]';
delimiter = ',';
%% Execution
tic;
fwrite(f,numEntries, 'uint64'); 
currow = 1;
NumberofWrittenRows = 0;
reachedendoffile = 0;
while(currow<endRow)
%% Read columns of data according to format string.
%dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);
if currow==1
    dataArray = textscan(fileID, formatSpec, ChunkSize, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);
else
    dataArray = textscan(fileID, formatSpec, ChunkSize, 'Delimiter', delimiter, 'ReturnOnError', false);
end
currow = currow+ChunkSize;

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

% Converts strings in the input cell array to numbers. Replaced non-numeric
% strings with NaN.
rawData = dataArray{1};
for row=1:size(rawData, 1);
    % Create a regular expression to detect and remove non-numeric prefixes and
    % suffixes.
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData{row}, regexstr, 'names');
        numbers = result.numbers;
        
        % Detected commas in non-thousand locations.
        invalidThousandsSeparator = false;
        if any(numbers==',');
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(thousandsRegExp, ',', 'once'));
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % Convert numeric strings to numbers.
        if ~invalidThousandsSeparator;
            numbers = textscan(strrep(numbers, ',', ''), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch me
    end
end
%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
%% Allocate imported array to column variable names
%Times = cell2mat(raw(:, 1));
fwrite(f,cell2mat(raw(:, 1)), 'double');
fwrite(f,currow-ChunkSize+1:currow, 'uint64');
NumberofWrittenRows = NumberofWrittenRows+2*ChunkSize;
%% Skip lines for undersampling
for i=ChunkSize+1:SamplePeriod
    tline = fgetl(fileID);
    if(feof(fileID)), reachedendoffile=1; break; end
end
if(feof(fileID)), reachedendoffile=1; break; end
currow = currow + SamplePeriod-1;
end
%% Map MemoryMapFile
LAMemMap = memmapfile(MemMapFilename        ...               
    , 'Offset',0            ... %Offset the first uint64 which is the numofEntries
    ,'Format', 'uint64' ...
    ,'Repeat',1 ...
    ,'Writable',true ...
   );
LAMemMap.Data = uint64(NumberofWrittenRows);
clear LAMemMap;
%% Close the text file.
fclose(fileID);
fclose(f);
%%
TimeTakenInExecution = toc;
save('MemoryMappedOperation.mat');