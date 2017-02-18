function Combine_arff(files_arff_all, file_out_arff, str_relation, desired_attributes)
% Combine_arff.m combine ARFF files 
% @param files_arff_all cell-array of string file name
% @param file_out_arff filename to save combined file
% @param str_relation name for the '@relation' attribute at the top of the combined file
% USAGE: remember to change the {Human,Dog} if... statement and string.  I
% hard-coded that because some input ARFF files only contained one of the two
% categories.
% Michael McGrath <mcgrath.57@osu.edu>
% created 2015-10-20


%% write output header relation
FID_out_arff = fopen( file_out_arff, 'w' );
fprintf( FID_out_arff, [ '@relation ', str_relation, '\n\n' ] );

fprintf( FID_out_arff, [ '%% created ', datestr(datetime), ' by ', getenv('USERNAME'), '\n' ] );
fprintf( FID_out_arff, '%% contains %d files:\n', length(files_arff_all));
fnames = {};
for itr = 1:length(files_arff_all)
    [~, fname, ~] = fileparts( char( files_arff_all(itr) ) );
    fnames = [fnames ; fname];
end
fnames = sort(fnames);
for itr = 1:length(fnames)
    fprintf( FID_out_arff, [ '%% ', char(fnames(itr)), '\n' ] );
end
fprintf( FID_out_arff, '\n' );

%% get and write header attributes from first file.
attribute_count = 0;
FID_header = fopen(char(files_arff_all(1)),'r');
if FID_header < 0
    fprintf('ERROR! %s could not open file %s\n', mfilename, cell2mat(files_arff_all(1)));
    fclose(FID_out_arff);
    %TODO: delete FID_out_arff from disk?s
    return;
end
tline = fgets(FID_header);
while ischar(tline)
    if strfind(tline,'@attribute') == 1
        % TODO: check if attribute is a member of desired_attributes
        if ~isempty(strfind(tline, 'Human') == 1) || ~isempty(strfind(tline, 'Dog') == 1 )
            idx = strfind(tline,'{');
            tline = [tline(1:idx) 'Human,Dog}\n'];
            fprintf( FID_out_arff, tline );
        else
            fprintf( FID_out_arff, tline );
        end
        attribute_count = attribute_count + 1;
    end
    if strfind(tline,'@data') == 1
        break;
    end
    tline = fgets(FID_header);
end
fclose(FID_header);

%% copy data section from all files
fprintf( FID_out_arff, '\n@data\n' );
for itr = 1:length(files_arff_all)
    % find data section
    file = char( files_arff_all(itr) );
    FID_file = fopen(file,'r');
    tline = fgets(FID_file);
    check_attribute_count = 0;
    while ischar(tline)
        if strfind(tline, '@attribute') == 1
            check_attribute_count = check_attribute_count + 1;
            if check_attribute_count > attribute_count
                fprintf('ERROR! file %s has more attributes than expected %d attributes!\n',file, attribute_count);
                break;
            end
        end
        if strfind(tline, '@data') == 1
            break;
        end
        tline = fgets(FID_file);
    end
    
    % copy data section
    [~, fname, ~] = fileparts(file);
    fprintf( FID_out_arff, [ '\n%% ', fname, '  ', strrep( file, '\', '\\'), '\n' ] );
    tline = fgets(FID_file);
    while ischar(tline)
        if strfind(tline, '@') == 1
            fprintf('ERROR! found attribute line after data segment.\n');
            break;
        end
        tline = strrep( tline, '\', '\\');
        %% todo: trim attributes at positions in CSV list
        fprintf(FID_out_arff, tline);
        tline = fgets(FID_file);
    end
    
    fprintf(FID_file,'\n\n\n');
    fclose(FID_file);
end
fclose( FID_out_arff );