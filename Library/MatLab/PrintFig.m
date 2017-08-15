function PrintFig(Name, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SaveFigure - Parse named arguments and call SaveFigureInt

FileInfo.Name = Name;
FileInfo.Size = [5, 3];
FileInfo.Units = 'Inches';
FileInfo.EdgeWidth = [.7 .6 .2 .2];
FileInfo.Format = 'meta';

NumVarArg = length(varargin);
ArgNum = 1;

while ArgNum < NumVarArg
  NextArg = varargin{ArgNum};
  switch NextArg
    case 'Size'
      FileInfo.Size = varargin{ArgNum + 1};
      ArgNum = ArgNum +2;
    case 'Units'
      FileInfo.Units = varargin{ArgNum + 1};
      ArgNum = ArgNum +2;
    case 'EdgeWidth'
      FileInfo.EdgeWidth = varargin{ArgNum + 1};
      ArgNum = ArgNum +2;
    case 'Format'
      FileInfo.Format = varargin{ArgNum + 1};
      ArgNum = ArgNum +2;
    otherwise
      error('Invalid named argument')   
  end
end

% Save result
PrintFigCore(FileInfo);