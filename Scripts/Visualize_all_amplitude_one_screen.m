% clear all;
function Visualize_all_amplitude_one_screen(path_data,sampRate,RAW,high_percentile,low_percentile)
clc;close all

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

%path_amp = 'amplitude/';
%if exist(path_amp, 'dir') ~= 7
%    mkdir(path_amp);
%    fprintf('INFO: created directory %s\n', path_amp);
%end

%calculate m and n for grid in figure
p = ceil(power(length(Files),0.5));
%p = 8
n = p; m = p;
x = 0:400:3000;
figure('units','normalized','outerposition',[0 0 1 1])
medians = []; medians_I = []; medians_Q = []; peaks = []; peaks_I = []; peaks_Q = [];
median_percentile = []; 
if(length(Files) < 64)
    num_files = length(Files);
else
    num_files = 64;
end

for i=1:num_files % take every file from the set 'Files'
    if(rem(i,10) == 0)
        sprintf('%dth file is processing: %s\n',i,char(Files{i})) % the i-th file is processing
    end
    fileName=Files{i};
    fprintf('%s    ',fileName);
    data = ReadBin([fileName,'.data']);
    [I,Q,N]=Data2IQ(data);
   
    temp = (I-median(I)) + 1i*(Q-median(Q));
    med = median(abs(temp));
    abs(temp);
    median_percentile = [median_percentile prctile(abs(temp),high_percentile)];
    medians = [medians med];
    peaks = [peaks abs(max(temp))];
    
    medians_I = [medians_I median(abs(I-median(I)))];
    medians_Q = [medians_Q median(abs(Q-median(Q)))];

    Index = ([1:N])/sampRate;
    subplot(m,n,i);
    %set(h(1), 'position', [100, 100, 100, 100] );
    %if(max(Q-median(Q)) < 200 || max(I-median(I)) < 200)
     %   %reject
     %   continue
    %end
    
    if(RAW == 0)
        %plot(Index,Q-median(Q),'g'),hold on,grid on
        %plot(Index,I-median(I),'r'),hold off
        plot(Index,abs(temp),'r')
        I_prctile = prctile(abs(I-median(I)),high_percentile);
        Q_prctile = prctile(abs(Q-median(Q)),high_percentile);
    else
        plot(Index,Q,'g'),hold on,grid on
        plot(Index,I,'r'),hold off
        I_prctile = prctile(I,high_percentile);
        Q_prctile = prctile(Q,high_percentile);
    end
    
    
    %plot(abs(data),'r'); %hold on,grid on  %%% red is I,  green is Q. remember:hong pei lv, hong zai qian
    peak_Q = max(abs(Q-median(Q))); mean_Q = mean(Q); median_Q = median(Q); std_Q = std(Q);
    peak_I = max(abs(I-median(I))); mean_I = mean(I); median_I = median(I); std_I = std(I);
    abs_peak = max(abs(data));
    
    peaks_I = [peaks_I peak_I]; peaks_Q = [peaks_Q peak_Q];
    %disp(mean(I-median(I)));
    %plot(Index,Q-median(Q),'g'); %hold off
    
    %title(strcat('PeakI: ',string(peak_I),'PeakQ: ',string(peak_Q)))
    %title([strcat('\fontsize{8}Peak I: ',string(peak_I),' Q: ',string(peak_Q))])
    title(fileName)
    %title(strcat('95th I: ',string(I_prctile),' 95th Q: ',string(Q_prctile)))
    %title(strcat('PeakQ: ',string(peak_Q),'Peak_abs:',string(abs_peak)))

end

median_percentile;
medians

fprintf('\n%f percentile of absolute medians : %f\n',high_percentile,prctile(medians,high_percentile));
fprintf('%f percentile of I medians : %f\n',high_percentile,prctile(medians_I,high_percentile));
fprintf('%f percentile of Q medians : %f\n',high_percentile,prctile(medians_Q,high_percentile));
fprintf('\nMedian of absolute medians : %f\n',median(medians));

fprintf('%f percentile of absolute peaks : %f\n',high_percentile,prctile(peaks,high_percentile));
fprintf('%f percentile of I peaks : %f\n',high_percentile,prctile(peaks_I,high_percentile));
fprintf('%f percentile of Q peaks : %f\n',high_percentile,prctile(peaks_Q,high_percentile));

fprintf('%f percentile of absolute medians : %f\n',low_percentile,prctile(medians,low_percentile));
fprintf('%f percentile of I medians : %f\n',low_percentile,prctile(medians_I,low_percentile));
fprintf('%f percentile of Q medians : %f\n',low_percentile,prctile(medians_Q,low_percentile));

fprintf('%f percentile of absolute peaks : %f\n',low_percentile,prctile(peaks,low_percentile));
fprintf('%f percentile of I peaks : %f\n',low_percentile,prctile(peaks_I,low_percentile));
fprintf('%f percentile of Q peaks : %f\n',low_percentile,prctile(peaks_Q,low_percentile));

set(gcf,'PaperPositionMode','auto')
savefig(strcat(path_data,'a_some_amplitudes'));
print(strcat(path_data,'a_some_amplitudes_png'),'-dpng');

end