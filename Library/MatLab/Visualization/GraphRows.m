function GraphRows(X,Y, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GraphRows -- Graph a set of data in sub-plots.

[NumRow,NumPoint] = size(Y);

%% Set Defaults
Param.BotXLabel = '';
Param.MidYLabel = '';
Param.TopTitle = '';
Param.TitleList = {};
Param.XRange = [];
Param.YRange = [];

LineFlag = {};

%% Pars the flags
Flag = varargin;
if isscalar(Flag) && iscell(Flag)
  Flag = varargin{:};
end

NumFlag = length(Flag);
FlagNum = 1;

while (FlagNum <= NumFlag)
  Temp = lower(Flag(FlagNum));
  switch Temp{:}
    case 'botxlabel'
      Param.BotXLabel = Flag{FlagNum + 1};
      FlagNum = FlagNum + 2;
    case 'midylabel'
      Param.MidYLabel = Flag{FlagNum + 1};
      FlagNum = FlagNum + 2;    
    case 'toptitle'
      Param.TopTitle = Flag{FlagNum + 1};
      FlagNum = FlagNum + 2;
    case 'titlelist'
      Param.TitleList = Flag{FlagNum + 1};
      FlagNum = FlagNum + 2;
    case 'xrange'
      Param.XRange = Flag{FlagNum + 1};
      FlagNum = FlagNum + 2;
    case 'yrange'
      Param.OverLap = Flag{FlagNum + 1};
      FlagNum = FlagNum + 2;
    otherwise
      LineFlag = {LineFlag{:}, Flag{FlagNum}};
      FlagNum = FlagNum + 1;
  end
end

%% Do Graphs
for Row = 1 : NumRow
  subplot(NumRow,1,Row)
  plot(X,Y(Row,:), LineFlag{:})
  
  if ~isempty(Param.XRange) || ~isempty(Param.YRange)
    if ~isempty(Param.XRange) && ~isempty(Param.YRange)
      Axis = [Param.XRange, Param.YRange];
    else
      Axis = axis;
      if ~isempty(Param.XRange)
        Axis(1:2) = Param.XRange;
      else %% ~isempty(Param.YRange)
        Axis(3:4) = Param.YRange;
      end
    end
    
    axis(Axis);
  end
end

%% Do anotations
if ~isempty(Param.TitleList)
  for Row = 1 : NumRow
    subplot(NumRow,1,Row)
    title(Param.TitleList{Row})
  end
elseif ~isempty(Param.TopTitle)
  subplot(NumRow,1,1)
  title(Param.TopTitle);
end

if ~isempty(Param.MidYLabel)
  subplot(NumRow,1, floor((NumRow + 1)/2))
  ylabel(Param.MidYLabel);
end

if ~isempty(Param.BotXLabel)
  subplot(NumRow,1,NumRow)
  xlabel(Param.BotXLabel);
end

