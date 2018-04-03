function FilesAplusB=FilesAdd(FilesA,FilesB)   % Add files in FilesB into FilesA

for j=1:length(FilesB)
    same=0;
    for i=1:length(FilesA)
        if strcmpi(FilesB{j},FilesA{i})
            same=1;            
        end
    end
    if same==0
        FilesA={FilesA{:},FilesB{j}};
    end
end
FilesAplusB={FilesA{:}};

