%% Generate_Env_Combinations.m
function combos=Generate_Env_Combinations(envs, k)

% if k==1 %Fix for for k=1
%     sorted_union_vector = (1:numEnvs);
% else
%     sorted_union_vector = (1:numEnvs)';
% end

if length(envs)==1 % If input is a the number of environments, enumerate the environments
    sorted_union_vector = (1:envs);
else
    sorted_union_vector = sort(envs);
end

combos_all = combnk(sorted_union_vector,k);

combos = {};
count = 1;
for j=1:size(combos_all,1)
    cur_row = combos_all(j,:);
    combos{count} = num2str(sprintf('%d_',cur_row));
    combos{count} = cellstr(combos{count}(1:end-1));
    count = count+1;
end