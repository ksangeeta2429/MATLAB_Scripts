clc
clear all

% Params (in #samples)
inputdir = 'bikes';
samprate = 256;
stride = 256*1;%1.5;
winlen = 256*2;%2.5;
minlength_secs = 1;

cd(inputdir);
% valid_cuts_dir = ['valid_cuts>=',num2str(minlength_secs),'s'];
% if exist(valid_cuts_dir, 'dir') ~= 7
%     mkdir(valid_cuts_dir);
% end

outdir = [inputdir,'_winlen=',num2str(winlen/samprate),'s_stride=',num2str(stride/samprate),'s'];
if exist(outdir, 'dir') ~= 7
    mkdir(outdir);
end

list_files = dir('*.data');
tot_length=0;
max_walk_secs = 0;
for l = 1:numel(list_files)
    cur_file = list_files(l).name;
    [~,cur_file_name,~] = fileparts(cur_file);
    Comp=ReadRadar(cur_file);
    
    if length(Comp)/samprate < minlength_secs
        continue
    end
    
    cur_walk_secs = length(Comp)/samprate;
    if cur_walk_secs > max_walk_secs
        max_walk_secs = cur_walk_secs;
    end
    
    %copyfile(cur_file,valid_cuts_dir);
    L = length(Comp);
    cut_index=1;
    for k1 = 1:stride:L-winlen+1
        % datawin(cut_index,:) = Comp(k1:k1+winlen-1);
        temp = Comp(k1:k1+winlen-1)';
        % Flatten as Re1 Img1 Re2 Img2....
        tempmat = [real(temp); -1*imag(temp)]; % -1 to correct Hermitian conjugate
        datawin(cut_index,:) = tempmat(:)';
        cut_index = cut_index + 1;
    end
    
    if exist('datawin','var') == 1
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
end