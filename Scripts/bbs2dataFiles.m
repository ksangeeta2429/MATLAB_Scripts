path_data = 'C:\Users\he\Documents\Dropbox\ADAPT Data Collection\Radar\Debugging\Low impedance phasing';

cd(path_data);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.bbs');
    if ~isempty(k) && k>=2 && k+3==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i} 
    bbs2data(fileName,path_data);
%     pause;
end