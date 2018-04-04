% test the Connected Component Labeling algorithm
% input: image (binary 01 2d matrix)
% output: number of 1 areas (4 connected)

function ConnectedComponentLabeling()
    clc; 
    
    Image = [
    1 0 0 0 0 0 0;
    0 1 0 1 0 1 0;
    0 1 1 0 0 1 1;
    0 0 1 0 1 1 0;
    0 0 0 1 1 1 0;
    0 0 0 0 0 1 1
    ];
    % Image = [
    % 1;
    % 1;
    % 1;
    % 0;
    % 1;
    % 1;
    % 0;
    % 1;
    % 0
    % ];
    Image_new = zeros(size(Image));
    maxNumLabel = size(Image,1)*size(Image,2);
    mappingLabel = zeros(1,maxNumLabel);
    for i=1:maxNumLabel
        mappingLabel(i)=i;
    end



    [M, N]=size(Image);
    nObj = 0;
    nMerge = 0;

    for j = 1:N
        currCol = Image(:,j);

        if j==1
            for i=1:M
                if currCol(i)==1
                    if i==1 || currCol(i-1)==0
                        nObj = nObj+1;
                    end
                    currCol(i) = nObj;
                end
            end
        else
            for i = 1:M
                if currCol(i)==1
                    if (i==1 || currCol(i-1)==0) && (prevCol(i)==0) % up 0, left 0
                        nObj = nObj+1;            
                        currCol(i) = nObj;  % new object generated
                    end
                    if (i>1 && currCol(i-1)~=0) && (prevCol(i)==0) % up 1, left 0
                        currCol(i)=currCol(i-1);
                    end
                    if (i==1 || currCol(i-1)==0) && (prevCol(i)~=0) % up 0, left 1
                        currCol(i)=prevCol(i);
                    end
                    if (i>1 && currCol(i-1)~=0) && (prevCol(i)~=0) % up 1, left 1
                        upLabel = findRealLabel(currCol(i-1),mappingLabel);
                        leftLabel = findRealLabel(prevCol(i),mappingLabel);
                        if (upLabel == leftLabel)  % up = left
                            currCol(i)=leftLabel;
                        else
                            if upLabel>leftLabel
                                mappingLabel(upLabel) = leftLabel;
                                currCol(i) = leftLabel;      
                            else
                                mappingLabel(leftLabel) = upLabel;
                                currCol(i) = upLabel;
                            end
                            nMerge = nMerge+1;
                        end
                    end               
                end
            end      
        end
        Image_new(:,j) = currCol;%to delete in c#
        prevCol=currCol;
    end
    nObj = nObj-nMerge
    Image
    for i=1:size(Image,1)  % print result
        for j=1:size(Image,2)
            if Image_new(i,j)~=0
                Image_new(i,j) = findRealLabel(Image_new(i,j),mappingLabel);
            end
        end
    end
    Image_new
end

function smallLabel = findRealLabel(bigLabel,mappingLabel)
    smallLabel = mappingLabel(bigLabel);
    while (smallLabel~=mappingLabel(smallLabel)) 
        smallLabel=mappingLabel(smallLabel);
    end
end
