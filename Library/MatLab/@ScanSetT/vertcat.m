function Result = vertcat(varargin)

Set = varargin{1};

This.Data = Set.Data;
This.Pos = Set.Pos;
  
This.NumScan = Set.NumScan;
This.NumSamp = Set.NumSamp;
This.NumChan = Set.NumChan;

for ArgNum = 2 : nargin
  Set = varargin{ArgNum};
  
  if (Set.NumSamp ~= This.NumSamp) || (Set.NumChan ~= This.NumChan)
    ERROR('Dimensions must be the same.')
  end
  
  This.Data = [This.Data; Set.Data];
  This.Pos = [This.Pos; Set.Pos];
  This.NumScan = This.NumScan + Set.NumScan;
end

Result = class(This, 'ScanSetT');