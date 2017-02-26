function Obj = ScanSetT(Arg1, Pattern)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ScanSetT -- Constructor for a ScanSetT object

if nargin == 0 % sub-element constructor
  This.Data = [];
  
  This.NumScan = 0;
  This.NumSamp = 0;
  This.NumChan = 0;
  
elseif isa(Arg1, 'ScanSetT') % copy constructor
  Obj = Arg1;
  
elseif ischar(Arg1)
  Path = Arg1;
  
  if 1 < nargin
    This.Data = ReadDataSet(Path,Pattern);
  else
    This.Data = ReadDataSet(Path);
  end

  [This.NumScan,This.NumSamp,This.NumChan] = size(This.Data);
    
elseif isa(Arg1, 'numeric')
  if ~isa(Arg1, 'double')
    This.Data = double(Arg1);
  else
    This.Data = Arg1;
  end
   
  [This.NumScan,This.NumSamp,This.NumChan] = size(This.Data);
    
else
  ERROR('Invalid argumnet type')
    
end

Obj = class(This, 'ScanSetT');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Data, NameList] = ReadDataSet(Path, Pattern)

%% Read Data
if (nargin > 1)
  DirList = dir(sprintf('%s/%s', Path,Pattern));
else
  DirList = dir(sprintf('%s/*_0*.rtd', Path));
end
NumScan = length(DirList);

if (NumScan == 0)
  error('Did not find any (matching) scan files.')
end

%% Read Data
for i = 1 : NumScan
  Data(i,:,:) = ReadScan(Path, DirList(i).name);
end

if (2 < nargout)
  for i = 1 : NumScan
    NameList{i} = DirList(i).name;
  end
end