function GenerateSyntheticFile_amplitude(fileName,factor)

data = ReadBin([fileName,'.data']);
data_synthetic = data * factor;

WriteBin(['.\synthetic\',fileName,'_synthetic_amplitude_',num2str(factor),'.data'],data_synthetic);
