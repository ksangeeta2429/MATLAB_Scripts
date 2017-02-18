% to get scaled feature values, run the features first normally
% then offline find out the max and min values for the features
% then normalize each feature using the min-max to be in [0:1]
% weka can normalize the data automatically during analysis
% but libsvm requires normalized data in [0:1] range for efficiency

function runFeatures(input, filename)
metafile = fopen(input,'r+');

wekaWrite = 1;
libsvmWrite = 1;

feature_min = [0.411 0.411 0.258 0.002 0.002 0.002 1.385 2 4.154 0.398 1049	0.076 0.02 155.773 -98.4 12	0.043 0.157];
feature_max = [3.838 3.7 3.599 5.101 4.464 4.464 22.188 40 887.518 2.154 21027.25 0.954	0.805 8587.724 167.6 300 2.083 1.114];

if (wekaWrite == 1)
    outfile = fopen(filename,'w');
    
    %populate metadata
    fprintf(outfile, '@relation target-classification\n\n');
    
    fprintf(outfile, '@attribute class {noise, human, dog}\n');
    fprintf(outfile, '@attribute oldVel1 numeric \n');
    fprintf(outfile, '@attribute oldVel2 numeric \n');
    fprintf(outfile, '@attribute oldVel3 numeric \n');
    fprintf(outfile, '@attribute newVel1 numeric \n');
    fprintf(outfile, '@attribute newVel2 numeric \n');
    fprintf(outfile, '@attribute newVel3 numeric \n');
    fprintf(outfile, '@attribute dist numeric \n');
    fprintf(outfile, '@attribute time numeric \n');
    fprintf(outfile, '@attribute distTimeProd numeric \n');
    fprintf(outfile, '@attribute distTimeRatio numeric \n');
    fprintf(outfile, '@attribute fftfreq numeric \n');
    fprintf(outfile, '@attribute fftmoment numeric \n');
    fprintf(outfile, '@attribute percentFreq numeric \n');
    fprintf(outfile, '@attribute secMoment numeric \n');
    fprintf(outfile, '@attribute maxFreq numeric \n');
    fprintf(outfile, '@attribute freqWidth numeric \n');
    fprintf(outfile, '@attribute accRange numeric \n');
    fprintf(outfile, '@attribute veloMinMax numeric \n');
    fprintf(outfile, '@data \n');
    
end

if (libsvmWrite == 1)
    outfile2 = fopen(sprintf('svm_%s',filename),'w');
end

Line = textscan(metafile,'%d %s %d %d %d %s %d %d',1);

while (Line{1} > 0)
    filename = sprintf('Data/%s.data',char(Line{2}));
    fprintf('%d: \n',Line{1});
    Rate = Line{5};
    startTarg = Line{3};
    stopTarg = Line{4};
    Type = char(Line{6});

    Comp = ReadComp(filename);
    Data = Comp(startTarg*Rate+1:stopTarg*Rate);

    FftWindow = Rate;
    FftOverlap = round(1/8*FftWindow);
    
    if (strcmp(Type,'dog') == 1 || strcmp(Type,'human') == 1)
        startBk = Line{7};
        stopBk = Line{8};
        BkData = Comp(startBk*Rate+1:stopBk*Rate);
    else
        BkData = [];
    end
        
    % Calculate velocity based features
    VelWindow = 3;
    VelOverlap = 0.8; 
        
    [oldVel1 oldVel2 oldVel3] = SlidingPercentileVelocity(Data,VelWindow,VelOverlap,Rate);
    [newVel1 newVel2 newVel3] = ApproxMax(Data,VelWindow,VelOverlap,Rate);

    [dist time distTimeProd distTimeRatio] = DistTime(Data,Rate);
    
    %Calculate spectral features
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

    accRange = AccRange(Data,0.5,0.8,Rate,0.9);
    veloVar = VeloVarMinMax(Data, 0.5, 0.8, Rate, 0.1,0.9);
    
    if (wekaWrite == 1)
        fprintf(outfile,'%s',Type);
        fprintf(outfile,',%5.3f',scaled(oldVel1,1));
        fprintf(outfile,',%5.3f',scaled(oldVel2,2));
        fprintf(outfile,',%5.3f',scaled(oldVel3,3));
        fprintf(outfile,',%5.3f',scaled(newVel1,4));
        fprintf(outfile,',%5.3f',scaled(newVel2,5));
        fprintf(outfile,',%5.3f',scaled(newVel3,6));
        fprintf(outfile,',%5.3f',scaled(dist,7));
        fprintf(outfile,',%5.3f',scaled(time,8));
        fprintf(outfile,',%5.3f',scaled(distTimeProd,9));
        fprintf(outfile,',%5.3f',scaled(distTimeRatio,10));
        fprintf(outfile,',%5.3f',scaled(fft_freq,11));
        fprintf(outfile,',%5.3f',scaled(fft_moment,12));
        fprintf(outfile,',%5.3f',scaled(percentFreq,13));
        fprintf(outfile,',%5.3f',scaled(secMoment,14));
        fprintf(outfile,',%5.3f',scaled(maxFreq,15));
        fprintf(outfile,',%5.3f',scaled(freqWidth,16));
        fprintf(outfile,',%5.3f',scaled(accRange,17));
        fprintf(outfile,',%5.3f',scaled(veloVar,18));
        fprintf(outfile,'\n');
    end
    
    if (libsvmWrite == 1)
        if(strcmp(Type,'dog') == 1)
            fprintf(outfile2,'1 ');
        else
            fprintf(outfile2,'2 ');
        end
            
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
        fprintf(outfile2,'11:%5.3f ',scaled(fft_freq,11));
        fprintf(outfile2,'12:%5.3f ',scaled(fft_moment,12));
        fprintf(outfile2,'13:%5.3f ',scaled(percentFreq,13));
        fprintf(outfile2,'14:%5.3f ',scaled(secMoment,14));
        fprintf(outfile2,'15:%5.3f ',scaled(maxFreq,15));
        fprintf(outfile2,'16:%5.3f ',scaled(freqWidth,16));
        fprintf(outfile2,'17:%5.3f ',scaled(accRange,17));
        fprintf(outfile2,'18:%5.3f ',scaled(veloVar,18));
        fprintf(outfile2,'\n');
    end
    
    close all;
    Line = textscan(metafile,'%d %s %d %d %d %s %d %d',1);
end

fclose all;

function out = scaled(val, index)
    out = (val-feature_min(index))/(feature_max(index)-feature_min(index));
end

end
