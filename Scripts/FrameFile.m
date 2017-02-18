function nFramedFiles = FrameFile(fileName)

SetEnvironment
SetPath

% cd ('C:\Users\he\My Research\2014.1\Chhatbir Zoo Data\useAsBadData');
% fileName='elephant2';%dog9

% cd ('C:\Users\he\My Research\2015.1\removeErroneousData\bad\bk');
% fileName='bk_old1';%dog9


[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));

sampRate = 256;
nSecondPerFrame = 5;
nPointPerFrame = nSecondPerFrame*sampRate;

nFrame = floor(N/nPointPerFrame);
for j=1:nFrame
    I_frame = I((j-1)*nPointPerFrame+1:j*nPointPerFrame);
    Q_frame = Q((j-1)*nPointPerFrame+1:j*nPointPerFrame);
    Data_frame = zeros(1,2*nPointPerFrame);
    Data_frame(1:2:length(Data_frame)-1) = I_frame;
    Data_frame(2:2:length(Data_frame)) = Q_frame;
%     WriteBin(['.\frame_',num2str(nSecondPerFrame),'s\',fileName,'_frame',num2str(j),'.data'],Data_frame);
    WriteBin(['.\frame_',num2str(nSecondPerFrame),'s\z',fileName,'_',num2str(j),'.data'],Data_frame); 
    % z for make the filename start with z and will be in the end of folder
end

nFramedFiles = nFrame;