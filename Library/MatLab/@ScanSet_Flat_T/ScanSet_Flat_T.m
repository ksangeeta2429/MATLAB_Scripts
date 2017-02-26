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

NumScan = fread(FileId, 1,'uint16');
NumSamp = fread(FileId, 1,'uint16');
NumChan = fread(FileId, 1,'uint8');

Raw = fread(FileId, NumScan*NumSamp*NumChan,'int16');

%% MatLab stores arrays in Fortran order.
Index = ...
  kron([0 : NumSamp - 1], NumScan*ones(NumScan,1)) + ...
  kron(ones(1,NumSamp), [0 : NumScan - 1]') + 1;
Data = Raw(Index);

Status = fclose(FileId);
if (Status < 0)
  ERROR('Failed to close file')
end