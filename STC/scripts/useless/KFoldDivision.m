% input: set of filenames
% output: index devision e.g.{{1, 5, 3},{2, 6},{4, 7},{8}} % k subsets (divisions)


%Files=ChooseFile(9);
function indexDivision=KFoldDivision(Files,fold)
% get total num of frames in the set
[totalNumFramesInSet,nFramesInEachFile] = GetNumFramesInFiles(Files,30);
k=fold; % k-fold cross validation
% get the expected num of frames in each fold
nFramesSubset_shouldbe=totalNumFramesInSet/k; % we let size can be not integer

% % % % initialize FilesSubset
% % % FilesSubset={};
% % % for i=1:k
% % %     FilesSubset={FilesSubset{:},{}};
% % % end
% % % % now FileSubset should be like: {{}{}{}{}{}{}{}{}{}{}}

nFiles=length(Files);
%rand('twister',0);
indexPerm = randperm(nFiles); %Shuffle the file indexes


% convert the file indexes to frame indexes
% e.g. file 1 2 3 4 have 3 2 4 3 frames,
% then file1-> frame1-3
%      file2-> frame4-5
%      file3-> frame6-9
%      file4-> frame10-12
nFramesInEachFile_cum=cumsum(nFramesInEachFile);  %cumulatate it!

indexDivision = cell(1,k);
for i=1:k
    indexDivision{i}=[];
end

j=1; % j will traverse from 1 to k - index of the subset
nFramesSubset=zeros(1,k); % record the num of frames in the k subsets
for i=1:nFiles
    % add  the indexes (of frame) in this file into the division
    if indexPerm(i)~=1
        indexesToAdd=nFramesInEachFile_cum(indexPerm(i)-1)+1:nFramesInEachFile_cum(indexPerm(i));
    else
        indexesToAdd=1:nFramesInEachFile_cum(indexPerm(i));
    end
    indexDivision{j}=[indexDivision{j},indexesToAdd];
    % add the num of frame in this file into the num of frame in this subset
    nFramesSubset(j)=nFramesSubset(j)+nFramesInEachFile(indexPerm(i));
    
% % %     % pick a file randomly
% % %     fileIndex=randi(nFiles+1-i); % get a random index in the left files
% % %     fileName=Files{fileIndex}; % get a file of this index
% % %     nFramesInThisFile=nFramesInEachFile(fileIndex); % get how many frames are in this file
% % %     
% % %     % put the file into the subset
% % %     currSubset=FilesSubset{j};
% % %     currSubset={currSubset{:},fileName};
% % %     FilesSubset{j}=currSubset;
% % %     % delete this file from Files (total set)
% % %     Files(fileIndex)=[];
% % %     nFramesInEachFile(fileIndex)=[]; % need update
    
    
    
    
    % test if the subset is full
    % if current num of frames in subset exceed a limit
    if nFramesSubset(j)>nFramesSubset_shouldbe*0.95 && j~=k
        j=j+1;
    end
    
%     if j==k
%         % left files are put into the k-th(last) subset
%         %FilesSubset{j}=Files;
%         %nFramesSubset(j)=GetNumFramesInFiles(FilesSubset{j},30);
%         
%         
%         break;
%     end
end

