function Obj = LineStreamT(Arg1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LineStreamT -- Constructore for the meta-data type

if nargin == 0 % sub-element constructor
  This.Name = 0;
  This.File = 0;
  This.LineNum = 0;
  
elseif isa(Arg1, 'LineStreamT') % copy constructor
  Obj = Arg1;
  
elseif ischar(Arg1)
  This.Name = Arg1;
  This.File = fopen(This.Name);
  This.LineNum = 0;
    
else
  ERROR('Invalid argumnet type')
    
end

Obj = class(This, 'LineStreamT');