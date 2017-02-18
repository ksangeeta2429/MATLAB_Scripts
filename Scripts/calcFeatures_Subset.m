function calcFeatures_Subset(noise, input, output)
%metafile = fopen('input_data_attributes.txt','r+');
fileWrite = 1;
Rate = 333;

feature_min = [0.411 0.411 0.258 0.002 0.002 0.002 1.385 2 4.154 0.398 1049	0.076 0.02 155.773 -98.4 12	0.043 0.157];
feature_max = [3.838 3.7 3.599 5.101 4.464 4.464 22.188 40 887.518 2.154 21027.25 0.954	0.805 8587.724 167.6 300 2.083 1.114];

if (fileWrite == 1)
    outfile2 = fopen(output,'w');
end

Data = ReadComp(input);
BkData = ReadComp(noise);

FftWindow = Rate;
FftOverlap = round(1/8*FftWindow);
    
% Calculate velocity based features
VelWindow = 3;
VelOverlap = 0.8; 
        
[oldVel1 oldVel2 oldVel3] = SlidingPercentileVelocity(Data,VelWindow,VelOverlap,Rate);
[newVel1 newVel2 newVel3] = ApproxMax(Data,VelWindow,VelOverlap,Rate);

% Calculate phase based features
[dist time distTimeProd distTimeRatio] = DistTime(Data,Rate);
    
%Calculate old spectral features
[fft_freq fft_moment] = AboveBgndFft(Data,BkData,FftWindow,FftOverlap,Rate);
    
%calculate background
if (length(BkData) > 0)
    [BackStats] = ComputeBack(BkData, FftWindow,FftOverlap);
else
    [BackStats] = ComputeBack(Data, FftWindow,FftOverlap);
end

meanBack = BackStats(1:FftWindow);
stdBack = BackStats(FftWindow+1:2*FftWindow);

%calculate above background
Img = AnomImage(Data, FftWindow, FftOverlap, Rate, meanBack, stdBack, 3);
percentFreq = PropMeas(Img);

Freq = FftFreq(double(FftWindow), double(Rate));
secMoment = SecondMomentMeas(Img, Freq);

maxFreq = MaxFreqMeas(Img, Freq,0.9,15);
freqWidth = FreqWidthMeas(Img,4,7);

if (fileWrite == 1)
    fprintf(outfile2,'3 ');
    fprintf(outfile2,'1:%5.3f ',scaled(oldVel1,1));
    fprintf(outfile2,'2:%5.3f ',scaled(oldVel2,2));
    fprintf(outfile2,'3:%5.3f ',scaled(oldVel3,3));
    fprintf(outfile2,'4:%5.3f ',scaled(newVel1,4));
    fprintf(outfile2,'5:%5.3f ',scaled(newVel2,5));
    %fprintf(outfile2,'6:%5.3f ',scaled(newVel3,6));
    fprintf(outfile2,'6:%5.3f ',scaled(dist,7));
    %fprintf(outfile2,'8:%5.3f ',scaled(time,8));
    %fprintf(outfile2,'9:%5.3f ',scaled(distTimeProd,9));
    fprintf(outfile2,'7:%5.3f ',scaled(distTimeRatio,10));
    fprintf(outfile2,'8:%5.3f ',scaled(fft_freq,11));
    fprintf(outfile2,'9:%5.3f ',scaled(fft_moment,12));
    fprintf(outfile2,'10:%5.3f ',scaled(percentFreq,13));
    fprintf(outfile2,'11:%5.3f ',scaled(secMoment,14));
    %fprintf(outfile2,'15:%5.3f ',scaled(maxFreq,15));
    %fprintf(outfile2,'16:%5.3f ',scaled(freqWidth,16));
    fprintf(outfile2,'\n');
end

fclose all;

function out = scaled(val, index)
    if (val <= feature_min(index))
        out = feature_min(index);
    elseif (val >= feature_max(index))
        out = feature_max(index);
    else
        out = (val-feature_min(index))/(feature_max(index)-feature_min(index));
    end
end

end
