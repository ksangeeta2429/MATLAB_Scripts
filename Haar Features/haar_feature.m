function x=haar_feature(Data,levels)
% haar_feature - Jin He's Haar wavelet feature (updated for compatibility)
%
% requires dwt function in MATLAB wavelet toolbox.
%
% Updated 2018-07-27 by Michael McGrath <mcgrath.57@osu.edu>
% - do same computation, but make compatible with MATLAB R2016
% - note: dwt is for 1-D real signals (not complex)... MATLAB R2016
% validates input is real.
%
% Input:
% Data - 1D complex signal
% levels - number of wavelet reduction levels
%
% Output:
% x - 1D vector of complex magnitude squared of the detail coefficients from each level and the summed complex magnitude squared approximation
% coefficients from the last level.

%     Data=[2 2 2 2 2 2 2 2];
%     levels=3;

    %addpath('C:\ProgramFiles\MATLAB\R2015b\toolbox\wavelet\wavelet');
    %addpath('/usr/local/MATLAB/R2016b/toolbox/wavelet/wavelet');
    a=Data;
    a_real = real(a);
    a_imag = imag(a);
    x=[];
    for i=1:levels
        [a_real,d_real]=dwt(a_real,'haar');
        [a_imag,d_imag]=dwt(a_imag,'haar');
        d_comp = complex(d_real,d_imag);
        x=[x,sum(abs(d_comp).^2)];
    end
    a_comp = complex(a_real,a_imag);
    x=[x,sum(abs(a_comp).^2)];
end
