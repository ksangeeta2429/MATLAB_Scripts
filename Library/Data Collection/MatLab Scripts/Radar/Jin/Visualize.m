% plot data, spectrogram, histogram, features


%function Visualize(fileName)
close all;
fileName='264_1p_far';%357_5p_class_rb 369_4p_class_lb1 %369_35p_class_lb 369_35p_class_lb  357_5p_class_rb(in lunwen, plot figure 3 4 6, corresponding to feature3_1 feature3_2 feature3_3)
addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts/matlab2weka');
addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts');
addpath('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/scripts/gaussgradient');

path_data='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/data files/new_radar_dataset/full';
path_data='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\data files\candidacy';
cd(path_data);

data=ReadBin(fileName);
nSample=length(data)/2;


ifBackground=1;  % 1 to save background hist,0 not
PLOTFRAMES=1; % 1 if display frames, 0 if display the whole file 
DISPALL=0; % 1 if diplay all the frames, 0 if display a single frame
frameIndex=1;%frameIndex+1;
nFigure=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%% plot
% m=ceil(nFigure^0.5);

figure;
if PLOTFRAMES==0
    plotData(fileName,300,0,0); 
else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample*2/18000);
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotData(fileName,300, 18000*(i-1),1); 
        end
    else
        plotData(fileName,300,18000*(frameIndex-1),1);
    end
end


% figure;
% for i=1:nFigure
%     subplot(m,m,i);
%     if DISPALL==1
%         plotPhase(fileName,300,18000*(i-1)+plotOffset,1);
%     else
%         plotPhase(fileName,300,18000*(i-1)+plotOffset,0);
%     end
% end
% 
% 
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
    plotSpect(fileName, 256,256-16,256,300, 0,0); 
else % PLOTFRAMES=1
    if DISPALL==1
        nFigure=floor(nSample*2/18000);
        for i=1:nFigure
             m=ceil(nFigure^0.5);
             subplot(m,m,i);
             plotSpect(fileName, 256,256-16,256,300, 18000*(i-1),1); 
        end
    else
        plotSpect(fileName, 256,256-16,256,300, 18000*(frameIndex-1),1);
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


