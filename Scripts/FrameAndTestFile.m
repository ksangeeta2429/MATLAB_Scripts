% frame one file to n frames, and all the files are of the given fixed length
% and apply the model trained from frames on them
% and apply the high-level hueristics, for example, a file of 5 frames,
% hhdhh, will be classified as h, because there are 4h and only one d


function classificationResult = FrameAndTestFile(fileName,feature_min,scalingFactors, SV_matlab, param,gamma,rho)

SetEnvironment
SetPath

% cd ('C:\Users\he\My Research\2014.8\20141028-arc\train\human\cut');
% fileName='19_cut1';%dog9
% feature_min=feature_min0;
% scalingFactors=scalingFactors0;
% SV_matlab;
% param;
% gamma;
% rho;


[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));

sampRate = 256;
nSecondPerFrame = 3;
nPointPerFrame = nSecondPerFrame*sampRate;

nFrame = floor(N/nPointPerFrame);
frameResults = zeros(1,nFrame);
for j=1:nFrame
    fileName
    f_file = File2Feature(['frame_',num2str(nSecondPerFrame),'s\',fileName,'_frame',num2str(j)], 'Human', 1, 0, feature_min, scalingFactors);
    f_file = f_file(1:length(f_file)-1);
    f_file = cell2mat(f_file);
    frameResults(j)= testFeaturevector(f_file, SV_matlab, param,gamma,rho);
end

%%% high level hueristics
ratioOfOne = sum(frameResults)/nFrame;
if ratioOfOne>1/2
    classificationResult = 1;
else 
    classificationResult = 0;
end