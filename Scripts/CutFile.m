% cut files according to displacement detection
% and put the frames as files in the subfolder ./cut/


function [ nCuttedFiles, start, stop ] = CutFile(fileName)

% cd ('C:\Users\he\My Research\2014.8\20141028-arc\train\human');
% cd ('C:\Users\he\Documents\Dropbox\MyC#Work\emote4jin\Data Collector 1.2\Data Collector Host 1.2\Data Collector Host\bin\Debug');
% cd ('C:\Users\he\My Research\2015.1\20150203-arc');
% fileName='1';

% path_data='C:\Users\he\My Research\2015.1\20150306-arc';
% fileName='balltest1';
% cd(path_data);


%[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
[I,Q,N]=Data2IQ(ReadBin([fileName,'.bbs']));

% test in the data, usually human walk will change 1e6 in 1 second (1m/s),
% which means 2.5e5 in each step, so 12 step (3s) it should be 3e6
% so earlier we use 1e5, which is too small, 1e6 should be a good thr
thr_cumPhaseChange = 3.6e5;%3.6e5  %//5e5; // 3 seconds (12steps), go 1m, which is 0.33 m/s
thr_phaseChangeInOneStep_start = 1.5e5; %1.5e5;  %// 1/4s, change 1/12 m, which is 0.33 m/s
thr_phaseChangeInOneStep_stop = 1.0e5;
nStepToStart = 4; %12
nStepToStop = 8; %8


Step=64;
nStep = floor(N/Step);


meanI = mean(I);
meanQ = mean(Q); % ????paper???????????????????????????????
% meanI = 2044;   % enable when do test on dummy data
% meanQ = 2048;
Data = (I-meanI) + 1i*(Q-meanQ);

Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*4096;

validFlag=0;
nStepInStateOne = 0;
cumPhaseChange = 0;
phaseChangeInOneStep = 0;

start=[];
stop=[];
stopWindowIndex=0;


for j=1:nStep
    phaseChangeInOneStep = Range(j*Step) - Range((j-1)*Step+1);
    if validFlag==0
        if abs(phaseChangeInOneStep)> thr_phaseChangeInOneStep_start
%             phaseChangeInOneStep
%             j
            validFlag = 1;
            'validFlag 0->1';
            j;
            potentialStart = (j-1)*Step+1;
        else
            continue;
        end
    end
    if validFlag==1
        cumPhaseChange = cumPhaseChange + phaseChangeInOneStep;
        nStepInStateOne = nStepInStateOne + 1;
        if nStepInStateOne == nStepToStart
            if abs(cumPhaseChange) > thr_cumPhaseChange
                validFlag = 2;
                'validFlag 1->2';
                stopWindowIndex = 0;
                j;
                start = [start,potentialStart];
            else
                validFlag = 0;
                'validFlag 1->0';
                j;
            end
            nStepInStateOne = 0;
            cumPhaseChange = 0;
        end
    end
    if validFlag == 2
%         abs(phaseChangeInOneStep)
        if abs(phaseChangeInOneStep) < thr_phaseChangeInOneStep_stop
            stopWindowIndex = stopWindowIndex+1;
        else
            stopWindowIndex = 0;
        end
        if stopWindowIndex == nStepToStop %12 step is 3 seconds. In 3 seconds there are no movement
            validFlag = 0;
            'validFlag 2->0';
            j;
            stop=[stop,j*Step];
        end
    end
end

% for j=1:length(stop)
%     j
%     [start(j)/256,stop(j)/256]
% end

for j=1:length(start)
    if (length(stop)==length(start)-1) 
        stop=[stop, nStep*Step];
    end
    I_cut = I(start(j):stop(j));
    Q_cut = Q(start(j):stop(j));
    
    Data_cut = zeros(1,2*(stop(j)-start(j)+1));
    Data_cut(1:2:length(Data_cut)-1) = I_cut;
    Data_cut(2:2:length(Data_cut)) = Q_cut;
    WriteBin(['./cut/',fileName,'_cut',num2str(j),'.data'],Data_cut);
end


nCuttedFiles = length(start);


