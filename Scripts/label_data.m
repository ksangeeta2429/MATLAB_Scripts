%{
    This script can be used to label data in the arff file. 
    Input file is the file which has labels in each line corresponding to each data sample in arff file. 
    The labels at the end of each line in arff file will be replaced using
    the labels from the input file.
%}


function label_data(input_file, arff_file)

input_labels = [];
fd = fopen(input_file, 'r');
while(~feof(fd))
       line = fgetl(fd);
       %disp(line);
       input_labels = [input_labels line];
end
fclose(fd);
disp(input_labels);
fd1 = fopen(arff_file,'w+');
for i = 1:length(input_labels)
    tline = fgetl(fd1);
    offset = -(length(tline)+2); 
    tline = fgets(fd1);
    fseek(fd1,offset,'cof'); %fd1 restored to previous line
    if(input_labels(i) == 'Human')
        newStr = strrep(tline,'Dog',string(input_labels(i)));
        fprintf(fd1,'%s\n',newStr);
    end
end
fclose(fd1);
end

