%fftemoteTest ()
% based on file "FFTTest.m" from November/December 2014

% TODO: convert strings used as type casts to a string variable.


%% Input
str_FFTDataType = 'int16'; % format of data on the device. destinationtype_var = cast(matlab_var,DataType)
str_BufferType = 'uint8'; % format to send the data.  typecast(destinationtype_var,str_BufferType);
zero_offset = 0;
% Note: assume both host and eMote are Little Endian.  so we can just do
% typecast on an array of the destination type and it will come out with
% correct endianness.
% typecast(cast(matlab_var,DataType),str_BufferType) when sending data to eMote.
ComplexSampleSpaceDimensionsSize = [-1 -1; 1 1]; % arranged by column? should state order or use cell structure, e.g. [ realmin realmax ; imagmin imagmax ]. or just use two complex numbers
ComplexSampleSpaceRange = [ ...
    (ComplexSampleSpaceDimensionsSize(2,1)-ComplexSampleSpaceDimensionsSize(1,1)) ...
    (ComplexSampleSpaceDimensionsSize(2,2)-ComplexSampleSpaceDimensionsSize(1,2)) ...
    ];
Nrange = [8 12];
Narray = 2.^(Nrange(1):Nrange(2));
NumN = 25;
Nrep = 2;
MaxBufferSize = 1024; %Maximum buffer size to use on device before splitting. Supported FFT Lengths are 16, 64, 256, 1024. 
MinIntElement = 0; % MAM should not use this if using ComplexSampleSpaceDimensionsSize.  Use range instead.
MaxIntElement = 4095; %MAM should not use this if using ComplexSampleSpaceDimensionsSize. Use range instead.
IntElementRange = 4096;  %MAM: should instead use on 2^ ENOB of ADC resolution, or 2^12 = 4096.
SizeofHistory = 200; % This number should match the history in the embedded code
SizeofFFT = 256; %Supported FFT Lengths are 16, 64, 256, 1024.
%% Initialization
error_cella = cell(numel(Narray),Nrep);
fhandle = @(x)fft(x,SizeofFFT);
AllAccuracy = cell(1,numel(Narray));
AllMismatch = cell(1,numel(Narray));
%TestRunningMean()

%% Select N
for Nindex = 1:numel(Narray)
    N = Narray(Nindex);
    %% Repeat
    Nrep = N; %The number of times the test will be repeated
    for repindex = 1 : Nrep
        % Generate Data
        % TODO: hook this up to real eMote data?
        datainreal = randi([ ... %real magnitude in first column of ComplexSampleSpaceDimensionsSize
            int32(IntElementRange/ComplexSampleSpaceRange(1) * ComplexSampleSpaceDimensionsSize(1,1)) ...
            int32(IntElementRange/ComplexSampleSpaceRange(1) * ComplexSampleSpaceDimensionsSize(2,1)) ...
            ], 1, N, str_FFTDataType);
        datainimag = randi([ ... %imaginary magnitude in second column of ComplexSampleSpaceDimensionsSize
            int32(IntElementRange/ComplexSampleSpaceRange(2) * ComplexSampleSpaceDimensionsSize(1,2)) ...
            int32(IntElementRange/ComplexSampleSpaceRange(2) * ComplexSampleSpaceDimensionsSize(2,2)) ...
            ], 1, N, str_FFTDataType);
        data = complex(datainreal, datainimag);
        results_device = fftemote(data,SizeofFFT);
        %% Calculate ground truth in matlab
        if( strcmp(str_FFTDataType , 'uint8') || strcmp(str_FFTDataType , 'uint16') || strcmp(str_FFTDataType ,'double') )
            results_matlab = fft(double(data),SizeofFFT);
        else
            % TODO: look into qfft quantized fft? or shift input and call?
            % use double fft.
            results_matlab = fft(double(data),SizeofFFT);
        end
        %% sanity check, comment out.
        figure();
        size_subplot = 3;
        itr_subplot = 0;
        
        itr_subplot = itr_subplot + 1;
        subplot(size_subplot,1,itr_subplot);
        hold on;
        plot(real(results_device(1:SizeofFFT)),'b','DisplayName','Device');
        plot(real(results_matlab(1:SizeofFFT)),'r','DisplayName','Matlab');
        legend('hide');
        legend('show');
        str_titleReal=sprintf('Real Raw Periodogram, FFT=%d',SizeofFFT);
        title(str_titleReal);
        
        itr_subplot = itr_subplot + 1;
        subplot(size_subplot,1,itr_subplot);
        hold on;
        plot(angle(results_device(1:SizeofFFT)),'b','DisplayName','Device');
        plot(angle(results_matlab(1:SizeofFFT)),'r','DisplayName','Matlab');
        legend('hide');
        legend('show');
        str_titleAngle=sprintf('Angle Periodogram, FFT=%d',SizeofFFT);
        title(str_titleAngle);
        
%         itr_subplot = itr_subplot + 1;
%         subplot(size_subplot,1,itr_subplot);
%         hold on;
%         plot(real(results_device(1:SizeofFFT)),'b','DisplayName','Device');
%         plot(real(results_matlab(1:SizeofFFT)./SizeofFFT),'r','DisplayName','Matlab/N');
%         legend('hide');
%         legend('show');
%         str_titleNorm=sprintf('Real Periodogram: Mean squared amplitude of MATLAB, FFT=%d',SizeofFFT);
%         title(str_titleNorm);
        
        itr_subplot = itr_subplot + 1;
        subplot(size_subplot,1,itr_subplot);
        hold on;
        plot(abs(results_device(1:SizeofFFT) - results_matlab(1:SizeofFFT))./abs(results_matlab(1:SizeofFFT)),'r','DisplayName','% Error');
        legend('hide');
        legend('show');
        str_titleError=sprintf('Percent Error relative to MATLAB, FFT=%d',SizeofFFT);
        title(str_titleError);
        %% TODO: better error analysis, and sum error over time

        %% Compare results in MATLAB
        % MAM: was this from a different script?
		%[CurMismatchRatio, CurTestAccuracy] = CompareRunning(results_device,results_matlab);
		%AllMismatchRatio{N==Narray}(1,j) = CurMismatchRatio;
		%AllAccuracy{N==Narray}(2,j) = CurTestAccuracy;
        %% Destroy the buffer on the device
        %emote_freebuffer()
    end
end

