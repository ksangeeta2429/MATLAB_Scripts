function Obj = ScanSet_Flat_T(Arg1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ScanSet_Flat_T -- Constructor flat scansets

if nargin == 0 % consturcter of array elements
  ScanSet = ScanSetT();

elseif isa(Arg1, 'ScanSet_Flat_T') % copy constructor
  Obj = Arg1;

elseif ischar(Arg1)
  FileName = Arg1;
  Data = ReadDataSet(FileName);

else
  ERROR('Invalid argument type')

end

ScanSet = ScanSetT(Data);
This.Tag = 'Flat';

Obj = class(This, 'ScanSet_Flat_T', ScanSet);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Data = ReadDataSet(FileName)

%% write to file
FileId = fopen(FileName, 'r');
if (FileId < 0)
  ERROR('Could not open input file')
end

NumScan = freed(FileId, 1,'uint16');
NumSamp = freed(FileId, 1,'uint16');
NumChan = freed(FileId, 1,'uint8');

Data = freed(FileId, NumScan*NumSamp*NumChan,'int16');

Status = fclose(FileId);
if (Status < 0)
  ERROR('Failed to close file')
end