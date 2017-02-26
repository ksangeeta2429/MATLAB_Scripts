function GraphScan(Data, GraphInfo, FileInfo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GraphScan -- Graph a scan of the result.
%
%   Data: a 1 or 2 dimentional array of numbers.  One row per channel.
%
%   GraphInfo: a record containing Range, Offset, BinSizeM, & Color.
%     Range - of the form [MinIndex, MaxIndex].
%     Offset - the shift in range-bin sizes of the first sameple.
%     BinSizeM - the length of range bins in meeters.
%     Color - a colum of color specification, one per chanel.
%
%   FileInfo: is a record cotaining Name, Format, & Size.  It is an
%     optional argument.  If the FileInfo argument is not specified then
%     the graph is not saved to disk.
%
%     Name - a string specifing the file name.
%     Format - the string specifing the format argument passed to the
%       print statement, e.g., 'meta'.
%     Size - of the form [width height].
%     Units - the units used in the size command, e.g., 'inches'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[NumChan,NumSamp] = size(Data);

%% Do Graph
Index = [GraphInfo.Range(1) : GraphInfo.Range(2)];
Dist = (Index - 1 + GraphInfo.Offset) * GraphInfo.BinSizeM;

for i = 1 : NumChan
  plot(Dist,Data(i,Index),'-', 'color',GraphInfo.Color(i,:), 'Marker','.')
  hold on
end
hold off

%% Set vertical range
XLim = [Dist(1), Dist(length(Dist))];
if ~isfield(GraphInfo, 'Vert')
  Temp = axis;
  Limits = [XLim, Temp(3:4)];
else
  Limits = [XLim, GraphInfo.Vert];
end

axis(Limits);

%% Annotate
xlabel('Range in Meeter')
ylabel('Raw Radar Return')

%% Print graphs
if (2 < nargin)
  SaveFigureInt(FileInfo)
end