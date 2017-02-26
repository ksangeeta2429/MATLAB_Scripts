function Cell2beReturned = ChunkOperationOnMemoryMapData3(fhandle,LAMemMap, ChunkSize, InputRange )
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
if(nargin<4 || ~exist('InputRange','var')), InputRange = [1,NumberofEntries]; end

if(InputRange(2)>NumberofEntries), error('Input Range is out of bounds'); end

% if(mod(InputRange(2)-InputRange(1),RealChunkSize)==0), ChunkBoundaries = (InputRange(1):RealChunkSize:InputRange(2)); 
% else ChunkBoundaries = [(InputRange(1):RealChunkSize:InputRange(2)) InputRange(2)];  end

TotalNumberofChunks = ceil((InputRange(2)-InputRange(1)) / ChunkSize);

Cell2beReturned = cell(1,TotalNumberofChunks);
InfoDisplayInterval = 5;
%% Take Data out of memory map in chunks
CurLineNumber = InputRange(1)-1;
timeElapsed = 0;
tic;
for Chunktoberead=1:TotalNumberofChunks 
    %Skip the value in between which represents the channel state
    curIndexNumbers = (CurLineNumber + 1 : 2 : min([CurLineNumber+ChunkSize, InputRange(2)] ))';
    %curLogicClocks = double(LAMemMap.Data(curIndexNumbers));

    r = fhandle(LAMemMap,curIndexNumbers);
    Cell2beReturned{Chunktoberead} = r;

    CurLineNumber = CurLineNumber + ChunkSize;

t=toc;
if(t-timeElapsed > InfoDisplayInterval)%if (mod(Chunktoberead,100000)==0)
    timeElapsed = t;
    estRemaingTime = (InputRange(2) - CurLineNumber)*timeElapsed/(CurLineNumber-InputRange(1)) ;
    disp(['Processing ' func2str(fhandle) ', Curline = ' num2str(CurLineNumber) '/' num2str(InputRange(2)) ', Time Elapsed = ' num2str(timeElapsed) ' s, Estimated Remaining Time = ' num2str(estRemaingTime) ' s' ]); 
end
end


