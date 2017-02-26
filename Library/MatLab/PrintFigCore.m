function PrintFigCore(FileInfo)

[L,B,T,R] = Split(FileInfo.EdgeWidth);
[Width,Height] = Split(FileInfo.Size);

% Controls size of the output graph.  Always in inches.
switch lower(FileInfo.Units)
  case 'inches', Scale = 1;
  case 'centimeters', Scale = 1/2.54;
  case 'points', Scale = 1/72;
  case 'pixels', Scale = 1/150;
end

PaperPos = [1 1 Scale*FileInfo.Size];
set(gcf, 'PaperPosition',PaperPos);

%% Control the size of the figure
set(gcf, 'Units', FileInfo.Units);

Inch = 1/ Scale;
Pos = [Inch Inch FileInfo.Size + Inch];
set(gcf, 'Position',Pos)

% Need to rethink AxisPos in the context of varing units.
% Old values were in inches.  The whole point is to get away from
% normalized units.

% set axis; if there is only one child
%%  if all(size(get(gcf, 'Children')) == [1,1])
%%    AxisPos = [L,B, 1 - L - R,Height - B - T];
%%    set(gca, 'Position',AxisPos)
%%  end

% Save result
print(sprintf('-d%s', FileInfo.Format), FileInfo.Name);