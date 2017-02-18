function [ Y ] = fftemote( X,NFFT )
%FFTEMOTE perform fft on emote device
%   Detailed explanation goes here

%% check input
valid_sizes = [16 64 256 1024];
valid_NFFT = false;
if any(NFFT==valid_sizes)
    valid_NFFT = true;
end
if valid_NFFT ~= true
    fprintf('ERROR! invalid FFT size %d passed\n', N);
end

%% init eMote
% edit the following file to have the correct COM port number!
DynamicTestRunner_ConnectEmote
% clear old buffers on device
[m_success] = m_eng.DynamicTestRunnerFreeAllBuffers(uint32(0));

%% Input
str_FFTDataType = 'int16'; % format of data on the device. destinationtype_var = cast(matlab_var,DataType)
str_BufferType = 'uint8'; % format to send the data.  typecast(destinationtype_var,str_BufferType);
zero_offset = 0;
% Note: assume both host and eMote are Little Endian.  so we can just do
% typecast on an array of the destination type and it will come out with
% correct endianness.
% typecast(cast(matlab_var,DataType),str_BufferType) when sending data to eMote.

% ComplexSampleSpaceDimensionsSize = [-1 -1; 1 1]; % arranged by column? should state order or use cell structure, e.g. [ realmin realmax ; imagmin imagmax ]. or just use two complex numbers
% ComplexSampleSpaceRange = [ ...
%     (ComplexSampleSpaceDimensionsSize(2,1)-ComplexSampleSpaceDimensionsSize(1,1)) ...
%     (ComplexSampleSpaceDimensionsSize(2,2)-ComplexSampleSpaceDimensionsSize(1,2)) ...
%     ];
Nrange = [6 12];
Narray = 2.^(Nrange(1):Nrange(2));
NumN = 25;
Nrep = 1;
MaxBufferSize = 1024; %Maximum buffer size to use on device before splitting. Supported FFT Lengths are 16, 64, 256, 1024. 
% MinIntElement = 0; % MAM should not use this if using ComplexSampleSpaceDimensionsSize.  Use range instead.
% MaxIntElement = 4095; %MAM should not use this if using ComplexSampleSpaceDimensionsSize. Use range instead.
% IntElementRange = 4096;  %MAM: should instead use on 2^ ENOB of ADC resolution, or 2^12 = 4096.
% SizeofHistory = 200; % This number should match the history in the embedded code
SizeofFFT = NFFT; %Supported FFT Lengths are 16, 64, 256, 1024.


%% Select N
% for Nindex = 1:numel(Narray)
%     N = Narray(Nindex);
N = length(X);
%     %% Repeat
%     Nrep = N; %The number of times the test will be repeated
%     for repindex = 1 : Nrep

