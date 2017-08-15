function Obj = MetaDataT(Arg1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MetaDataT -- Constructore for the meta-data type

if nargin == 0 % sub-element constructor
  This.NumOfFile = 0;
  This.NumOfColumn = 0;
  This.ColumnTags = {};
  This.Data = {};
  
elseif isa(Arg1, 'MetaDataT') % copy constructor
  Obj = Arg1;
  
elseif ischar(Arg1)
  File = Arg1;
  This.Data = ReadMetaData(FileName);

  [This.NumOfFile,This.NumOfColumn] = size(This.Data);
    
else
  ERROR('Invalid argumnet type')
    
end

Obj = class(This, 'MetaDataT');