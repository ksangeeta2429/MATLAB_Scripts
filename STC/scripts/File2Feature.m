% input: a file name
% output: feature matrix, each row is a frame


function f_file=File2Feature(fileName, secondsPerFrame,fClass,ifReg,ifTrimsample,ClassDef, indexFile)
%ifTrimsample=1; % cut every file by only leave first 5(?) samples or the full file if not enough for 5
%ifReg=0;

sampRate=250;
WINDOW = sampRate;
NFFT = nextpow2(sampRate);
%NFFT = sampRate;
fileName;
%roomInFilename=ExtractRoomFromFileName(fileName);
nPeople=ExtractNumFromFileName(fileName);
if ifReg==0
    classIndex=num2str(classMapping(nPeople,ClassDef));
else
    classIndex=classMapping(nPeople,ClassDef);
end

data = ReadBin(fileName);
[I,Q,N]=Data2IQ(data);

%added by neel. Old human data is sampled at rate 256 and new data at 250
%use secondsPerFrame same as length of the cuts since the cuts for new data are much smaller 
N;
if(rem(N,256) == 0)
    sampRate = 256;
    secondsPerFrame = N/sampRate;
elseif(rem(N-1,125) == 0)
    sampRate = 250;
    secondsPerFrame = (N-1)/sampRate; %for some reason there is one extra sample
end


%[m,s]=LocalNoise(fileName,256,256*(1-1/16),10,NFFT,sampRate);  % get noise level
[m,s]=LocalNoise(fileName,WINDOW,WINDOW*(1-1/16),1,NFFT,sampRate);
%%%%%%% framing the data %%%%%%%%%%%%%
pointsPerFrame=sampRate*secondsPerFrame;
nFrames=2*floor(N/pointsPerFrame)-1;
% nFrames=floor(N/pointsPerFrame);


if ifTrimsample==1 && nFrames>0 % if too short then no need to trim - 0 frames
    nFrames=1; %min([nFrames 5]);  % cut the file by leaving the first several frames
end

f_file=[];%{};%[];

if nFrames>0       % at least 1 frame, not too short
    for k=1:nFrames      % take every frame from the file
        Iframe=I(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);
        Qframe=Q(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);
%         Iframe=I(1+(k-1)*pointsPerFrame:k*pointsPerFrame);        
%         Qframe=Q(1+(k-1)*pointsPerFrame:k*pointsPerFrame);

        f_frame=IQ2Feature(Iframe, Qframe, sampRate, m, s,fClass,WINDOW,NFFT,sampRate); % features
        if ifReg==0 %Classification
            f_frame=num2cell(f_frame);
        end
        
        f_frame1=[f_frame classIndex]; %  [f_frame indexFile classIndex];  add indexFile and classIndex at the last
        f_file=[f_file;f_frame1];
    end
end
