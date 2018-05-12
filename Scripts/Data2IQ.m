function [ I, Q, N ] = Data2IQ( data, replacementMethod )
%Data2IQ - given a vector data, extract good I Q (smaller than 4096)
%    Purpose is to clean up input signal a little.
%    Does not detect zero threshold.
%
% Input:
% data - strided vector containing integers from [ 0 ... 4095 ]
% replacementMethod - optional. string 'prev', 'mean', 'none', or 'oldcode' (default)
%
% Output:
% I - first offset values (inband) (real part of complex)
% Q - second offset values (quadrature) (imag part of complex)
% N - length of complex data
%
% 2018-05-12 MAM

%FIXME: This is similar to a low-pass filter, but without the logic.
% ... It would be better to just use an actual signal processing method,
% ... so we could more easily determine the filter's effect on the data.

%FIXME: This could filter out legitimate swings, thereby dropping frequency
% ... information.  Need to instead detect directional change.

%FIXME: The logic uses abs() so it detects large swings instead of
% ... spurrious spikes. Was the original intention to filter noise spikes?

%TODO: Write a test function to analyze the effects of the filtering between versions.

c_str_oldcode = 'oldcode';

filterName = c_str_oldcode;
if ~( nargin < 2 || exist( 'replacementMethod', 'var' ) ~= 1 || isempty( replacementMethod ) )
    if strcmpi( replacementMethod,     'prev' ) == true
        filterName = 'prev';
    elseif strcmpi( replacementMethod, 'mean' ) == true
        filterName = 'mean';
    elseif strcmpi( replacementMethod, 'none' ) == true
        filterName = 'none';
    elseif strcmpi( replacementMethod, c_str_oldcode ) == true ...
        || strcmpi( replacementMethod, 'prevInPlace' ) == true
        filterName = c_str_oldcode;
    else
        error('Did not receive valid input for second parameter.');
    end
end

origI = data( [1:2:length(data)-1] );
origQ = data( [2:2:length(data)  ] );
N = length(origI);

adcBits = 12;

if strcmpi(filterName, c_str_oldcode)
    adcMaxValue = 2^adcBits; % old code incorrectly assumed/allowed impossible 4096.
else
    adcMaxValue = 2^adcBits - 1; % actual max ADC value for ADC range [ 0x000 ... 0xFFF ].
end

magSwingPrevThreshold = 2000;
magSwingNextThreshold = 1500;

I = nan(size(origI));
Q = nan(size(origQ));
lidx_badI = false(size(I));
lidx_badQ = false(size(Q));

% filter the raw data
for itr = 2:(N-1)

    magSwingPrevI = abs( origI(itr) - origI(itr-1) );
    magSwingNextI = abs( origI(itr) - origI(itr+1) );
    if ( ( origI(itr) > adcMaxValue ) ...
         || (   magSwingPrevI > magSwingPrevThreshold   ...
             && magSwingNextI > magSwingNextThreshold ) ...
       )
        lidx_badI(itr) = true;
        switch filterName
            case 'mean'
                I(itr) = mean(origI(itr-1), origI(itr+1)); % replace swing with mean.
            case 'prev'
                I(itr) = origI(itr-1);     % replace swing with previous value.
            case 'none'
                I(itr) = origI(itr);       % do nothing.
            case 'oldcode'
                origI(itr) = origI(itr-1); % edit-in-place with previous value.
            otherwise
                error('Something went wrong. Impossible case switch.');
        end
    end

    magSwingPrevQ = abs( origQ(itr) - origQ(itr-1) );
    magSwingNextQ = abs( origQ(itr) - origQ(itr+1) );
    if ( ( origQ(itr) > adcMaxValue ) ...
         || (   magSwingPrevQ > magSwingPrevThreshold   ...
             && magSwingNextQ > magSwingNextThreshold ) ...
       )
        lidx_badQ = true;
        switch filterName
            case 'mean'
                Q(itr) = mean(origQ(itr-1), origQ(itr+1)); % replace swing with mean.
            case 'prev'
                Q(itr) = origQ(itr-1);     % replace swing with previous value
            case 'none'
                Q(itr) = origQ(itr);       % do nothing.
            case 'oldcode'
                origQ(itr) = origQ(itr-1); % edit-in-place with previous value.
            otherwise
                error('Something went wrong. Impossible case switch.');
        end
    end
end

if strcmpi(filterName, 'oldcode') == true
    I = origI;
    Q = origQ(1:N);
end

if sum(data == 2^adcBits) > 0
    warning( [ 'Input data contained a bad value that would have been passed ' ...
        'with previous version of code or current filter ''oldcode''.' ] );
end


DEBUG = 0;
if DEBUG == 1
    disp( [ 'Found ' num2str(sum(lidx_badI)) ' bad I and ' num2str(sum(lidx_badQ)) ' bad Q.' ] );
    dcBiasOrigI = median(data( [1:2:length(data)-1] ));
    origQ_redo =         data( [2:2:length(data)  ] ) ;
    dcBiasOrigQ = median( origQ_redo(1:N) );  % ignore extra val when input length is odd.
    dcBiasI = median(I);
    dcBiasQ = median(Q);
    if dcBiasOrigI ~= dcBiasI
        warning( [ 'dcBiasOrigI = ' num2str(dcBiasOrigI) '; dcBiasI = ' num2str(dcBiasI) ] );
    end
    if dcBiasOrigQ ~= dcBiasQ
        warning( [ 'dcBiasOrigQ = ' num2str(dcBiasOrigQ) '; dcBiasQ = ' num2str(dcBiasQ) ] );
    end
    % TODO: plot statistics.
end

end
