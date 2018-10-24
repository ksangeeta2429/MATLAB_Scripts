function WriteRaw(FileName,Data, TypeArg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WriteRaw -- Writes s siquence of number to a file.
%
% Arguments:
%   FileName -- Specifies the name of the file to be created.
%
%   Data -- The number to be written to the file.
%
%   Type -- Optional argument.  Specifies the data type of the 
%     number in the file.  If unsepcified the default is uint16.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fid = fopen(FileName, 'w+');
if (Fid < 0)
  error('Could not create file');
end

if nargin < 2, Type = 'uint16'; else Type = TypeArg; end;
Data = fwrite(Fid, Data, Type);

fclose(Fid);

end