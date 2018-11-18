function saveIQForCSharpTest(I,Q,file_path,fileName)
    strcat(file_path,fileName)
    fd = fopen(strcat(file_path,fileName),'w');
    fprintf(fd,'I : \n');
    for i = 1:length(I)
        fprintf(fd,'%d,',I(i));
    end
    fprintf(fd,'\n\nQ : \n');
    for i = 1:length(Q)
        fprintf(fd,'%d,',Q(i));
    end
    fclose(fd);
end