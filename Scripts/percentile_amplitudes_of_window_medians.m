function [percentiles] = percentile_amplitudes_of_window_medians(path_data,sampRate,prcentile,windowSize,plotTitle,targetType)

SetEnvironment
SetPath

cd(path_data);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if ~isempty(k) && k>=2 && k+4==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

numFiles = length(Files);

step = sampRate*windowSize
global_medians = []; percentiles = [];
for i=1:numFiles
    fileName=Files{i};
    %fprintf('%s  ',fileName);
    data = ReadBin([fileName,'.data']);
    [I,Q,N]=Data2IQ(data);
    Comp = (I-median(I)) + 1i*(Q-median(Q));
    global_medians = [global_medians median(abs(Comp))];
    window_medians = [];
    for j = 1:step:length(Comp)-step
        %fprintf('%d  ',j);
        one_window_signal = Comp(j:j+step-1);
        window_medians = [window_medians median(abs(one_window_signal))];
    end
    percentiles = [percentiles prctile(window_medians,prcentile)];
end
fprintf('\n');
index = 1:length(percentiles);
figure('units','normalized','outerposition',[0 0 1 1])
p = plot(index,percentiles,'*');
title(plotTitle);
ylabel(strcat(string(prcentile),' Percentile Window size  ',string(windowSize),'  seconds'));
set(gcf,'PaperPositionMode','auto')
print(strcat(path_data,'percentile_small_windows_',targetType,'_medians'),'-dpng');

mat2str(percentiles);
end