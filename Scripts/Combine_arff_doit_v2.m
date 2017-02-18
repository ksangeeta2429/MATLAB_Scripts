% Combine_arff_doit_v2.m
% EXAMPLE OF CALLING Combine_arff
% 2015-10-23: script combines plain, scaled, scaled_r, scaled_nr from
% folder 'Arff/temp-all' and saves in folder 'Arff/combined'

% ARFF files may be combined...
% If you are combining instances with the same header, copy the data but not the header
% to join the same data with different headers, use weka to join the data.

%TODO: move the user folder prepend and non-scaled\scaled logic into a
%different script and make this a function that accepts a path, and a
%regular expression for the arff file name, or a list of arff files to
%combine.

SetEnvironment
SetPath

path_arff = strcat( g_str_pathbase_radar, '/IIITDemo/Arff/' );

file_out_arff = '';
%file_out_arff_scaled = '';

%% get folder names corresponding to user names.
struct_folders = dir( path_arff );
isub = [struct_folders(:).isdir]; %# returns logical vector
folders = {struct_folders(isub).name}';
folders(ismember(folders,{'.','..'})) = [];

% at this point, folders = ['Roy','researcher','royd'];

%%OVERRIDE INPUT 2015-10-23
folders = {'temp-all'};

%% get a list of arff files. separate radar1_scaled.arff and radar1.arff
files_arff_all = '';
filenames_arff_all = '';
%files_arff_scaled_all = '';
%files_arff_scaled_r_all = '';
%files_arff_scaled_nr_all = '';
for folder = folders'
    struct_files = dir( strcat( path_arff, char(folder'), '/*.arff' ) );
    files_arff = {struct_files(:,:).name}';
    
    %struct_files_arff_scaled = dir( strcat( path_arff, char(folder'), '\*_scaled.arff' ) );
    %files_arff_scaled = {struct_files_arff_scaled(:).name}';
    
    %struct_files_arff_scaled_r = dir( strcat( path_arff, char(folder'), '\*_scaled_r.arff' ) );
    %files_arff_scaled_r = {struct_files_arff_scaled_r(:).name}';
    
    %struct_files_arff_scaled_nr = dir( strcat( path_arff, char(folder'), '\*_scaled_nr.arff' ) );
    %files_arff_scaled_nr = {struct_files_arff_scaled_nr(:).name}';
    
    %files_arff(ismember(files_arff,files_arff_scaled   )) = [];
    %files_arff(ismember(files_arff,files_arff_scaled_r )) = [];
    %files_arff(ismember(files_arff,files_arff_scaled_nr)) = [];
    
    files_arff_all           = [ files_arff_all ;           strcat(path_arff, char(folder'), '/', files_arff ) ];
    filenames_arff_all           = [ filenames_arff_all ; files_arff ];
    %files_arff_scaled_all    = [ files_arff_scaled_all ;    strcat(path_arff, char(folder'), '\', files_arff_scaled ) ];
    %files_arff_scaled_r_all  = [ files_arff_scaled_r_all ;  strcat(path_arff, char(folder'), '\', files_arff_scaled_r ) ];
    %files_arff_scaled_nr_all = [ files_arff_scaled_nr_all ; strcat(path_arff, char(folder'), '\', files_arff_scaled_nr ) ];
end

clear struct_files_arff        files_arff
%clear struct_files_arff_scaled files_arff_scaled
%clear struct_files_arff_scaled_r files_arff_scaled_r
%clear struct_files_arff_scaled_nr files_arff_scaled_nr



%TODO bail on no files.

%% concat arff files.
% get output name
% [~, fname_base, ~] = fileparts( char( files_arff_all(1) ) );
% fname_base = strsplit(fname_base,'[0-9]','DelimiterType','RegularExpression');
% fname_base = char(fname_base(1));
% file_out_arff            = strcat( g_str_pathbase_radar, '/IIITDemo/Arff/combined/', fname_base, 'ALL.arff' );
% %file_out_scaled_arff     = strcat( g_str_pathbase_radar, '\IIITDemo\Arff\combined\', fname_base, 'ALL_scaled.arff' );
% %file_out_scaled_r_arff   = strcat( g_str_pathbase_radar, '\IIITDemo\Arff\combined\', fname_base, 'ALL_scaled_r.arff' );
% %file_out_scaled_nr_arff = strcat( g_str_pathbase_radar, '\IIITDemo\Arff\combined\', fname_base, 'ALL_scaled_nr.arff' );

file_envs = [];
for f=1:length(filenames_arff_all)
    filename = char(filenames_arff_all{f});
    [strt, en] = regexp(filename,'[1-9][0-9]*');
    file_envs = [file_envs str2num(filename(strt:en))];
end

envstring = sprintf('_%.0f',sort(file_envs));
envstring = strcat('e',envstring);

[~, fname_base_arr, ~] = fileparts( char( files_arff_all(1) ) );
fname_base_arr = strsplit(fname_base_arr,'[0-9]','DelimiterType','RegularExpression');
fname_base = char(fname_base_arr(1));

file_out_name = strcat( fname_base, 'ALL',char(fname_base_arr(2)), '_', envstring);
file_out_arff            = strcat( g_str_pathbase_radar, '/IIITDemo/Arff/combined/', file_out_name, '.arff' );

Combine_arff( files_arff_all,           file_out_arff,           file_out_name );
%Combine_arff( files_arff_scaled_all,    file_out_scaled_arff,    strcat( fname_base, 'ALL' ) );
%Combine_arff( files_arff_scaled_r_all,  file_out_scaled_r_arff,  strcat( fname_base, '_r_ALL' ) );
%Combine_arff( files_arff_scaled_nr_all, file_out_scaled_nr_arff, strcat( fname_base, '_nr_ALL' ) );
delete(strcat( path_arff, folders{1}, '/*.arff'));
