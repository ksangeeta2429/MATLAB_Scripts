function numInFilename=ExtractNumFromFileName(fileName)

tmp=find(fileName=='_');
tmp1=find(fileName=='p');
tmp2=tmp(length(tmp))+1;
%tmp2=tmp(4)+1;
tmp3=tmp1(1)-1;
numInFilename=str2num(fileName(tmp2:tmp3));