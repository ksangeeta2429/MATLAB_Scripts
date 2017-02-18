% GenerateCombinations_example.m
% example of how to call GenerateCombinations.
% 1) define a list of all of the relevant input files.  you will probably have to do
% make the list by hand or put all relevant files in a folder and use the
% dir command in MATLAB to build the list, but copy/paste the list in here
% because the third parameter will be indices into the list so it should be
% hard-coded to avoid different sorting orders from automated generation.
% 2) decide how many hold-outs you want in the different combinations.
% this is the second parameter.  increasing beyond '1' will increase the
% amount of combinations...
% 3) you may either pass a variable argument list, or just pass in an
% array, of the items from the full list that you want included; 
% GenerateCombinations will ignore indices not listed in the third parameter.
% create different arrays that correspond to different groups and make
% multiple calls to GenerateCombinations using each group array once.
% Michael McGrath <mcgrath.57@osu.edu> 2015-10-21

% start with full list of file names (strings)
full_list = {'a','bb','ccc','dddd','e','ff'};

% call GenerateCombinations(full_list, 1, varargin ) ...
% where varargin are the indices in full_list that you want to take
% combinations of size length(full_list - **second_parameter**); 
% if you want to hold out more files, increase second parameter.
% return values are cell arrays containing the strings.
[combined,holdouts,~,~] = GenerateCombinations(full_list,1,1,2,3,6)

% here is another example of making the same call as above, but using an
% array for the third parameter.
param_array = [1,2,3,6];
[combined2,holdouts2,~,~] = GenerateCombinations(full_list,1,param_array)