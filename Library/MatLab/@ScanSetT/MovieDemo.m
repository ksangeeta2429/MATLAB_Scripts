function MovieDemo(Data, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MovieDemo -- Movie all of the files in a data set.

Radar = SolderVision1();

NumScan = Data.NumScan;
NumSamp = Data.NumSamp;
NumChan = Data.NumChan;

Array = Data.Data;

%% Parse arguments
GraphInfo = ParseGraphInfo(size(Array), SolderVision1(), varargin);
[SaveFile,FileInfo] = ParseFileInfo(varargin);

%% Compute y-range
Index = [GraphInfo.Range(1) : GraphInfo.Range(2)];

if ~isfield(GraphInfo, 'Vert')
  MaxAbs = max(max(max(abs(Array(:,Index,:)))));
  GraphInfo.Vert = 1.1*[-MaxAbs MaxAbs];
end

%% Walk the graphs
for i = 1 : NumScan
  GraphScan(Array(i,:,:), GraphInfo);
  title(sprintf('Scan Num = %d', i));
  
  set(gca, 'Units','Pixels', 'Position',[100 100 719 478]);

  Frame(i) = getframe;
    
  Image = frame2im(Frame(i));
  imwrite(Image, sprintf('%s/Frame%d.jpg', FileInfo.Name, i), 'jpeg') 
end

if SaveFile
  movie2avi(Frame,FileInfo.Name, 'fps',10);
end