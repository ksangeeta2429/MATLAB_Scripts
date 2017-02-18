function [cell_str_combinations,cell_str_holdouts, idx_combinations, idx_holdouts] = GenerateCombinations(cell_array, num_holdouts, varargin)
% GenerateCombinations generate all combinations of values from cell_array(varargin)
% @param cell_array reference cell array of strings
% @param k number of elements in each output combination. Pass 0 to use length(varargin)-1
% @param varagin variable length input of indices to use from cell_array.
% OR, pass an array of indices.
% @return cell_str_combinations cell array of string combinations.
% @return cell_str_holdouts cell array of the holdouts from each combo
% @return idx_combinations array of indices used in each combo. useful for file names.
% @return idx_holdouts array of indices not used in each combo.
% Michael McGrath <mcgrath.57@osu.edu> 2015-10-21
% TODO: there is probably a much easier and more straight-forward way to do
% this than messing with cells vs. matrices; this is SQL-like operations
% but done with MATLAB arrays.
% NOTE: COMBNK uses the Statistics and Machine Learning Toolbox from MathWorks, Inc.

if nargin == 2
    fprintf('ERROR! %s needs third parameter!\n',mfilename);
    return;
end

chosen_indices = [];
if length(varargin) > 1
    if length(varargin) > length(cell_array)
        fprintf('ERROR! %s passed more input indices than inside value array\n', mfilename);
    end
    for itr=1:length(varargin)
        if varargin{itr} > length(cell_array)
            fprintf('ERROR! %s passed bad index into value array\n',mfilename);
        end
    end
else
    varargin = num2cell(cell2mat(varargin));
end

k = [];
if num_holdouts > length(varargin)
    fprintf('ERROR! %s asked to hold out %d strings but length(cell_array) == %d\n',mfilename, num_holdouts,length(cell_array)); 
    return;
elseif num_holdouts > 0
    k = length(varargin) - num_holdouts;
else
    fprintf('ERROR! expected to hold out at least 1 data set\n');
    return;
end

chosen_indices = cell2mat(varargin);


chosen_indices_combinations = combnk(chosen_indices,k);
holdout_indices_mask = num2cell(1:length(cell_array));
combinations_count = factorial(length(chosen_indices)) / (factorial(k)*factorial(length(chosen_indices)-k));
for itr=1:combinations_count
    mask_copy = holdout_indices_mask;
    mask_copy(chosen_indices_combinations(itr,:)) = {-1};
    mask_copy = mask_copy(chosen_indices);
    holdout_indices_temp = [];
    for j=1:length(mask_copy)
        if cell2mat(mask_copy(j)) ~= -1
            holdout_indices_temp( length(holdout_indices_temp) + 1 ) = cell2mat(mask_copy(j));
        end
    end
    holdout_indices(itr,:) = { holdout_indices_temp };
end
holdout_indices = cell2mat(holdout_indices);

for itr=1:combinations_count
    cell_str_combinations(itr,:) = cell_array(chosen_indices_combinations(itr,:));
    cell_str_holdouts(itr,:) = cell_array(            holdout_indices(itr,:));
end
idx_combinations = chosen_indices_combinations;
idx_holdouts = holdout_indices;
