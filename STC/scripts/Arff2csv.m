function Arff2csv(fileNumTrain,fileNumTest)

% fileNumTrain=50;
% fileNumTest=50;
line='';
inId=fopen(sprintf('radar%d_%d.arff',fileNumTrain,fileNumTest),'r');
outId=fopen(sprintf('radar%d_%d.csv',fileNumTrain,fileNumTest),'w');

while ~strcmpi(line,'@DATA')
    line=fgetl(inId);
end

while ~feof(inId)
    line=fgetl(inId);
    fprintf(outId,line); 
    fprintf(outId,'\n');
end

fclose('all');