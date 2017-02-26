function [ LAMemMap ] = MemoryMapLogicAnalyzerData( MemMapFilename )
%% Description:
%This script maps the binary output of the logic analyzer to the MATLAB variables

% Output: --
% LAMemMap: The memory mapped variable in MATLAB

% Input:
% MemMapFilename:  The memory mapped filename

%% Author: Bora Karaoglu
%% Define Inputs
% cur_directory = 'F:\Users\Bora\Samraksh\ClockSyncProject\Data\HSI_32MHz_5S_2\';
% MemMapFilename = [cur_directory 'untitled.mmap'];
%% Read Header
fileID = fopen(MemMapFilename);
numEntries = fread(fileID, 1, 'uint64' );
fclose(fileID);
%% Map MemoryMapFile
LAMemMap = memmapfile(MemMapFilename        ...               
    , 'Offset',8            ... %Offset the first uint64 which is the numofEntries
    ,'Format', { 'double', [1 1], 'LogicClock'     ...
                ;'uint64', [1 1], 'IndexNumber'
               } ...
    ,'Repeat',(numEntries/2)-1 ...
   );
%% 
LAMemMap2 = memmapfile(MemMapFilename        ...               
    , 'Offset',8            ... %Offset the first uint64 which is the numofEntries
    ,'Format', 'double'   ...
   );