%{
Find threshold given feature number
%}

%first 4 features are DistTime
%10 fft based features for each threshold

function [th] = findFFTThresholdGivenFeatureNumber(f_num)

threshold = 2:2:200;

fft_start = 5;
fft_num_feat = 10;

th = 0;
t = fft_start:fft_num_feat:fft_num_feat*length(threshold);
for i = t
    %fprintf('%d ',i);
    if(f_num >= i && f_num < i+fft_num_feat)
        disp(i);
        th = (i/5)+1;
    end
end
 fprintf('\n');
end

