%% Generate_Similarity_Set_Combinations_Exclusion.m
function interset_combos=Generate_Similarity_Set_Combinations_Exclusion(k)
%% Similarity sets-please enumerate before running program. Must be disjoint.

similarity_set{1} = [1 2 3 10]; % ?Human-ball indoors
similarity_set{2} = [4 6]; % ?Human-car, parking lot
similarity_set{3} = [5 7]; % ?Human-dog, parking lot
similarity_set{4} = [8 9]; % ?Human-dog, park trail

%% Find sorted union of elements

sorted_union_vector=[];
for i=1:length(similarity_set)
    sorted_union_vector = union(sorted_union_vector,similarity_set{i});
end
sorted_union_vector = sorted_union_vector';

%% Find all combinations

combos_all = combnk(sorted_union_vector,k);

count = 1;
interset_combos = {};
for j=1:size(combos_all,1)
    cur_row = combos_all(j,:);
    cur_row_sets = zeros(1,length(cur_row));
    for p=1:length(cur_row)
        for l=1:length(similarity_set)
            if not(isempty(find(similarity_set{l}==cur_row(p))))
                cur_row_sets(p) = l;
                break;
            end
        end
    end
    
    if k <= length(similarity_set)
        if length(cur_row)~=length(unique(cur_row_sets))
            continue;
        end
    elseif k < length(sorted_union_vector)-1
        if ((not(isempty(find(cur_row==1)))) && (not(isempty(find(cur_row==2))))) || ((not(isempty(find(cur_row==1)))) && (not(isempty(find(cur_row==3))))) || ((not(isempty(find(cur_row==2)))) && (not(isempty(find(cur_row==3)))))
            continue;
        end
    elseif k==length(sorted_union_vector)-1
        if ((not(isempty(find(cur_row==1)))) && (not(isempty(find(cur_row==2)))))
            continue;
        end
    end
    
    % interset_combos{count} = num2str(sprintf('%d_',cur_row)) %--Uncomment line to preview interset_combos
    interset_combos{count} = num2str(sprintf('%d_',cur_row));
    interset_combos{count} = cellstr(interset_combos{count}(1:end-1));
    count = count+1;
end