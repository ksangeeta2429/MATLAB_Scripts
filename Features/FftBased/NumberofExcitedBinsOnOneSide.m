% find the number of excited bins for two sides around 0 Hz frequency return the number of
% excited bins for both sides
function [result1,result2] = NumberofExcitedBinsOnOneSide(Img)
    %Img has frequency as columns and time as rows which is opposite of
    %TimeFreq visualizations.
    split_col = round(size(Img,2)/2);   % number of columns in Img divided by 2. This is the center column of Image corresponding to 0 Hz band..
    part1 = 0;
    part2 = 0;
    for i = 1:size(Img,1)
        for j = 1:split_col
            part1 = part1 + Img(i,j);
        end
    end
    for i = 1:size(Img,1)
        for j = (split_col+1):size(Img,2)
            part2 = part2 + Img(i,j);
        end
    end
    result1 = part1;
    result2 = part2;
end
    
