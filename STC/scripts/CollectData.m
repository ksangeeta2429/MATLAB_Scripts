% function CollectData(time)

fileName='tmp1';
time=100;

fprintf(1,'create a txt file!!!\n');
pause(10);
DataControl(1,1);pause(time);DataControl(1,2);
fprintf(1,'Stopped\n');
pause(10);DataControl(1,3);pause(time/3+5);


if exist(strcat(fileName,'.txt'))==0
    movefile(sprintf('C:\\cygwin\\home\\he\\%s.txt',fileName));
    fprintf(1,'%s Moved\n',fileName);
    
    DataControl(1,0);
    pause(3);
    STCParse(fileName);
else
    fileNameInit=fileName;
    fprintf(1,'Already exist, name changed!\n');

    while(exist(strcat(fileName,'.txt'))~=0)
        l=length(fileName);
        fileNameWithoutLastChar=fileName(1:l-1);
        fileNameLastChar=fileName(l);
        indexFile=str2num(fileNameLastChar);
        indexFile=indexFile+1;
        fileName=strcat(fileNameWithoutLastChar,num2str(indexFile));
    end
    
    movefile(sprintf('C:\\cygwin\\home\\he\\%s.txt',fileNameInit),sprintf('C:\\cygwin\\home\\he\\%s.txt',fileName));
    movefile(sprintf('C:\\cygwin\\home\\he\\%s.txt',fileName));
    fprintf(1,'%s Moved to %s\n',fileNameInit,fileName);
end

