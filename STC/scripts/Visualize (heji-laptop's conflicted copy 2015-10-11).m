% plot data, spectrogram, histogram, features


%function Visualize(fileName)
close all;
fileName='tmpcopy';%357_5p_class_rb 369_4p_class_lb1 %369_35p_class_lb 369_35p_class_lb  357_5p_class_rb(in lunwen, plot figure 3 4 6, corresponding to feature3_1 feature3_2 feature3_3)
addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts/matlab2weka');
addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts');
addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts/gaussgradient');

path_data='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/data files/new_radar_dataset/full';
path_data='C:\Users\he\My Research\2014.8\201410011-arc';
 path_data='C:\Users\he\Documents\Dropbox\MyC#Work\emote4jin\Data Collector 1.2\Data Collector Host 1.2\Data Collector Host\bin\Debug';
% path_data='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\data files\candidacy';
cd(path_data);

data=ReadBin(fileName);

% fileName = 'C:\Users\he\My Research\2014.8\bb-20140916-T1005-fan\bb-20140916-T1005-fan-3m-highspeed-256hz-IQ.log'
% data = textread(fileName)
% data = data';
% data = data(:);
% fid = fopen('C:\Users\he\My Research\2014.8\bb-20140916-T1005-fan\fan_highspeed.data','w+');
% fwrite(fid,data,'int16');
% fclose('all');

nSample=length(data)/2;

SampRate = 256;
Step = 16;

ifBackground=1;  % 1 to save background hist,0 not
PLOTFRAMES=0; % 1 if display frames, 0 if display the whole file 
DISPALL=0; % 1 if diplay all the frames, 0 if display a single frame
frameIndex=1;%frameIndex+1;
nFigure=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%% plot
% m=ceil(nFigure^0.5);

figure;
if PLOTFRAMES==0
    plotData(fileName,256,0,0); 
else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample/SampRate/30);
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotData(fileName,SampRate, 2*SampRate*30*(i-1),1); 
        end
    else
        plotData(fileName,SampRate,2*SampRate*30*(frameIndex-1),1);
    end
end


%%%%%% Plot phase
figure;
if PLOTFRAMES==0
    plotPhase(fileName,SampRate,0,0); 
else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample/SampRate/30);
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotPhase(fileName,SampRate, 2*SampRate*30*(i-1),1); 
        end
    else
        plotPhase(fileName,SampRate,2*SampRate*30*(frameIndex-1),1);
    end
end




% figure;
% for i=1:nFigure
%     subplot(m,m,i);
%     if DISPALL==1
%         plotDiffPhase(fileName,300,18000*(i-1)+plotOffset,1,1);
%     else
%         plotDiffPhase(fileName,300,18000*(i-1)+plotOffset,0,1);
%     end
% end



%figure;
if PLOTFRAMES==0
    plotSpect(fileName, SampRate,SampRate-Step,SampRate,SampRate, 0, 0); 
else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample/SampRate/30);
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotSpect(fileName, SampRate,SampRate-Step,SampRate,SampRate, 2*SampRate*30*(i-1),1); 
        end
    else
        plotSpect(fileName, SampRate,SampRate-Step,SampRate,SampRate, 2*SampRate*30*(frameIndex-1),1);
    end
end


% figure;
% for i=1:nFigure
%     subplot(m,m,i);
%     plotHist(fileName, 256,256*(1-1/4),256,300, 18000*(i-1)+plotOffset); 
% end
% 
% 
% figure;
% for i=1:nFigure
%     subplot(m,m,i);
%     plotPSD(fileName, 18000*(i-1)+plotOffset); 
% end


