function checkbbsFile(fileName)
    [I,Q,N]=Data2IQ(ReadBin([fileName]));
    zero_index = [];
    
    for i = 1:length(I)
        %if(I(i) == 0 || Q(i) == 0)
        if(I(i) == 0)
            zero_index = [zero_index i];
            %fprintf('Found 0 at index %d\n',i);
        end    
    end
    plot(I);
    disp(zero_index);
end