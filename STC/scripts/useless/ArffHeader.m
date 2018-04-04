function ArffHeader(OutIndex, instances, Files, Indexes, numOfFeatures, numOfClasses, RC)

% OutIndex = 15;
% instances = 3;
% numOfClasses = 5;

OutputFile=sprintf('radar%d.arff',OutIndex);
OutID=fopen(OutputFile,'w');
fprintf(OutID,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n');
fprintf(OutID,'%% ');
fprintf(OutID,'%% Data Sets:\n');
for i=1:instances
    fprintf(OutID,'%% ');
    fprintf(OutID,sprintf('%d %s\n',Indexes(i), Files{i}));
end
fprintf(OutID,sprintf('@RELATION radar%d \n\n',OutIndex));

for i=1:numOfFeatures
    fprintf(OutID,sprintf('@ATTRIBUTE f%d        NUMERIC \n',i));
end

if RC==1
    fprintf(OutID,'@ATTRIBUTE classIndex    NUMERIC \n');

else    %RC==0
    fprintf(OutID,'@ATTRIBUTE classIndex {');
    for i=1:numOfClasses-1
        fprintf(OutID,'%d, ',i);
    end
    fprintf(OutID,'%d} \n',numOfClasses);
end

fprintf(OutID,'@DATA \n');

fclose('all');