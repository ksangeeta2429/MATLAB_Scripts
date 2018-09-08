%{
    Originally written by Dhrubo, modified by neel. 
    This script takes noise file (.bbs) as input and outputs each sliding
    window as a cut.
    Note : Noise file cannot contain any events. It should be noise only.
%}

clc
clear all

% Params (in #samples)
sampRate = 256
class_label = 'noise'
inputdir = 'C:/Users/neel/Downloads/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Aug 13 2018/';
fileName = 'aus_c2';
inputfile = strcat(inputdir,fileName,'_noise_only.bbs');
stride = round(sampRate*2/3)%1.5;
winlen = sampRate*1%2.5;

cd(inputdir);
% valid_cuts_dir = ['valid_cuts>=',num2str(minlength_secs),'s'];
% if exist(valid_cuts_dir, 'dir') ~= 7
%     mkdir(valid_cuts_dir);
% end

outdir = [inputdir,'/winlen_',num2str(winlen/sampRate),'_stride_',num2str(stride)];
if exist(outdir, 'dir') ~= 7
    mkdir(outdir);
end

list_files = dir('*.data');
tot_length=0;
max_walk_secs = 0;

[I,Q,N]=Data2IQ(ReadBin([inputfile]));


%copyfile(cur_file,valid_cuts_dir);
L = length(I);
cut_index=1;
for k1 = 1:stride:L-winlen+1
    %fprintf('%d to %d    ',k1,k1+winlen);
   
    temp_I = I(k1:k1+winlen-1);
    temp_Q = Q(k1:k1+winlen-1);
    Data_cut = zeros(1,2*(k1+winlen-1-k1+1));
    Data_cut(1:2:length(Data_cut)-1) = temp_I;
    Data_cut(2:2:length(Data_cut)) = temp_Q;
    %3 lines added by neel to output each sliding window as cut
    %sliding_win = zeros(1,length(temp));
    %sliding_win = temp;
    WriteBin([outdir,'/',fileName,'_',class_label,'_',num2str(k1),'_to_',num2str(k1+winlen),'.data'],Data_cut);
end