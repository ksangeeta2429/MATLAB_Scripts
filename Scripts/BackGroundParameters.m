

mul = 1.5;

path_data_noise = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Noise';



cd(path_data_noise);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if k>=2
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

%thr = zeros(length(Files),256);
thr = zeros(1, length(Files));
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i}; 
    [I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
    BkData = (I-mean(I)) + i*(Q-mean(Q));
    [medianBack,stdBack] = ComputeBack(BkData, 256, 64);
%     thr(i,:) = medianBack+mul*stdBack;
    thr(i) = medianBack+mul*stdBack;
end

% meadian_thr_on_diff_freq = median(thr);
% meadian_thr_on_diff_freq_sqr_Csharp = (meadian_thr_on_diff_freq./512).^2;
% GenerateArrInCsharp(meadian_thr_on_diff_freq_sqr_Csharp,'thr_sqr_Csharp');
% GenerateArrInCsharp(meadian_thr_on_diff_freq, 'thr_matlab');

thr_matlab = median(thr)
thr_sqr_Csharp = (thr_matlab/512)^2

