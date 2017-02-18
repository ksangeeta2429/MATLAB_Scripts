% GenerateCombinations_arff.m
% Michael McGrath <mcgrath.57@osu.edu> 2015-10-21

SetEnvironment
SetPath

%% start with full lists of file names (strings)
path_arff = [ g_str_pathbase_radar '\IIITDemo\Arff' ];
path_arff_out = path_arff; %TODO: add mkdir code if does not exist.
fname_base = 'radar';
prefix = { ...
    [ path_arff '\Roy\radar1' ], ...
    [ path_arff '\royd\radar2' ], ...
    [ path_arff '\royd\radar3' ], ...
    [ path_arff '\researcher\radar4' ], ...
    [ path_arff '\researcher\radar5' ] ...
    };

midfix = { ...
    '', ...
    '_scaled' ...
    };

postfix = { ...
    '', ...
    '_r', ...
    '_nr' ...
    };

ext = { '.arff' };

[ idx_midfix idx_postfix ] = ndgrid( 1:numel(midfix), 1:numel(postfix) );
groups = [ midfix(idx_midfix(:))' postfix(idx_postfix(:))' ];

for itr = 1:length(groups(:,1))
    group_list = strcat( prefix, cell2mat(groups(itr,:)), ext );
    all_members = 1:length(prefix);

    [combos,holds,idx_combos,idx_holds] = GenerateCombinations(group_list,3,all_members);

    for j = 1:length(combos(:,1))
        str_contents = '';
        for k=1:length(idx_combos(1,:))
            str_contents = [str_contents '_' int2str(idx_combos(j,k))];
        end
        
        str_unique_id = strcat( fname_base, 'COMBO2', cell2mat(groups(itr,:)), str_contents );
        
        fname_out = [ path_arff_out '\' str_unique_id ext ];

        Combine_arff( combos(j,:), cell2mat(fname_out), str_unique_id );
    end

    %TODO: copy holdouts file to disk so we can programmatically know to load it
    %into weka for testing after the combined file is used for training?
end

