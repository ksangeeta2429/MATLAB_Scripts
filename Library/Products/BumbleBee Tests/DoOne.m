function DoOne(FileName,OutDir, BatchFunHand, Rate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DoOne -- Process only one data file.

%% Create output directory if it doesn't exist
if exist(OutDir) ~= 7
  mkdir(OutDir)
end

%% read the data
Comp = ReadRadar(FileName);

%% Do the operation
[InDir,Base,Ext] = FileNameSplit(FileName);

DirEnt = dir(FileName);
Words = strsplit(DirEnt.date);
ModDate = Words{1};

Title = sprintf('%s (%s)', Base, ModDate);

%% Do bath operation
Trimed = feval(BatchFunHand, Comp,Rate, Title);

%% Save the results
if Trimed
  Sufix = input('Output suffix:  ', 's');
  OutFile = sprintf('%s\\%s (%s)', OutDir,Base,Sufix);
else
  OutFile = sprintf('%s\\%s', OutDir,Base);
end

% savefig(OutFile)    %% doesn't work on Kenneth's laptop
PrintFig(OutFile, 'Size',[6.5,9]);