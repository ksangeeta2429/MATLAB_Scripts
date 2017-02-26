function DoAllFile(DataDir,Mask,OutDir, JobFunHand, Rate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DoAllFile -- Run the JobFun on all the fiels that match the mask

Dir = dir(sprintf('%s\\%s', DataDir,Mask'));

NameList = { Dir.name };
DateList = { Dir.date };
NumFile = length(NameList);

if exist(OutDir) ~= 7
  mkdir(OutDir)
end

for Num = 1 : NumFile
  fprintf('%d out of %d:  ', Num, NumFile);
  FileName = NameList{Num};
  
  InFile = sprintf('%s\\%s', DataDir,FileName);
  OutFile = sprintf('%s\\%s', OutDir,FileName);
    
  MadeFig = feval(JobFunHand, InFile,OutFile,Rate);
  
  if MadeFig
    % savefig(OutFile);  % doesn't work on Kenneth's laptop
    [Trash,Base,Ext] = FileNameSplit(FileName);
    OutFig = sprintf('%s\\%s.emf', OutDir,Base);
    PrintFig(OutFig, 'Size', [6.5,9])
  end
  
  fprintf('\n');
end