%% Generate_Env_Combinations.m
function combos=Generate_Env_Combinations(numEnvs, k)

sorted_union_vector = (1:numEnvs)';
combos_all = combnk(sorted_union_vector,k);
%Does not work for k=1. TODO: Fix!!!
combos = {};
count = 1;
for j=1:size(combos_all,1)
    cur_row = combos_all(j,:);
    combos{count} = num2str(sprintf('%d_',cur_row));
    combos{count} = cellstr(combos{count}(1:end-1));
    count = count+1;
end