function classInFilename=ExtractClassLabelFromFileName(fileName)
	tmp=find(fileName=='_');
	tmp1=find(fileName=='p');
    tmp1 = tmp1(numel(tmp1));
	%tmp2=tmp(length(tmp))+1;
	tmp2 = 0;
	for i = tmp
		if(i == tmp1-2 || i == tmp1-3)
			tmp2 = i;
		end
	end
	tmp2;
	%tmp2=tmp(3)+1
	for i = 1:length(tmp)
		if(tmp(i) == tmp2)
			tmp3 = tmp(i-1);
		end
	end
	tmp3;
	classInFilename = fileName(tmp3+1:tmp2-1);
end