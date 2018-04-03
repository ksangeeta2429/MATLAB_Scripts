function FilesAintersectionB=FilesIntersection(FilesA,FilesB) % Subtract files in FilesB from FilesA

index=ones(1,length(FilesA));
for i=1:length(FilesA)
    for j=1:length(FilesB)
        if strcmpi(FilesB{j},FilesA{i})
            index(i)=0;
        end
    end
end
FilesAintersectionB={FilesA{find(index==0)}};