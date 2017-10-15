%{
    This script can be used to label data in the arff file. 
    Input file is the file which has labels in each line corresponding to
    each data sample in arff file. The input file cannot have an empty line
    (new line). Every line should have a label.
    The labels at the end of each line in arff file will be replaced using
    the labels from the input file.
    Note : While listing the labels do not list Dog at the end. Ex:
    {Human,Bike,Dog}. this will not work. There should be no comma before
    dog.
%}


function label_data(input_file, arff_file, arff_output)

input_labels = []; %store the labels in an array
all_labels = ['Human','Bike','Dog']; %use for comparision
fd = fopen(input_file, 'r'); 
while(~feof(fd))
       line = cellstr(fgetl(fd));
       %disp(line);
       if(isempty(line))
           fprintf('Error : Found an empty line in input file. Every line should have a label.\n');
           return;
       end
       %disp(line);
       input_labels = [input_labels, line];
end
fclose(fd);
%fprintf('\n\n');
%disp(input_labels);

A = regexp( fileread(arff_file), '\n', 'split');
%disp(A);

if(length(input_labels) >= length(A))
    fprintf('Error : Number of labels in input file too many\n');
    return;
end
j = 1; %index for inputlabel
for i = 1:length(A)
    a = A{i};
    index = strfind(a,',Dog');
    fprintf('%d',length(index));
    if(length(index) == 1)
        if(j > length(input_labels))
            fprintf('Error : Number of input labels less than required\n');
            return;
        end
        newStr = strrep(A(i),'Dog',char(input_labels(j)));
        disp(newStr);
        newStr = {newStr};
        A(i) = newStr;
        j = j + 1;        
    end    
end
fprintf('\n');
%write the modified file to the output file
fd1 = fopen(arff_output,'w');
for i = 1:length(A)
    fprintf(fd1,'%s\n',char(A{i}));
    %fprintf('\n');
end
fclose(fd1);