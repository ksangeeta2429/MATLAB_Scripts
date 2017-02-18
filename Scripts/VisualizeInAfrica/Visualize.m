% plot data, spectrogram, histogram, features
% display the data I Q in C# format

function Visualize(fileName, path_data)

% path_data='C:\Users\he\Documents\Dropbox\MyC#Work\emote4jin\Data Collector 1.2\Data Collector Host 1.2\Data Collector Host\bin\Debug';
% fileName='tmp1';
% addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Scripts\VisualizeInAfrica');

close all;
% figure;

cd(path_data);



sampRate = 256;
step=64;
frameSeconds=60;
ifBackground=1;  % 1 to save background hist,0 not
PLOTFRAMES=0; % 1 if display frames, 0 if display the whole file 
DISPALL=0; % 1 if diplay all the frames, 0 if display a single frame
frameIndex=1;
nFigure=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%% plot
% m=ceil(nFigure^0.5);


if PLOTFRAMES==0
    plotData(fileName,sampRate,frameSeconds,0,0); %300
else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample*2/(2*sampRate*frameSeconds));
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotData(fileName,sampRate,frameSeconds,(2*sampRate*frameSeconds)*(i-1),1); 
        end
    else
        plotData(fileName,sampRate,frameSeconds,(2*sampRate*frameSeconds)*(frameIndex-1),1);
    end
end
print('-dbitmap', [fileName,'.data.emf']);


if PLOTFRAMES==0
    plotPhase(fileName,sampRate,frameSeconds,0,0); 
else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample*2/(2*sampRate*frameSeconds));
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotPhase(fileName,sampRate,frameSeconds,(2*sampRate*frameSeconds)*(i-1),1); 
        end
    else
        plotPhase(fileName,sampRate,frameSeconds,(2*sampRate*frameSeconds)*(frameIndex-1),1);
    end
end
print('-dbitmap', [fileName,'.phase.emf']);


if PLOTFRAMES==0
    plotSpect(fileName, sampRate,sampRate-step,sampRate,sampRate,frameSeconds,0,0);
%     figure;imagesc(T,F,bw1);colormap(gray);axis xy;

else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample*2/(2*sampRate*frameSeconds));
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotSpect(fileName, sampRate,sampRate-step,sampRate,sampRate,frameSeconds,(2*sampRate*frameSeconds)*(i-1),1); 
        end
    else
        plotSpect(fileName, sampRate,sampRate-step,sampRate,sampRate,frameSeconds,(2*sampRate*frameSeconds)*(frameIndex-1),1);
    end
end
print('-dbitmap', [fileName,'.spect.emf']);


