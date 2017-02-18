function bbs2data(fileName,path_data)


% path_data = 'C:\Users\he\Documents\Dropbox\ADAPT Data Collection\Ice Camp\14-12-11 (3 Hz spikes)';
% fileName='9c03 (indoors, redo)';

cd(path_data);
data = ReadBin([fileName,'.bbs']);
[I,Q,N]=Data2IQ(data);
I=I(1:156:N);
Q=Q(1:156:N);
data_new(1:2:2*length(I))=I;
data_new(2:2:2*length(I))=Q;

WriteBin([fileName,'.data'],data_new);

Visualize(fileName, path_data);