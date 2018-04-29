clc
clear all

% Params (in #samples)
inputdir = 'noisecattle'; % 'Noise_Data';
samprate = 256;
stride = 256*1.5;
winlen = 256*2.5;

cd(inputdir);
outdir = [inputdir,'_winlen=',num2str(winlen/samprate),'s_stride=',num2str(stride/samprate),'s'];
if exist(outdir, 'dir') ~= 7
    mkdir(outdir);
end

% Hackey hack - node_north_south.bbs
% list_files = dir('node_north_south.bbs');
% noise_start_seconds = [200 480 650];
% noise_end_seconds = [400 580 750];

% Hackey hack - n_node_X.bbs
% list_files = dir('n_node_X.bbs');
% noise_start_seconds = [50 650 1000 1600];
% noise_end_seconds = [500 950 1200 1700];

% Hackey hack - node_east_west.bbs
% list_files = dir('node_east_west.bbs');
% noise_start_seconds = [10 250 530];
% noise_end_seconds = [200 500 680];

% Hackey hack - r46-2trees-3m.data
% list_files = dir('r46-2trees-3m.data');
% noise_start_seconds = [10];
% noise_end_seconds = [1200];

% Hackey hack - r46-2trees-3m.data
% list_files = dir('Coffman-tree-2m.data');
% noise_start_seconds = [10];
% noise_end_seconds = [1800];

% Hackey hack - r46-garage.data
% list_files = dir('r46-garage.data');
% noise_start_seconds = [10];
% noise_end_seconds = [2100];

% Hackey hack - wednesday_noise.bbs
% list_files = dir('wednesday_noise.bbs');
% noise_start_seconds = [50 500];
% noise_end_seconds = [350 900];

% Hackey hack - osu_farm_meadow_may24_1.bbs
list_files = dir('osu_farm_meadow_may24_1.bbs');
noise_start_seconds = [43200 86400 196800];
noise_end_seconds = [55200 91800 207800];

tot_length=0;
for l = 1:numel(list_files)
    cur_file = list_files(l).name;
    [~,cur_file_name,~] = fileparts(cur_file);
    Comp=ReadRadar(cur_file);
    
    Compnoise = [];
    % Cut out noise "parts" from file
    for n = 1:length(noise_end_seconds)
        Compnoise = [Compnoise; Comp(noise_start_seconds(n)*samprate:noise_end_seconds(n)*samprate)];
    end
    
    L = length(Compnoise);
        
    cut_index=1;
    for k1 = 1:stride:L-winlen+1
        % datawin(cut_index,:) = Compnoise(k1:k1+winlen-1);
        temp = Compnoise(k1:k1+winlen-1)';
        % Flatten as Re1 Img1 Re2 Img2....
        tempmat = [real(temp); -1*imag(temp)]; % -1 to correct Hermitian conjugate
        datawin(cut_index,:) = tempmat(:)';
        cut_index = cut_index + 1;
    end

    outfile = fullfile(outdir,[cur_file_name,'.csv']);
    csvwrite(outfile, datawin);
    
%     outsubdir = fullfile(outdir, cur_file_name);
%     if exist(outsubdir, 'dir') ~= 7
%         mkdir(outsubdir);
%     end
%     outfile_real = fullfile(outsubdir,[cur_file_name,'_real.csv']);
%     outfile_imag = fullfile(outsubdir,[cur_file_name,'_imag.csv']);
%     csvwrite(outfile_real, real(datawin));
%     csvwrite(outfile_imag, imag(datawin));
    
    tot_length = tot_length + size(datawin,1);
    clear datawin
end