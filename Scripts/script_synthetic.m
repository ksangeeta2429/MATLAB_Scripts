% script_synthetic

SetEnvironment
SetPath

if ismac
    home_dir = '/Users/mcgrathm';
else
    home_dir = '/home/mcgrathm';
end

%data_path = [ home_dir filesep '20180505/walking/bbs' ];

%data_path = [ home_dir filesep '20180505/walking_250hz/rank5/bbs' ];
data_path = [ home_dir filesep '20180730/walking_250hz/rank248/bbs' ];
out_path = [ data_path filesep '..' filesep 'cut_4s' ];

%TODO: determine if cut folder exists.

% DEBUG INDIVIDUAL CUT:
% fileName = '20180220T142821_cmu_05_01_makeiq_5d8f92e4_b3cc_43a3_a998_e8ac14c25843';
% filePath = '/Users/mcgrathm/20180505/walking';
% dir_out = '/Users/mcgrathm/20180505/walking';
% [ncut, idx_start, idx_stop] = CutFile(fileName, filePath, dir_out);

sampleRate = 250;
%[ Files, allstarts, allstops ] = CutFilesInFolder( data_path, data_path, sampleRate );

secs = 4;
cutLength = round(sampleRate*secs);
offset = 0;
[ ncut, allstarts, allstops, files ] = CutFilesInFolder( data_path, out_path, sampleRate, 'CutFileKeepAll', cutLength, offset );