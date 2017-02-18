path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Human';
path_data_dog = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Dog';
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

for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i}; 

    [I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
    for j=1:length(I);
        if I(j)<3800 && I(j)>1500 && Q(j)<3800 && Q(j)>1500
            firstValidIndex = j;
            break;
        end
    end
    if (firstValidIndex>1)
        I = I(firstValidIndex:N);
        Q = Q(firstValidIndex:N);
        Data_cut = zeros(1,2*(N-firstValidIndex+1));
        Data_cut(1:2:length(Data_cut)-1) = I;
        Data_cut(2:2:length(Data_cut)) = Q;
        fileName
        WriteBin([fileName,'_cutbadhead.data'],Data_cut);
    end       
end
        