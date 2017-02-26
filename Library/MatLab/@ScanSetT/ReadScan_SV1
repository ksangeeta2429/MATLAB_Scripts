function [Pos,Data] = ReadScan_SV1(Obj, Path, File)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ReadScan_SV1 -- privite method of ScanSetT constructor

NumSamp = 2000;

if (nargin == 1)
  Name = File
else
  Name = sprintf('%s/%s', Path,File);
end

FileId = fopen(Name);
Raw = fread(FileId, 2*NumSamp + 1, 'int32');
fclose(FileId);

Pos = Raw(1);

FileSize = length(Raw);
NumChan = round((FileSize - 1)/2000);
if (NumChan*NumSamp + 1 ~= FileSize)
  error('Wrong number of samples in file');
end

for i = 1 : NumChan
  Data(:,i) = Raw((i-1)*NumSamp + 2 : i*NumSamp + 1);
end