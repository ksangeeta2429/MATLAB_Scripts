% input: set of filenames, expected num of frames
% output: subset of filenames

function FilesSubset=GetSubsetWithGivenNumOfFrames(Files, nFrames_expect)
% get total num of frames in the set
[totalNumFramesInSet,nFramesInEachFile] = GetNumFramesInFiles(Files,30);

if nFrames_expect>=totalNumFramesInSet % expected num of frames too large!
    display('nFrames_expect too large!');
end

nFiles=length(Files);

FilesSubset={};
nFramesSubset=0;
for i=1:nFiles
    % pick a file randomly
    fileIndex=randi(nFiles+1-i); % get a random index in the left files
    fileName=Files{fileIndex}; % get a file of this index
    nFramesInThisFile=nFramesInEachFile(fileIndex); % get how many frames are in this file

    % put the file into the subset
    FilesSubset={FilesSubset{:},fileName};
    % delete this file from Files (total set)
    Files(fileIndex)=[];
    nFramesInEachFile(fileIndex)=[]; % need update
    
    % add the num of frame in this file into the num of frame in this subset
    nFramesSubset=nFramesSubset+nFramesInThisFile;
    
    % test if the subset is full
    % if current num of frames in subset exceed the given num  (argin)
    if nFramesSubset> nFrames_expect*0.95
        break;
    end
end