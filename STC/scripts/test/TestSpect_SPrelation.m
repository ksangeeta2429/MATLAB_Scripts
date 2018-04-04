%clear all; close all; clc;
% test S and P relation in spectrogram
% abs(S).^2 ./P   == 30403

%I = randi(4095,1,32);
%Q = randi(4095,1,32);
% I=I-2048;
% Q=Q-2048;

I=[442, 747, 406, 2006, 792, 3669, 406, 181, 2283, 3164, 1278, 733, 1389, 861, 2090, 3712, 2576, 416, 1601, 224, 2053, 1768, 4086, 3324, 1989, 3663, 564, 1598, 3798, 3758, 2923, 2533];
Q=[1406, 3834, 511, 2992, 2648, 3412, 1631, 3071, 3421, 1321, 2262, 4010, 2250, 1354, 2537, 1477, 3098, 1695, 2017, 2845, 3984, 1343, 3431, 3027, 3908, 131, 1462, 2714, 1153, 944, 2913, 2558];




FID = fopen('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\scripts\test\I.txt','w');
for j=1:length(I)-1
    fprintf(FID,'%d, ',I(j));
end
fprintf(FID,'%d',I(length(I)));

FID = fopen('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\scripts\test\Q.txt','w');
for j=1:length(Q)-1
    fprintf(FID,'%d, ',Q(j));
end
fprintf(FID,'%d',Q(length(Q)));

fclose('all');


Comp = I+i*Q;
[S,F,T,P]=spectrogram(Comp,256,128,256,300); 
abs(S).^2 ./P;
S;

win=hamming(256);
fft(Comp.*win')


