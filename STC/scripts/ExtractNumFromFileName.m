function numInFilename=ExtractNumFromFileName(fileName)

tmp=find(fileName=='_');
tmp1=find(fileName=='p');
tmp1 = tmp1(numel(tmp1));
tmp2 = 0;
for i = tmp
	if(i == tmp1-2 || i == tmp1-3)
		tmp2 = i;
	end
end
%tmp2=tmp(length(tmp))+1
%tmp2=tmp(4)+1;
tmp2;
tmp3=tmp1(1)-1;
%tmp3 = tmp1-1
numInFilename=str2num(fileName(tmp2+1:tmp3));