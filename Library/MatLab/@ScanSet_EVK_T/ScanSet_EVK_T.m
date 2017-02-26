function Obj = ScanSet_EVK_T(Arg1, Pattern)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ScanSet_EVK_T -- Constructor for a EvalKitDataT object

if nargin == 0 % consturcter of array elements
  ScanSet = ScanSetT();
    
elseif isa(Arg1, 'ScanSet_EVK_T') % copy constructor
  Obj = Arg1;
  
elseif ischar(Arg1)
  Path = Arg1;
  
  if 1 < nargin
    Data = ReadScanSet(Path, Pattern);
  else
    Data = ReadScanSet(Path, 'Scan%d.txt');
  end
  
else
  ERROR('Invalid argument type')
  
end

ScanSet = ScanSetT(Data);
This.Tag = 'EVK';
  
Obj = class(This, 'ScanSet_EVK_T', ScanSet);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Data = ReadScanSet(Path, Pattern)

%% Read Data
FileNum = 0;
FileName = sprintf('%s/%s', Path,sprintf(Pattern,FileNum));
Fid = fopen(FileName, 'r');

while (0 < Fid)
  Data(FileNum + 1, :) = ReadScan(Fid)';
  fclose(Fid);
  
  FileNum = FileNum + 1;
  FileName = sprintf('%s/%s', Path,sprintf(Pattern,FileNum));
  Fid = fopen(FileName, 'r');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Scan = ReadScan(Fid)

% Read Header
for i = 1 : 36
  Trash = fgetl(Fid);
end

ScanSize = fscanf(Fid, 'Data\t%d');
  
Scan = fscanf(Fid, '%d\n', ScanSize);