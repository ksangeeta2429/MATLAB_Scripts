function [ Data ] = ReadBin( File )
% ReadBin -- Reads raw data from a data sample file (int16's).

if nargin < 1 || exist('File','var') ~= 1 || isempty(File)
    error('Expected input filename.');
end

if ~ischar(File)
    error( 'Expected char vector input of file name.' );
end

Fid = fopen(File, 'r');
if (Fid < 0)
    warning( [ 'Could not open file ' File ] );
end

Data = fread(Fid, inf, 'int16');

fclose(Fid);