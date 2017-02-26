function Obj = ScanSetBinT(Arg1, Pattern)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ScanSet_EVK_T -- Constructor for a EvalKitDataT object

if nargin == 0 % consturcter of array elements
  ScanSet = ScanSetT();
    
elseif isa(Arg1, 'ScanSet_EVK_T') % copy constructor
  Obj = Arg1;
  
elseif ischar(Arg1)
  Path = Arg1;
  
  if 1 < nargin
    Data = ReadDataSet(Path, Pattern);
  else
    Data = ReadDataSet(Path, 'Scan%d.data');
  end
  
else
  ERROR('Invalid argument type')
  
end

ScanSet = ScanSetT(Data);
This.Tag = 'Bin';
  
Obj = class(This, 'ScanSetBinT', ScanSet);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Data = ReadDataSet(Path, Pattern)

NumSamp = 640;

%% Read Data
FileNum = 0;
FileName = sprintf('%s/%s', Path,sprintf(Pattern,FileNum));
Fid = fopen(FileName, 'r');

while (0 < Fid)
  Temp = fread(Fid, NumSamp,'int16');
  Data(FileNum + 1, :) = Temp;
  fclose(Fid);
  
  FileNum = FileNum + 1;
  FileName = sprintf('%s/%s', Path,sprintf(Pattern,FileNum));
  Fid = fopen(FileName, 'r');
end