%         % Generate Data
%         % TODO: hook this up to real eMote data?
%         datainreal = randi([ ... %real magnitude in first column of ComplexSampleSpaceDimensionsSize
%             int32(IntElementRange/ComplexSampleSpaceRange(1) * ComplexSampleSpaceDimensionsSize(1,1)) ...
%             int32(IntElementRange/ComplexSampleSpaceRange(1) * ComplexSampleSpaceDimensionsSize(2,1)) ...
%             ], 1, N, str_FFTDataType);
%         datainimag = randi([ ... %imaginary magnitude in second column of ComplexSampleSpaceDimensionsSize
%             int32(IntElementRange/ComplexSampleSpaceRange(2) * ComplexSampleSpaceDimensionsSize(1,2)) ...
%             int32(IntElementRange/ComplexSampleSpaceRange(2) * ComplexSampleSpaceDimensionsSize(2,2)) ...
%             ], 1, N, str_FFTDataType);
%         data = complex(datainreal, datainimag);
%         results_device = nan(1,numel(data));
        BegofDataChunksIndexes = 1:MaxBufferSize:N;
        %% Allocate memory on the device
        % Allocate variables to pass to the CMSIS init function.
        % output: arm_cfft_radix4_instance_q15 * S // pointer to S is passed to FFT call.
        % input: uint16_t fftLen
        % input: uint8_t ifftFlag
        % input: uint8_t bitReverseFlag
        % ... allocate variables
        sizeof_arm_cfft_radix4_instance_q15_packed = 16;
        sizeof_arm_cfft_radix4_instance_q15_aligned = 32;
        sizeof_pointer = 4;
        sizeof_uint16_t = 2;
        sizeof_uint8_t = 1;
        str_pS_type = 'uint32';
        str_fftLen_type = 'uint16';
        str_ifftFlag_type = 'uint8';
        str_bitReverseFlag_type = 'uint8';
        str_pointer_type = 'uint32';

        [m_success, m_bufferAddr_S] = m_eng.DynamicTestRunnerMallocByteBuffer(uint32(sizeof_arm_cfft_radix4_instance_q15_aligned));
        if (m_success == 0)
            fprintf('ERROR MallocByteBuffer returned m_success = %d \n', m_success);
        end
        bufferAddr_S = m_bufferAddr_S;


        [m_success, m_bufferAddr_pS] = m_eng.DynamicTestRunnerMallocByteBuffer(uint32(sizeof_pointer));
        if (m_success == 0)
            fprintf('ERROR MallocByteBuffer returned m_success = %d \n', m_success);
        end
        [m_success] = m_eng.DynamicTestRunnerWriteByteBuffer(uint32(m_bufferAddr_pS), uint32(zero_offset), uint32(sizeof_pointer), typecast(cast(bufferAddr_S,str_pS_type),str_BufferType));
        if (m_success == 0)
            fprintf('ERROR WriteByteBuffer returned m_success = %d \n', m_success);
        end
        bufferAddr_pS = m_bufferAddr_pS;

        fftLen = SizeofFFT;
        [m_success, m_bufferAddr_fftLen] = m_eng.DynamicTestRunnerMallocByteBuffer(uint32(sizeof_uint16_t));
        if (m_success == 0)
            fprintf('ERROR MallocByteBuffer returned m_success = %d \n', m_success);
        end
        [m_success] = m_eng.DynamicTestRunnerWriteByteBuffer(uint32(m_bufferAddr_fftLen), uint32(zero_offset), uint32(sizeof_uint16_t), typecast(cast(fftLen,str_fftLen_type),str_BufferType));
        if (m_success == 0)
            fprintf('ERROR WriteByteBuffer returned m_success = %d \n', m_success);
        end

        ifftFlag = 0;
        [m_success, m_bufferAddr_ifftFlag] = m_eng.DynamicTestRunnerMallocByteBuffer(uint32(sizeof_uint8_t));
        if (m_success == 0)
            fprintf('ERROR MallocByteBuffer returned m_success = %d \n', m_success);
        end
        [m_success] = m_eng.DynamicTestRunnerWriteByteBuffer(uint32(m_bufferAddr_ifftFlag), uint32(zero_offset), uint32(sizeof_uint8_t), typecast(cast(ifftFlag,str_ifftFlag_type),str_BufferType));
        if (m_success == 0)
            fprintf('ERROR WriteByteBuffer returned m_success = %d \n', m_success);
        end

        bitReverseFlag = 1;
        [m_success, m_bufferAddr_bitReverseFlag] = m_eng.DynamicTestRunnerMallocByteBuffer(uint32(sizeof_uint8_t));
        if (m_success == 0)
            fprintf('ERROR MallocByteBuffer returned m_success = %d \n', m_success);
        end
        [m_success] = m_eng.DynamicTestRunnerWriteByteBuffer(uint32(m_bufferAddr_bitReverseFlag), uint32(zero_offset), uint32(sizeof_uint8_t), typecast(cast(bitReverseFlag,str_bitReverseFlag_type),str_BufferType));
        if (m_success == 0)
            fprintf('ERROR WriteByteBuffer returned m_success = %d \n', m_success);
        end


        % allocate FFT data buffer
        sizeof_element = 4; % sizeof(CompT<Int16T>) = 4;
        bufferLength = min(N,MaxBufferSize);  % bufferLength = by element. bufferSize = by byte.
        bufferSize = bufferLength * sizeof_element;
        [m_success, m_bufferAddr_chunk] = m_eng.DynamicTestRunnerMallocByteBuffer(uint32(bufferSize));
        if (m_success == 0)
            fprintf('ERROR MallocByteBuffer returned m_success = %d \n', m_success);
        end

        % allocate and write pointer parameter
        [m_success, m_bufferAddr_pchunk] = m_eng.DynamicTestRunnerMallocByteBuffer(uint32(sizeof_pointer));
        if (m_success == 0)
            fprintf('ERROR MallocByteBuffer returned m_success = %d \n', m_success);
        end
        bufferAddr_pchunk = m_bufferAddr_pchunk;
        [m_success] = m_eng.DynamicTestRunnerWriteByteBuffer(uint32(m_bufferAddr_pchunk), uint32(zero_offset), uint32(sizeof_pointer), typecast(cast(m_bufferAddr_chunk,str_pointer_type),str_BufferType));
        if (m_success == 0)
            fprintf('ERROR WriteByteBuffer returned m_success = %d \n', m_success);
        end


        %% Initialize the FFT and get a pointer to the CMSIS FFT object
        %% arm_status arm_cfft_radix4_init_q15(arm_cfft_radix4_instance_q15 * S, uint16_t fftLen,  uint8_t ifftFlag,  uint8_t bitReverseFlag)
        FunctionIndex = uint32(4); % GlobalTestsTable.h::TestIndex::ARMFFTR4INITQ15 = 4; % index of function 
        argv = uint32([ m_bufferAddr_S m_bufferAddr_fftLen m_bufferAddr_ifftFlag m_bufferAddr_bitReverseFlag ]);
        argc = uint32(length(argv));
        [m_success, m_resultAddr] = m_eng.DynamicTestRunnerProcess( FunctionIndex, argc, argv );
        if (m_success == 0)
            fprintf('ERROR Process returned m_success = %d \n', m_success);
        end        

        %% Load and process the data in chunks
        for chunkindex = 1:numel(BegofDataChunksIndexes)
            firstindexinchunk = BegofDataChunksIndexes(chunkindex);
            lastindexinchunk = min([N ,BegofDataChunksIndexes(chunkindex)+MaxBufferSize-1] );
            data_chunk = X(firstindexinchunk:lastindexinchunk);
            %% Pass the input to the device
            strided_data_chunk = zeros(1,2*length(data_chunk));
            for itr=0:(length(data_chunk)-1)
                strided_data_chunk(itr*2+1) = real(data_chunk(itr+1));
                strided_data_chunk(itr*2+1+1) = imag(data_chunk(itr+1));
            end
            [m_success] = m_eng.DynamicTestRunnerWriteByteBuffer(uint32(m_bufferAddr_chunk), uint32(0), uint32(bufferSize), typecast(cast(strided_data_chunk,str_FFTDataType),str_BufferType));
            if (m_success == 0)
                fprintf('ERROR WriteByteBuffer returned m_success = %d \n', m_success);
            end
            fprintf('WARNING: TODO check length(data_chunk)=%d\n',length(data_chunk));

            %% Initiate the processing of the results
            %%void arm_cfft_radix4_q15(const arm_cfft_radix4_instance_q15 * S, q15_t * pSrc)
            % 2 parameters: init_struct pointer , complex_buffer
            % returns: arm_success
            % Expected result: complex_buffer = fft(complex_buffer,SizeofFFT);
            %ExpectedResult = fft(complex_buffer,2^ln2OfN);
            FunctionIndex = 5; % GlobalTestsTable.h::TestIndex::ARMFFTR4Q15 = 5; % index of function 
            argv = [ m_bufferAddr_S m_bufferAddr_chunk ];
            argc = length(argv);
            [m_success, m_resultAddr] = m_eng.DynamicTestRunnerProcess(uint32(FunctionIndex),uint32(argc),uint32(argv));
            shift = m_resultAddr;

            %% Read results back 
            [m_success, m_data, m_readLength] = m_eng.DynamicTestRunnerReadByteBuffer(uint32(m_bufferAddr_chunk), uint32(0), uint32(bufferSize));
            if (m_success == 0)
                fprintf('ERROR ReadByteBuffer returned m_success = %d \n', m_success);
            end
            strided_results_chunk = typecast(m_data.uint8,str_FFTDataType);
            results_chunk = complex(zeros(1,bufferLength),zeros(1,bufferLength));
            for itr=0:(length(data_chunk)-1)
                results_chunk(itr+1) = complex(strided_results_chunk(itr*2+1),strided_results_chunk(itr*2+1+1));
            end

            %% Save the results to be processed later
            results_device(firstindexinchunk:lastindexinchunk) = results_chunk;
        end
        %% Calculate ground truth in matlab
