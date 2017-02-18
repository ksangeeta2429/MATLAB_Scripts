% Convert a vector in Matlab to an array in C# code to copy

%I = randi(4095,1,32);
%Q = randi(4095,1,32);
% I=I-2048;
% Q=Q-2048;

% tmp=randi(4096,1,256);
%tmp=Freq;

function res = GenerateArrInCsharp(Arr,ifFloat)


res = [];
for j=1:length(Arr)-1
    if ifFloat==0
        res = [res, num2str(Arr(j)),', '];
    else
        res = [res, num2str(Arr(j)),'f, ']; %float number
    end
end
if ifFloat==0
    res = [res, num2str(Arr(length(Arr)))];
else
    res = [res, num2str(Arr(length(Arr))),'f'];%float number
end




% fid = fopen('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Records\tmp.txt','w');
fid = fopen('C:\Users\royd\Documents\WIP\arraysC#.txt','a');
fprintf(fid,res);
fclose(fid);