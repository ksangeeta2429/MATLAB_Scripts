function ArffHeader_simpler(OutputFile, nFeature)

% OutIndex = 15;
% instances = 3;
% numOfClasses = 5;

OutID=fopen(OutputFile,'w');
fprintf(OutID,'@RELATION radar \n\n');
for i=1:nFeature
    fprintf(OutID,sprintf('@ATTRIBUTE f%d        NUMERIC \n',i));
end
fprintf(OutID,'@ATTRIBUTE classIndex    NUMERIC \n');
fprintf(OutID,'@DATA \n');

fclose('all');