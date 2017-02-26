function MovieDemoZoom(Data, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Movie -- Movie all of the files in a data set.

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
Mid = NumScan/2 + 0.5;
LowDelta = 2.7/Radar.BinSizeM;
HighDelta = NumSamp - 3.3/Radar.BinSizeM;

for i = 1 : NumScan
  if (i < Mid)
    Delta = 1 - ((i - Mid)/(NumScan/2))^2;
  else
    Delta = 1;
  end
  
  GraphInfo.Range = round(Delta*[LowDelta -HighDelta]) + [1 NumSamp];
  
  GraphScan(Array(i,:,:), GraphInfo);
  set(gca, 'Units','Pixels', 'Position',[100 100 718 478]);
  
  title(sprintf('Scan Num = %d', i));
  
  Frame(i) = getframe;
  
  Image = frame2im(Frame(i));
  imwrite(Image, sprintf('%s/Frame%d.jpg', FileInfo.Name, i), 'jpeg') 
end

if SaveFile
  movie2avi(Frame,FileInfo.Name, 'fps',10);
end