function classInFilename=ExtractClassLabelFromFileName(fileName)
	tmp=find(fileName=='_');
	%tmp1=find(fileName=='p');
	%tmp2=tmp(length(tmp))+1;
	tmp2=tmp(3)+1;
	tmp3=tmp(4)-1;
	classInFilename = fileName(tmp2:tmp3);
end