%         if( strcmp(str_FFTDataType , 'uint8') || strcmp(str_FFTDataType , 'uint16') || strcmp(str_FFTDataType ,'double') )
%             results_matlab = fft(double(data),SizeofFFT);
%         else
%             % TODO: look into qfft quantized fft? or shift input and call?
%             % use double fft.
%             results_matlab = fft(double(data),SizeofFFT);
%         end
        %% sanity check, comment out.
%         figure();
%         size_subplot = 4;
%         subplot(size_subplot,1,1);
%         hold on;
%         plot(real(results_device(1:SizeofFFT)),'b','DisplayName','Device');
%         plot(real(results_matlab(1:SizeofFFT)),'r','DisplayName','Matlab');
%         legend('hide');
%         legend('show');
%         str_titleReal=sprintf('Real Raw Periodogram, FFT=%d',SizeofFFT);
%         title(str_titleReal);
%         subplot(size_subplot,1,2);
%         hold on;
%         plot(angle(results_device(1:SizeofFFT)),'b','DisplayName','Device');
%         plot(angle(results_matlab(1:SizeofFFT)),'r','DisplayName','Matlab');
%         legend('hide');
%         legend('show');
%         str_titleAngle=sprintf('Angle Periodogram, FFT=%d',SizeofFFT);
%         title(str_titleAngle);
%         subplot(size_subplot,1,3);
%         hold on;
%         plot(real(results_device(1:SizeofFFT)),'b','DisplayName','Device');
%         plot(real(results_matlab(1:SizeofFFT)./SizeofFFT),'r','DisplayName','Matlab/N');
%         legend('hide');
%         legend('show');
%         str_titleNorm=sprintf('Real Periodogram: Mean squared amplitude of MATLAB, FFT=%d',SizeofFFT);
%         title(str_titleNorm);
%         subplot(size_subplot,1,4);
%         hold on;
%         plot(abs(results_device(1:SizeofFFT) - results_matlab(1:SizeofFFT))./abs(results_matlab(1:SizeofFFT)),'r','DisplayName','% Error');
%         legend('hide');
%         legend('show');
%         str_titleError=sprintf('Percent Error relative to MATLAB, FFT=%d',SizeofFFT);
%         title(str_titleError);
        %% TODO: better error analysis, and sum error over time

        %% Compare results in MATLAB
        % MAM: was this from a different script?
		%[CurMismatchRatio, CurTestAccuracy] = CompareRunning(results_device,results_matlab);
		%AllMismatchRatio{N==Narray}(1,j) = CurMismatchRatio;
		%AllAccuracy{N==Narray}(2,j) = CurTestAccuracy;
        %% Destroy the buffer on the device
        %emote_freebuffer()
%     end
% end

DynamicTestRunner_DisconnectEmote
Y = results_device.*NFFT;
end

