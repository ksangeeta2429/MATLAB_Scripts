Rate = 250;
BaseTitle = 'Noise Test 15-05-26';

DropDir = 'C:\Fast Scratch\Batch Tests';
InRel = 'In File';
OutRel = 'Out File';

InDir = sprintf('%s\\%s', DropDir,InRel);

OutDir = sprintf('%s\\%s', DropDir,OutRel);
% OutDir = InDir;

% DoAllFile(InDir,'*.bbs',OutDir, @FixLostByte,Rate);
% DoAll(InDir,'*.bbs',OutDir, @GraphLook, Rate,BaseTitle);
DoAll(InDir,'*.bbs',OutDir, @BatchNoise, Rate,BaseTitle);