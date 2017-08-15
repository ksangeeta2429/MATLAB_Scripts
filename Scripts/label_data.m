%{
    This script can be used to label data in the arff file. 
    Input file is the file which has labels in each line corresponding to
    each data sample in arff file. The input file cannot have an empty line
    (new line). Every line should have a label.
    The labels at the end of each line in arff file will be replaced using
    the labels from the input file.
%}


function label_data(input_file, arff_file, arff_output)

input_labels = []; %store the labels in an array
all_labels = ['Human','Bike','Dog']; %use for comparision
fd = fopen(input_file, 'r'); 
while(~feof(fd))
       line = string(fgetl(fd));
       if(line == '')
           fprintf('Error : Found an empty line in input file. Every line should have a label.\n');
           return;
       end
       %disp(line);
       input_labels = [input_labels line];
end
fclose(fd);
%fprintf('\n\n');
disp(input_labels);

A = regexp( fileread(arff_file), '\n', 'split');
%disp(A(1));

if(length(input_labels) >= length(A))
    fprintf('Error : Number of labels in input file too many\n');
    return;
end
j = 1; %index for inputlabel
for i = 1:length(A)
    fprintf('%d\n',contains(string(A(i)),',Dog'));
    if(contains(string(A(i)),',Dog'))
        if(j > length(input_labels))
            fprintf('Error : Number of input labels less than required\n');
            return;
        end
        newStr = strrep(string(A(i)),'Dog',string(input_labels(j)));
        newStr = {newStr};
        A(i) = newStr;
        j = j + 1;        
    end    
end

%write the modified file to the output file
fd1 = fopen(arff_output,'w');
for i = 1:length(A)
    fprintf(fd1,'%s\n',string(A(i)));
    %fprintf('\n');
end
fclose(fd1);