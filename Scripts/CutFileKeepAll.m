function [ nCuttedFiles, start, stop ] = CutFileKeepAll( fileName, filePath, dir_out, cutLength, offset )
%CutFileKeepAll - chop a file into pieces, keeping all parts of the file
%with valid length.
%
% Input:
% fileName - bbs file name
% filePath - bbs file path
% cutLength - length of cut. probably should be multiple of 250 (default).
% offset - offset in the file to start cutting
%
% Output:
% nCuttedFiles - number of new slice files
% start - start indices
% stop - stop indicees
% * (new _cut files on disk)
%
% Notes:
% * like CutFile, except don't run the detection algorithm.
% * useful for known synthetic
%
% See Also: CutFile, CutFilesInFolder

if nargin < 2 || exist('filePath','var') ~= 1 || isempty(filePath)
    filePath = pwd;
end

if nargin < 3 || exist('dir_out','var') ~= 1 || isempty(dir_out)
    dir_out = pwd;
end

if exist(dir_out,'dir') ~= 7
    error( [ 'Output file path does not exist. ' dir_out ] );
end

if nargin < 4 || exist('cutLength','var') ~= 1 || isempty(cutLength)
    cutLength = 250;
end

if nargin < 5 || exist('offset','var') ~= 1 || isempty(offset)
    offset = 0;
end

fname_bbs = [ filePath filesep fileName '.bbs' ];

[I,Q,~]=Data2IQ( ReadBin( fname_bbs ) );

if length(I) < cutLength
    warning( [ 'Not enough samples in bbs file ' fname_bbs ] );
end

idx_offset = 0 + offset; 

idx_cutpoints = idx_offset:cutLength:length(I);
start = idx_cutpoints(1:(end-1)) + 1; % MATLAB indexing starts at 1
stop = idx_cutpoints(2:end);

if (length(stop)==length(start)-1) 
    stop=[stop, nStep*Step];
end

str_fieldwidth = num2str(num2width(length(start)));
str_fmt = [ '%0' str_fieldwidth 'd' ];

for j=1:length(start)
    I_cut = I(start(j):stop(j));
    Q_cut = Q(start(j):stop(j));
    
    Data_cut = zeros(1,2*(stop(j)-start(j)+1));
    Data_cut(1:2:length(Data_cut)-1) = I_cut;
    Data_cut(2:2:length(Data_cut)) = Q_cut;
    
    str_fOut = [ dir_out '/cut/' fileName '_cut' num2str(j, str_fmt) '.data' ];
    WriteBin( str_fOut, Data_cut);
end


nCuttedFiles = length(start);
