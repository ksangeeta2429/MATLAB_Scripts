% to balance data
% check the number of samples for each number of people

%root='C:/Users/heji/Dropbox/MyMatlabWork/';
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/matlab2weka']);
addpath([root,'radar/STC/scripts']);

path_data=[root,'radar/STC/data files/old_radar_dataset/full_balanced'];
cd(path_data);
fileFullNames=dir(path_data);

nSamples=zeros(1,50);
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    if length(s)>=3
        fid = fopen(s);
        data = fread(fid, inf, 'int16');
        N=length(data)/2;
        n=ExtractNumFromFileName(s);
        nSamples(n+1)=nSamples(n+1)+N;
    end
end
fclose('all');
figure;plot(0:49,nSamples)