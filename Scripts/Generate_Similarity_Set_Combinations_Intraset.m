%% Generate_Similarity_Set_Combinations_Intraset.m
function interset_combos=Generate_Similarity_Set_Combinations_Intraset(k)
%% Similarity sets-please enumerate before running program. Must be disjoint.

similarity_set{1} = [1 2 3 10]; % ?Human-ball indoors
similarity_set{2} = [4 6]; % ?Human-car, parking lot
similarity_set{3} = [5 7]; % ?Human-dog, parking lot
similarity_set{4} = [8 9]; % ?Human-dog, park trail

%% Find all combinations

interset_list = [];
for i=1:length(similarity_set)
    interset_list = [interset_list; combnk(similarity_set{i},k)];
end

interset_list = sortrows(interset_list);

interset_combos = {};
for i=1:length(interset_list)
    interset_combos{i} = num2str(sprintf('%d_',interset_list(i)));
    interset_combos{i} = cellstr(interset_combos{i}(1:end-1));
end

