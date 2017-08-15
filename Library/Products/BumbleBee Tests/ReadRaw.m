function Data = ReadRaw(FileName, TypeArg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ReadBin -- Reads a file a s siquence of number.
%
% Arguments:
%   FileName -- Specifies the name of the file to be read.
%
%   Type -- Optional argument.  Specifies the data type of the 
%     number in the file.  If unsepcified the default is 'uint16').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fid = fopen(FileName, 'r');
if (Fid < 0)
  error('Could not open file');
end

if nargin < 2, Type = 'uint16'; else Type = TypeArg; end
Data = fread(Fid, inf, Type);

fclose(Fid);