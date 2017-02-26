function [SaveFile,FileInfo] = ParseFileInfo(varargin);

SaveFile = false;

%% Set defaults.
FileInfo.Name = 'Scan';
FileInfo.Format = 'meta';
FileInfo.Size = [5 3];
FileInfo.EdgeWidth = [0.7,0.6, 0.2,0.2];
FileInfo.Units = 'inches';

%% Parse Arguments
Temp = varargin{:};
NumParam = (length(Temp)/2);

for i = 1 : NumParam
  Name = Temp{2*i - 1};
  Value = Temp{2*i};
  
  switch lower(Name)
    case 'name'
      SaveFile = true;
      FileInfo.Name = Value;
    case 'format'
      SaveFile = true;
      FileInfo.Format = Value;
    case 'size'
      SaveFile = true;
      FileInfo.Size = Value;
    case 'units'
      SaveFile = true;
      FileInfo.Units = Value;
  end
end