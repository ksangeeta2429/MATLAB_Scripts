%{
    This script selects instances from given arff file which belong to 
    specified class, creates new instances and saves them to new arff file.
    If the file already exists, it will be overwritten.
    Variable searchclass should be the name of the class of which n number of instances
    are required to be appended to another file.
%}

function ArffSelectInstances_AppendToBike(input_file, output_file,n
)
import weka.core.Instance;

SetEnvironment
SetPath

% n is the size of the subset of instances that you desire to extract
% searchclass is the desired class labels of instances that you want to
% extract
searchclass = 'Human';

%path to arff file from which you want to extract the subset of instances
%path_source_arff=('/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/IIITDemo/Arff/test/radar201408.arff');
path_source_arff = strcat(g_str_pathbase_radar,input_file);
disp(path_source_arff);
%path of arff file to which you want to write the new instances
%path_destination_arff = ('/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/IIITDemo/Arff/test/test.arff');
path_destination_arff = strcat(g_str_pathbase_radar,output_file);
%load source arff file into weka Instances
source_instances = loadARFF(path_source_arff);
source_num_of_instances = source_instances.numInstances();

new_instances = javaObject('weka.core.Instances', source_instances,n);
%disp(num_of_instances);

%Iterate through all instances and find only human instances or other instances
counter = 0; i = 0;
while(counter < n && i < source_num_of_instances)
    %get instance at index counter
    temp = source_instances.instance(i);
    i = i + 1;
    att = temp.toString();
    %disp(att);
    temp1 = strfind(att,searchclass);
    if(isempty(temp1))
        continue;
    else
        new_instances.add(temp);
        counter = counter + 1;
    end
end
if(i == source_num_of_instances && counter < n)
    %could not find n instances in the source arff
    fprintf('Found %d %s instances\n',counter,searchclass);
else
    %found n instances
    fprintf('Found %d %s instances\n',counter,searchclass);
end
saveARFF(path_destination_arff,new_instances);

end