function calcFeaturesHumanCar() %noise, input, output
%metafile = fopen('input_data_attributes.txt','r+');

I = randi(4095,1,512);
Q = randi(4095,1,512);
I=I-2048;
Q=Q-2048;
Data=I+i*Q;
Data=Data';
BkData = zeros(size(Data));



fileWrite = 0;  %1
Rate = 250;

feature_min = [1.143 0.979 0.979 1.242 1.089 1.089 2.364 3.012 7.91	0.601 473.364 0.021	0.003 88.218 -1000 10 0.015	0.257];
feature_max = [3.897 3.862 3.294 4.23 3.973	3.67 19.015	16.97 322.681 1.579	16562 0.667	0.451 7600.743 155.6 333 1.532 1.032];

if (fileWrite == 1)
    outfile2 = fopen(output,'w');
end

%Data = ReadComp(input);
%BkData = ReadComp(noise);

lambda = 3e8/5.8e9;
Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* lambda/2;

winLen = 2*Rate;
hit=zeros(1,length(Range));
lastIndex = -7*Rate;
hitActive = 0;

startHit = -1;
stopHit = -1;
doneHit = 0;


% for j=1:length(Range)
%     if (doneHit == 0)
%         if (j-winLen + 1 <= 0)
%             st = 1;
%         else
%             st = j-winLen + 1;
%         end
%         
%         %fprintf('%d\n',abs(max(Range(st:st+winLen - 1))));
%         %fprintf('%d\n',abs(max(Range(st:st+winLen - 1))));
%         if((abs(max(Range(st:st+winLen-1)) - min(Range(st:st+winLen-1))) > 0.6))
%             if (hitActive == 0)
%                 if (j > winLen)
%                     startHit = j-winLen;
%                 else
%                     startHit = 1;
%                 end
%             end
%             hitActive = 1;
%             lastIndex = j;
%         end
% 
%         if (hitActive == 1)
%             hit(j) = 1;
%         end
% 
%         if (hitActive == 1 && (j - lastIndex > 6*Rate))
%             hitActive = 0;
%             stopHit = j - 6*Rate;
%             doneHit = 1;
%         end
%     end
% end
% 
% if (stopHit == -1)
%     if (j - 6*Rate > 0)
%         stopHit = j - 6*Rate;
%     elseif (j - 3*Rate > 0)
%         stopHit = j - 3*Rate;
%     else
%         stopHit = j;
%     end
% end
% 
% if((stopHit == -1) || (startHit == -1))
%     fprintf('Insufficient Data To Classify');
%     return;
% end
% 
% Data = Data(startHit:stopHit);

FftWindow = Rate;
FftStep = round(1/8*FftWindow);
    
% Calculate velocity based features
VelWindow = 3;
VelOverlap = 0.8; 
        
oldVel1 = SlidingPercentileVelocity(Data,VelWindow,VelOverlap,Rate, 0.9);
oldVel2 = SlidingPercentileVelocity(Data,VelWindow,VelOverlap,Rate, 0.7);
oldVel3 = SlidingPercentileVelocity(Data,VelWindow,VelOverlap,Rate, 0.5);
    
newVel1 = ApproxMax(Data,VelWindow,VelOverlap,Rate, 0.9);
newVel2 = ApproxMax(Data,VelWindow,VelOverlap,Rate, 0.7);
newVel3 = ApproxMax(Data,VelWindow,VelOverlap,Rate, 0.5);

% Calculate phase based features
[dist, time, distTimeProd, distTimeRatio] = DistTime(Data,Rate);
    
%Calculate old spectral features
[fft_moment, fft_freq] = AboveBgndFft(Data,BkData,FftWindow,FftStep,Rate);
    
%calculate background
if (~isempty(BkData))
    BackStats = ComputeBack(BkData, FftWindow,FftStep);
else
    BackStats = ComputeBack(Data, FftWindow,FftStep);
end

meanBack = BackStats(1:FftWindow);
stdBack = BackStats(FftWindow+1:2*FftWindow);

%calculate above background
Img = AnomImage(Data, FftWindow, FftStep, Rate, meanBack, stdBack, 3);
percentFreq = PropMeas(Img);

Freq = FftFreq(FftWindow, Rate);
secMoment = SecondMomentMeas(Img, Freq);

maxFreq = MaxFreqMeas(Img, Freq,0.9,15);
freqWidth = FreqWidthMeas(Img,4,7);

accRange = AccRange(Data,0.5,0.8,Rate,0.9);
veloVar = VeloVarMinMax(Data, 0.5, 0.8, Rate, 0.1,0.9);

if (fileWrite == 1)
    fprintf(outfile2,'3 ');
    fprintf(outfile2,'1:%5.3f ',scaled(oldVel1,1));
    fprintf(outfile2,'2:%5.3f ',scaled(oldVel2,2));
    fprintf(outfile2,'3:%5.3f ',scaled(oldVel3,3));
    fprintf(outfile2,'4:%5.3f ',scaled(newVel1,4));
    fprintf(outfile2,'5:%5.3f ',scaled(newVel2,5));
    fprintf(outfile2,'6:%5.3f ',scaled(newVel3,6));
    fprintf(outfile2,'7:%5.3f ',scaled(dist,7));
    fprintf(outfile2,'8:%5.3f ',scaled(time,8));
    fprintf(outfile2,'9:%5.3f ',scaled(distTimeProd,9));
    fprintf(outfile2,'10:%5.3f ',scaled(distTimeRatio,10));
    fprintf(outfile2,'11:%5.3f ',scaled(fft_moment,11));
    fprintf(outfile2,'12:%5.3f ',scaled(fft_freq,12));
    fprintf(outfile2,'13:%5.3f ',scaled(percentFreq,13));
    fprintf(outfile2,'14:%5.3f ',scaled(secMoment,14));
    fprintf(outfile2,'15:%5.3f ',scaled(maxFreq,15));
    fprintf(outfile2,'16:%5.3f ',scaled(freqWidth,16));
    fprintf(outfile2,'17:%5.3f ',scaled(accRange,17));
    fprintf(outfile2,'18:%5.3f ',scaled(veloVar,18));
    fprintf(outfile2,'\n');
end

fclose all;

function out = scaled(val, index)
    if (val <= feature_min(index))
        out = 0;
    elseif (val >= feature_max(index))
        out = 1;
    else
        out = (val-feature_min(index))/(feature_max(index)-feature_min(index));
    end
end

end
