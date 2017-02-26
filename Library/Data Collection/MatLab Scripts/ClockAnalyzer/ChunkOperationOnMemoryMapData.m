function Cell2beReturned = ChunkOperationOnMemoryMapData(fhandle,LAMemMap, ChunkSize )
%% Description:
%This script retrieves the data in chunks and applies a function to each
%retrieved chunk and returns the outputs
% 
% The output is saved into the file specified by MemMapFilename
%
% Input:
% fhandle: The fubnction handle to be applied
% LAMemMap: The memory map handle
% ChunkSize     : Number of lines to be read at a time
% SamplePeriod  : The sample period for sampled read form the cvs file.
%               Setting this equal to ChunkSize reads all lines. Together with chunk size
%               allows duty cyled, undersampled reading. 
%% Author: Bora Karaoglu
%% Define Inputs

%% Initialization
NumberofEntries = max(size(LAMemMap.Data));
TotalNumberofChunks = ceil(NumberofEntries / ChunkSize);
Cell2beReturned = cell(1,TotalNumberofChunks);
%% Take Data out of memory map in chunks
numelprocessed = 0;
for Chunktoberead=1:TotalNumberofChunks 
curIndexNumbers = (numelprocessed+1 : min([numelprocessed+ChunkSize, NumberofEntries] ))';
curLogicClocks = LAMemMap.Data(curIndexNumbers);

r = fhandle(curLogicClocks,curIndexNumbers);
Cell2beReturned{Chunktoberead} = r;

numelprocessed = numelprocessed + ChunkSize;
end


