%function SaveRealData(dataSaved,saveIndex,fileName)
fileName='dog_back_straight1'
firstSecond=5;  
lastSecond=0;   % delete last several second

firstIndex=1+300*firstSecond;
lastIndex=saveIndex-300*lastSecond;
tmp=lastIndex-firstIndex;
sprintf('%dm%ds',floor(tmp/(60*300)),mod(floor(tmp/300),60))

if exist(sprintf('../data files/%s.data', fileName))==0

    OutId = fopen(sprintf('../data files/%s.data', fileName), 'w');
    fwrite(OutId, dataSaved(:,firstIndex:lastIndex), 'int16');  % write a matrix in column order
    fclose(OutId);
    'Writen!'
else 'Exist!'
end

