SetEnvironment
SetPath

path = strcat(g_str_pathbase_data,'/Humanvsbike_new_detector/austere_bike/')
cd(path);
fileFullNames=dir;

Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(Files) % take every file from the set 'Files'
    if mod(i,10)==0
        %sprintf('Human - %dth file is processing\n',i) % Report every 10 files-the i-th file is processing
    end
    fileName=Files{i};
    [I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
    dcI = median(I);
    dcQ = median(Q);

    Data = (I-dcI) + 1i*(Q-dcQ);
    if(length(Data) < 256)
        fprintf('%s length : %d\n',fileName,length(Data));
    end
end