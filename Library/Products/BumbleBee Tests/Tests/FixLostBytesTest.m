%%%%%%%%%%%%%%%%%%%%%%%  FixLostBytesTest %%%%%%%%%%%%%%%%%%%%%%%%%%%

rand('seed',0);

NumTest = 1;
NumBits = 12;
ScratchDir = '.\Scratch';

if exist(ScratchDir) ~= 7
  mkdir(ScratchDir)
end

OldPath = addpath('D:\Git\Library\Products\BumbleBee Tests');

for TestNum = 1 : NumTest
%   NumSamp = round(RandLog(1, 100,1e6));
  NumSamp = 30;
  
  NumByte = 2 * NumSamp;
  
%   LogNumSamp = log10(NumSamp);
  LogNumSamp = 6;

  %% Write good file
  GoodSamps = floor(2^NumBits * rand(1,NumSamp));
  GoodFile = sprintf('%s\\Good File %.3d.data', ScratchDir,TestNum);
  WriteRaw(GoodFile,GoodSamps, 'uint16')
  
  %% Select byte losses
  MaxLoss = round(LogNumSamp + 9*LogNumSamp*rand(1));
  LossByte = sort(unique(1 + floor(NumByte*rand(1,MaxLoss))));
  NumByteLoss = length(LossByte);
  
  LossByteMask = zeros(1,NumByte);
  LossByteMask(LossByte) = 1;
 
  %% Create BadFile
  BadFile = sprintf('%s\\Bad File %.3d.data', ScratchDir,TestNum);
  WriteRaw(BadFile,zeros(1,NumByte - NumByteLoss),'uint8')

  BadFileMap = memmapfile(BadFile, 'Writable',true);
  GoodFileMap = memmapfile(GoodFile);
  
  Compress = find(~LossByteMask);
  BadFileMap.data = GoodFileMap.data(Compress');
  
  clear GoodFileMap
  clear BadFileMap
  
  %%  Do the fix
  FixedFile = sprintf('%s\\Fixed File %d.3', ScratchDir,TestNum);
  FixLostByte(BadFile, FixedFile);
  
  %% Do the test; i.e., check the results.
  LossSamp = unique(floor((LossByte - 1)/2) + 1);
  NumSampLoss = length(LossSamp);
  
  LossSampMask = zeros(1,NumSamp);
  LossSampMask(LossSamp) = 1;
  
  FixedSamps = ReadRaw(FixedFile, 'uint16');
  
  Compress = find(~LossSampMask);
  
  if any(FixedSamps ~= GoodSamps(Compress))
    error('Test Failed')
  end
end