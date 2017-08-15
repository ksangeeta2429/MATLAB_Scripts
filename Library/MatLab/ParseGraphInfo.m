function GraphInfo = ParseGraphInfo(DataSize, Radar, varargin);

NumChan = DataSize(1);
NumSamp = DataSize(2);

%% Set defaults.
GraphInfo.Range = [1 NumSamp];
GraphInfo.Offset = 0;
GraphInfo.BinSizeM = Radar.BinSizeM;
GraphInfo.Color = lines(NumChan);

%% Parse Arguments
Temp = varargin{:};
NumParam = length(Temp)/2;

for i = 1 : NumParam
  Name = Temp{2*i - 1};
  Value = Temp{2*i};
  
  switch lower(Name)
    case 'range'
      GraphInfo.Range = Value;
    case 'offset'
      GraphInfo.Offset = Value;
    case 'color'
      GraphInfo.Color = Value;
    case 'vert'
      GraphInfo.Vert = Value;
  end
end