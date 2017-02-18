% FixArff.m COMBO class mistake FIXER script
% Michael McGrath, <mcgrath.57@osu.edu> 2015-10-23

SetEnvironment
SetPath


%% find all files matching 'COMBO' in their name

path_arff = strcat( g_str_pathbase_radar, '\IIITDemo\Arff\' );

struct_files_COMBO = dir( strcat( path_arff, '\*COMBO*.arff' ) );
files_COMBO_arff = {struct_files_COMBO(:,:).name}';

% in each file, find line that has the word 'class' and replace it with the
% appropriate f*

for itr=1:length(files_COMBO_arff)
    file = [path_arff char(files_COMBO_arff(itr))];
    
    FID_read = fopen(file,'r');
    if FID_read < 0
        fprintf('ERROR! not a valid file: %s\n',file);
        return;
    end
    temp_contents = [];
    itr_tline = 1;
    tline = fgetl(FID_read);
    temp_contents{itr_tline} = tline;
    while ischar(tline)
        itr_tline = itr_tline + 1;
        tline = fgetl(FID_read);
        temp_contents{itr_tline} = tline;
    end
    fclose(FID_read);
    
    FID_write = fopen(file,'w');
    
    check_attribute_count = 0;
    itr_tline = 0;
    for itr_tline = 1:numel(temp_contents)
        tline = temp_contents{itr_tline};
        if strfind(tline, '@attribute') == 1
            check_attribute_count = check_attribute_count + 1;
        end
        if ~isempty(strfind(tline, '@attribute')) == 1 && ~isempty(strfind(tline, 'class')) == 1
            str_fix = sprintf('f%d',check_attribute_count); %TODO: match f to whatever the rest of the file uses.
            tline = strrep(tline, 'class', str_fix);
        end
        fprintf(FID_write, '%s\n', tline);
    end
    fclose(FID_write);
end
