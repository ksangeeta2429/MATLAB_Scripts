function DoAll(DataPath,Mask,OutDir, JobFunHand, Rate,BaseTitle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DoAll

Dir = dir(sprintf('%s\\%s', DataPath,Mask'));

NameList = { Dir.name };
DateList = { Dir.date };
NumFile = length(NameList);

if exist(OutDir) ~= 7
  mkdir(OutDir)
end

for Num = 1 : NumFile
  figure
  fprintf('%d out of %d:  ', Num, NumFile);
  
  FullName = sprintf('%s\\%s', DataPath,NameList{Num});
  [Trash,BaseName,Ext] = FileNameSplit(FullName);
  
  Comp = ReadRadar(FullName);
  
  if nargin < 6
    Title = BaseName;
  else
    Title = sprintf('%s (%s)', BaseTitle, BaseName);
  end
    
  feval(JobFunHand, Comp,Rate, Title);
  
  OutFile = sprintf('%s\\%s', OutDir,BaseName);
  
%   savefig(OutFile)
  PrintFig(OutFile, 'Size',[6.5,9], 'Format','png');

  fprintf('\n');
end