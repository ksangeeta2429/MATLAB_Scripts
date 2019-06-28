function train = getPhaseData(fileName, path_dir)

addpath('/scratch/sk7898/MATLAB_Scripts/Scripts')
cd(path_dir);
[I,Q,~]=Data2IQ(ReadBin([fileName,'.data']));

%dcI = 2044;   % enable when do test on dummy data
				  %dcQ = 2048;
dcI = median(I); %median or mean
dcQ = median(Q);
Data = (I-dcI) + 1i*(Q-dcQ);

L = size(Data);
window = 250;
stride = round(window/4);
train = [];
%num_subwindows = floor(((L-window)/stride)+1);

for k1 = 1:stride:L(1)-window+1
	   row = angle(Data(k1:k1+window-1)); 
train = vertcat(train, row.');
end
