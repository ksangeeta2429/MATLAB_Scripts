% try to implement the classifier to use it to test the data


%clear;close all

%fileName='305_3p_class_lb';
function ImplementClassifier(fileName)

numInFilename=ExtractNumFromFileName(fileName);
data = ReadBin(fileName);
I = data([1:2:length(data)-1]); 
Q = data([2:2:length(data)]);
N = length(I);

sampRate=300;
secondsPerFrame=30;
%%%%%%% framing the data %%%%%%%%%%%%%
pointsPerFrame=sampRate*secondsPerFrame;
numOfFrames=floor(N/pointsPerFrame);


clear numOfPeople;
for k=1:numOfFrames     % floor(4/5*frames)
    Iframe=I((1+(k-1)*pointsPerFrame):k*pointsPerFrame);
    Qframe=Q((1+(k-1)*pointsPerFrame):k*pointsPerFrame);
                                                                      numOfFeatures=100;
    f=FeatureExtract(Iframe, Qframe, sampRate, numOfFeatures);
    
    %%%%%%%%%%%%%%%%%%%%%%%%
%     x=[x numInFilename];
%     y1=[y1 f(65)];
%     y2=[y2 f(66)];
%     y3=[y3 f(69)];
%     y4=[y4 f(70)];
%     y5=[y5 f(73)];
%     y6=[y6 f(74)];
%     y7=[y7 f(81)];
%     y8=[y8 f(82)];
%     y9=[y9 f(83)];
    %%%%%%%%%%%%%%%%%%%%%%%
    
    x=[x numInFilename];
    y1=[y1 Classifier(Iframe,Qframe)];
    
    %numOfPeople(k)=Classifier(Iframe,Qframe)
end
fclose('all');

% numOfPeople;
% mean(numOfPeople);
% var(numOfPeople);
% max(numOfPeople);
% min(numOfPeople);
% skewness(numOfPeople)
% kurtosis(numOfPeople)
% median(numOfPeople)
