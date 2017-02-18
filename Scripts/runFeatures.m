% run feature computations for the data contained in the metadata file
% and write output in weka or libsvm compatible formats if required
% you can run arbitrary features and parameters here - each one just needs
% to be named differently in weka. The current subset is based on some
% feature selection done in Weka. May need to rerun the entire param space
% for a different target

function runFeatures(input, filename)
metafile = fopen(input,'r+');

wekaWrite = 1;
libsvmWrite = 1;

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

% read each line of the metadata file
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
    
    % if this is non-noise then noise range will be specified next
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
    
    %calculate background - for noise data, the data itself is the
    %background
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
    
    % write out the feature values so that they can be imported into weka
    if (wekaWrite == 1)
        fprintf(outfile,'%s',Type);
        fprintf(outfile,',%5.3f',oldVel1);
        fprintf(outfile,',%5.3f',oldVel2);
        fprintf(outfile,',%5.3f',oldVel3);
        fprintf(outfile,',%5.3f',newVel1);
        fprintf(outfile,',%5.3f',newVel2);
        fprintf(outfile,',%5.3f',newVel3);
        fprintf(outfile,',%5.3f',dist);
        fprintf(outfile,',%5.3f',time);
        fprintf(outfile,',%5.3f',distTimeProd);
        fprintf(outfile,',%5.3f',distTimeRatio);
        fprintf(outfile,',%5.3f',fft_freq);
        fprintf(outfile,',%5.3f',fft_moment);
        fprintf(outfile,',%5.3f',percentFreq);
        fprintf(outfile,',%5.3f',secMoment);
        fprintf(outfile,',%5.3f',maxFreq);
        fprintf(outfile,',%5.3f',freqWidth);
        fprintf(outfile,',%5.3f',accRange);
        fprintf(outfile,',%5.3f',veloVar);
        fprintf(outfile,'\n');
    end

        % write out the feature values so that they can be imported into
        % libsvm. libsvm doesnt like strings for target types
    if (libsvmWrite == 1)
        if(strcmp(Type,'dog') == 1)
            fprintf(outfile2,'1 ');
        else
            fprintf(outfile2,'2 ');
        end
            
        fprintf(outfile2,'1:%5.3f ',oldVel1);
        fprintf(outfile2,'2:%5.3f ',oldVel2);
        fprintf(outfile2,'3:%5.3f ',oldVel3);
        fprintf(outfile2,'4:%5.3f ',newVel1);
        fprintf(outfile2,'5:%5.3f ',newVel2);
        fprintf(outfile2,'6:%5.3f ',newVel3);
        fprintf(outfile2,'7:%5.3f ',dist);
        fprintf(outfile2,'8:%5.3f ',time);
        fprintf(outfile2,'9:%5.3f ',distTimeProd);
        fprintf(outfile2,'10:%5.3f ',distTimeRatio);
        fprintf(outfile2,'11:%5.3f ',fft_freq);
        fprintf(outfile2,'12:%5.3f ',fft_moment);
        fprintf(outfile2,'13:%5.3f ',percentFreq);
        fprintf(outfile2,'14:%5.3f ',secMoment);
        fprintf(outfile2,'15:%5.3f ',maxFreq);
        fprintf(outfile2,'16:%5.3f ',freqWidth);
        fprintf(outfile2,'17:%5.3f',accRange);
        fprintf(outfile2,'18:%5.3f',veloVar);
        fprintf(outfile2,'\n');
    end
    
    close all;
    Line = textscan(metafile,'%d %s %d %d %d %s %d %d',1);
end

fclose all;

