function instances_filtered=AttributeSelectionManual_Instances(inFileOrInstance, features_csv)
%% SetEnvironment and SetPath must have been run first
if not(isempty(strfind(inFileOrInstance,'.arff'))) %If input is a filename, load ARFF
    instances = loadARFF(inFileOrInstance);
else % Input is Instances
    instances = inFileOrInstance;
end

eval(['temp = {' features_csv '};']);
inputList = cell2mat(temp); %Adjusting for Java indices

if min(inputList)<1 || max(inputList)>instances.numAttributes()-1 % Can't delete the class attribute
    error('Invalid attribute index/indices. Please enter indices between 1 and %d',instances.numAttributes()-1);
end

% Compute list of attributes to be deleted
fullAttributeList = 1:instances.numAttributes()-1;
deletionList = setdiff(fullAttributeList,inputList);
deletionString = sprintf('%.0f,' , deletionList); 
deletionString = deletionString(1:end-1);

%% Remove unwanted attributes
remove = weka.filters.unsupervised.attribute.Remove();
remove.setAttributeIndices(deletionString);
remove.setInputFormat(instances);
instances_filtered = weka.filters.Filter.useFilter(instances, remove);