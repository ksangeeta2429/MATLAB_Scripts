% manually cut file

% function CutFile_manual(fileName, startSecond, endSecond, rate)
path_data = 'C:\Users\he\My Research\2015.1\20150311-prb';
fileName='balltest_1';

path_data = 'C:\Users\he\My Research\2015.1\20150310-arc';
fileName='balltest10';

startSecond = 202;
endSecond = 208;


cd(path_data);
sampleRate = 256;

[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
startIndex = round(startSecond*sampleRate);
endIndex = round(endSecond*sampleRate);
if startIndex<=0 startIndex = 1; end
if endIndex>length(I) endIndex = length(I); end
I = I(startIndex : endIndex);
Q = Q(startIndex : endIndex);

Data_manual = zeros(1,2*length(I));
Data_manual(1:2:length(Data_manual)-1) = I;
Data_manual(2:2:length(Data_manual)) = Q;
% WriteBin([fileName,'_manual.data'],Data_manual);
% WriteBin(['bk\',fileName,'_bk.data'],Data_manual);

% %  need manual delete of the old file!!!!!!