function GenerateSyntheticFile_amplitude(fileName,scalingFactor)

data = ReadBin([fileName,'.data']);
data_synthetic = data * scalingFactor;

WriteBin(['.\synthetic1\',fileName,'_synthetic_amplitude_',num2str(scalingFactor),'.data'],data_synthetic);
