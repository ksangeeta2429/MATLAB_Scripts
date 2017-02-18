function GenerateSyntheticFile_phase_speed(fileName,scalingFactor)

data = ReadBin([fileName,'.data']);

len = length(data);
len_synthetic = ceil(len/scalingFactor);
data_synthetic = zeros(1,len_synthetic);
for i=1:len_synthetic
    j = round(i*scalingFactor);
    if j>len
        j=len;
    end
    if j<=0
        j=1;
    end
    data_synthetic(i) = data(j);
end
WriteBin(['.\synthetic2\',fileName,'_synthetic_phase_speed_',num2str(scalingFactor),'.data'],data_synthetic);
