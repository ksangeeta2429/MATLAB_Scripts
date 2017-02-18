function x=haar_feature(Data,levels)
%     Data=[2 2 2 2 2 2 2 2];
%     levels=3;

    %addpath('C:\ProgramFiles\MATLAB\R2015b\toolbox\wavelet\wavelet');
    %addpath('/usr/local/MATLAB/R2016b/toolbox/wavelet/wavelet');
    a=Data;
    x=[];
    for i=1:levels
        [a,d]=dwt(a,'haar');
        x=[x,sum(abs(d).^2)];
    end
    x=[x,sum(abs(a).^2)];
end