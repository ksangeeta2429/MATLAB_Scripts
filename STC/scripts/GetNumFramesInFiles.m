% input: files (set)
% output: vector - number of frames in each file
function [totalNumFramesInSet,nFramesInEachFile] = GetNumFramesInFiles(Files,secondsPerFrame)
nFramesInEachFile=0;
sampRate=300;
pointsPerFrame=sampRate*secondsPerFrame;
for i=1:length(Files)
    fileName=Files{i};
    data = ReadBin(fileName);
    nPoint=length(data)/2;
    nFramesInEachFile(i)=2*floor(nPoint/pointsPerFrame)-1;
end
totalNumFramesInSet=sum(nFramesInEachFile);
    
    