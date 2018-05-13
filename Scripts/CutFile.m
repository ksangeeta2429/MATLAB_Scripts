function [ nCuttedFiles, start, stop ] = CutFile( fileName, filePath, dir_out)
%CutFile cut files according to displacement detection
% and put the frames as files in the subfolder ./cut/
% using _cut# indexing with zero-padded numbers.
%
% Input:
% fileName - name of .bbs file to cut, contains binary strided int16.
% filePath - name of input file path.
% dir_out - name out output directory. optional. default: $PWD
%
% Output:
% nCuttedFiles - number of cut files. important for indexing.
% start - start locations of cuts
% stop - stop locations of cuts


% cd ('C:\Users\he\My Research\2014.8\20141028-arc\train\human');
% cd ('C:\Users\he\Documents\Dropbox\MyC#Work\emote4jin\Data Collector 1.2\Data Collector Host 1.2\Data Collector Host\bin\Debug');
% cd ('C:\Users\he\My Research\2015.1\20150203-arc');
% fileName='1';

% path_data='C:\Users\he\My Research\2015.1\20150306-arc';
% fileName='balltest1';
% cd(path_data);

if nargin < 2 || exist('filePath','var') ~= 1 || isempty(filePath)
    filePath = pwd; % old behavior
end

if exist(filePath,'dir') ~= 7
    error( [ 'Input file path does not exist. ' filePath ] );
end

if nargin < 3 || exist('dir_out','var') ~= 1 || isempty(dir_out)
    dir_out = pwd; % old behavior
end

if exist(dir_out,'dir') ~= 7
    error( [ 'Output file path does not exist. ' dir_out ] );
end

%[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
[I,Q,N]=Data2IQ( ReadBin( [ filePath filesep fileName '.bbs' ] ) );

% test in the data, usually human walk will change 1e6 in 1 second (1m/s),
% which means 2.5e5 in each step, so 12 step (3s) it should be 3e6
% so earlier we use 1e5, which is too small, 1e6 should be a good thr
thr_cumPhaseChange = 3.6e5;%3.6e5  %//5e5; // 3 seconds (12steps), go 1m, which is 0.33 m/s
thr_phaseChangeInOneStep_start = 1.5e5; %1.5e5;  %// 1/4s, change 1/12 m, which is 0.33 m/s
thr_phaseChangeInOneStep_stop = 1.0e5;
nStepToStart = 4; %12  % nStepToStart*Step/sampleRate = seconds to start (min)
nStepToStop = 8; %8    % nStepToStop *Step/sampleRate = seconds to stop (min)


Step=64;
nStep = floor(N/Step);


dcBiasI = median(I);
dcBiasQ = median(Q); % ????paper???????????????????????????????
% dcBiasI = 2044;   % enable when do test on dummy data
% dcBiasQ = 2048;
Data = (I-dcBiasI) + 1i*(Q-dcBiasQ);

bits = 12; % ADC bit depth; 12-bit adc = 4096 values.

Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*(2^bits); %25735.92701820759 normally multiply by wavelength (0.0516883548275 meters), but instead 2*pi*4096...

% Displacement in meters = ( Range / 25735.92701820759) * 0.0516883548275;
% Displacement in Meters = Range * 0.000002008412395284291
% 3.6e5 = 0.723 meters
% 1.5e5 = 0.301 meters
% 1.0e5 = 0.2008 meters
% sampleRate = 250;
% sec_per_step = Step / sampleRate;
% vel_threshold = displacement_in_meters_per_step_threshold / sec_per_step
% start: 1.5e5 = 1.176 m/s (@250Hz sampleRate); or 1.205 m/s (@256Hz sampleRate)
% stop: 1.0e5 = 0.7845 m/s (@250Hz sampleRate); or 0.8034 m/s (@256Hz sampleRate)

% total:
% vel_total_threshold = disp_meters / (nStepToStart * sec_per_step)
% 3.6e5 = 0.706 (@250Hz sampleRate); or 0.7230 (@256Hz sampleRate)

% so start threshold is initial bump (1.2m/s) over one step needed to monitor for
% start. then wait nStepToStart steps and check if average is good
% (0.72m/s) then keep going until have accumulated nStepToStop consecutive
% velocities per step that were below stop threshold (0.803m/s).

validFlag=0;
nStepInStateOne = 0;
cumPhaseChange = 0;
phaseChangeInOneStep = 0;

start=[];
stop=[];
stopWindowIndex=0;

b_debug = true;
str_fieldwidth = num2str(num2width(length(start)));
str_fmt = [ '%0' str_fieldwidth 'd' ];


for j=1:nStep
    phaseChangeInOneStep = Range(j*Step) - Range((j-1)*Step+1);
    if validFlag==0
        if abs(phaseChangeInOneStep)> thr_phaseChangeInOneStep_start
            validFlag = 1;
            if b_debug
                disp( [ num2str(j,str_fmt) 'validFlag 0->1' ] );
            end
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
                if b_debug
                    disp( [ num2str(j,str_fmt) 'validFlag 1->2' ] );
                end
                stopWindowIndex = 0;
                start = [start,potentialStart];
            else
                validFlag = 0;
                if b_debug
                    disp( [ num2str(j,str_fmt) 'validFlag 1->0' ] );
                end
            end
            nStepInStateOne = 0;
            cumPhaseChange = 0;
        end
    end
    if validFlag == 2
        if abs(phaseChangeInOneStep) < thr_phaseChangeInOneStep_stop
            stopWindowIndex = stopWindowIndex+1;
        else
            stopWindowIndex = 0;
        end
        if stopWindowIndex == nStepToStop %12 step is 3 seconds. In 3 seconds there are no movement
            validFlag = 0;
            if b_debug
                disp( [ num2str(j,str_fmt) 'validFlag 2->0' ] );
            end
            stop=[stop,j*Step];
        end
    end
end

% for j=1:length(stop)
%     j
%     [start(j)/256,stop(j)/256]
% end

if (length(stop)==length(start)-1) 
    stop=[stop, nStep*Step];
end

str_fieldwidth = num2str(num2width(length(start)));
str_fmt = [ '%0' str_fieldwidth 'd' ];

for j=1:length(start)
    I_cut = I(start(j):stop(j));
    Q_cut = Q(start(j):stop(j));
    
    Data_cut = zeros(1,2*(stop(j)-start(j)+1));
    Data_cut(1:2:length(Data_cut)-1) = I_cut;
    Data_cut(2:2:length(Data_cut)) = Q_cut;
    WriteBin( [ dir_out '/cut/' fileName '_cut' num2str(j, str_fmt) '.data' ], Data_cut);
end


nCuttedFiles = length(start);

if nCuttedFiles == 0
    warning( [ 'Zero detections for file ' fileName ] );
end

