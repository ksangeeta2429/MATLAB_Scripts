%pad the signal with zeros if length is less than each segment length of
%spectrogram
function data = padSignalWithZeros(X,WINDOW,NOVERLAP,NFFT,Fs)
nx = length(X);
WINDOW;
NOVERLAP;
number = (nx-NOVERLAP)/(WINDOW-NOVERLAP);
integ = floor(number);
fract = number-integ;
if(nx < WINDOW)
    %Pad the end of X with WINDOW - nx zero's
    X = [X;zeros(WINDOW-nx,1)];
elseif(fract ~= 0)
    temp = nx/(WINDOW-NOVERLAP);
    integer = floor(temp);
    fract = temp - integer;
    del = round((WINDOW-NOVERLAP)*fract);
    if(del < (floor((WINDOW-NOVERLAP) / 2)))
        %delete del number of samples at the end of the cut
        cut_size = length(X);
        X = X(1:cut_size-del);
    else
        %pad the end of X with n_pad_zeros zero's
        temp = floor((nx-NOVERLAP)/(WINDOW-NOVERLAP)) + 1;
        n_pad_zeros = (temp * (WINDOW-NOVERLAP)) - (nx-NOVERLAP);
        X = [X; zeros(n_pad_zeros,1)];
    end
end
data = X;
end