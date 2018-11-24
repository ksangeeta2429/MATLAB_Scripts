%% DynamicTestRunner_ConnectEmote.m
% Michael Andrew McGrath <Michael.McGrath@Samraksh.com>
% 2014-11-20
% Script starts a connection to the Emote DynamicTestRunner PAL library.
% after this script, make function calls with m_eng.FunctionName();
%
%% Example Commands:
% Transfer execution to a function at address 0x802a7b0, with 0 arguments,
% stored at address [0]
% [m_success, resultAddr] = m_eng.DynamicTestRunnerProcess(uint32(hex2dec('802a7b1')),0,[0])
%
% Allocate a byte buffer from MATLAB:
% [m_success m_bufferAddr] = m_eng.DynamicTestRunnerMallocByteBuffer(bufferSize);
%
% Write to a byte buffer that MATLAB allocated:
% [m_success] = m_eng.DynamicTestRunnerWriteByteBuffer(bufferAddr, byteOffset, bufferLength, inputData);
% Read byte buffer:
% [m_success, m_data, m_readLength] = m_eng.DynamicTestRunnerReadByteBuffer(bufferAddr, byteOffset, bufferLength);
%
% Show byte buffers that MATLAB allocated:
% [m_success, m_bufferAddrs] = m_eng.DynamicTestRunnerShowByteBuffers(unused_uint);
%
% Free all byte buffers that MATLAB allocated:
% [m_success] = m_eng.DynamicTestRunnerFreeAllBuffers(unused_uint);



%% Import custom Samraksh Microsoft.SPOT.Debugger
%TODO: compare file date and only reload if DBG does not exist or dll is
%newer.
str_bora_dll = 'F:\MF\MicroFrameworkPK_v4_3\Samraksh\APPS\DataCollectorHost\DataCollectorHost\bin\Debug\Microsoft.SPOT.Debugger.dll';
str_mike_dll = 'C:\Users\researcher\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\eMote_scripts\Microsoft.SPOT.Debugger.dll';
str_dhrubo_dll = 'C:\Users\roy.174\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\eMote_scripts\Microsoft.SPOT.Debugger.dll';
str_Roy_dll = 'C:\Users\Roy\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\eMote_scripts\Microsoft.SPOT.Debugger.dll';
str_jihoon_dll = 'C:\Users\yun.131\Desktop\MATLAB_Scripts\eMote_scripts\Microsoft.SPOT.Debugger.dll';

portNameMike = 'COM52';
portNameDhrubo = 'COM32';
portNameRoy = 'COM5';
portNameJihoon = 'COM11';

str_dll = '';
portName = '';
if strcmp(getenv('USERNAME'),'he'            )==1
	str_dll = str_jin_dll;
    portName = portNameJin;
elseif strcmp(getenv('USERNAME'),'researcher')==1
	str_dll = str_mike_dll;
    portName = portNameMike;
elseif strcmp(getenv('USERNAME'),'roy.174'      )==1
	str_dll = str_dhrubo_dll;
    portName = portNameDhrubo;
elseif strcmp(getenv('USERNAME'),'Roy'      )==1
	str_dll = str_Roy_dll;
    portName = portNameRoy;
elseif strcmp(getenv('USERNAME'),'yun.131')==1
    str_dll = str_jihoon_dll;
    portName = portNameJihoon;
else
	fprintf('ERROR! no environment defined for user %s.  Please edit this file!\n',getenv('USERNAME'));
end

clear str_bora_dll str_mike_dll str_dhrubo_dll str_jin_dll str_Roy_dll str_jihoon_dll;
clear portNameMike portNameDhrubo portNameJin portNameRoy portNameJihoon;

DBG = NET.addAssembly(str_dll);

%% Port setup
% ON SOME SYSTEMS, NEEDS A SPACE CHARACTER AFTER 'COM'

%portNameSys = strcat('\\\\.\\',portName);
portNameSys = strcat('\\.\',portName);

serialBitRate = uint32(115200);
m_port = Microsoft.SPOT.Debugger.PortDefinition.CreateInstanceForSerial(portName, portNameSys, serialBitRate);

% method used by Data Collector Exfiltrator Host to read output stream
%serialStream = portDef.TryToOpen();  

eMoteSilentConnect = 1;

%% Connect to device
% function ConnectTo(int timeout_ms, bool tryToConnect, Microsoft.SPOT.Debugger.ConnectionSource target)
if(exist('m_eng','var') == 0)
    m_eng = Microsoft.SPOT.Debugger.Engine(m_port);
    
    %TODO: m_eng.OnNoise += new _DBG.NoiseEventHandler(OnNoiseHandler);
    %TODO: m_eng.OnMessage += new _DBG.MessageEventHandler(OnMessage);
    
    m_eng.Start();
end

if(exist('eMoteSilentConnect','var') == 0)
    eMoteSilentConnect = 0;
end

timeout_ms = int32(5000);
retries = int32(10);
for j = 0:1:retries
    if (m_eng.TryToConnect( ...
            int32(0), ...
            int32(timeout_ms / retries), ...
            logical(true), ...
            Microsoft.SPOT.Debugger.ConnectionSource.Unknown ...
            ) > 0)
        if (m_eng.ConnectionSource == Microsoft.SPOT.Debugger.ConnectionSource.TinyCLR)

            if(eMoteSilentConnect ~= 1)
                fprintf('Connected to TinyCLR on %s \n',portName);
            end
            %TODO: m_eng.UnlockDevice(m_data); % might not be necessary if no key is set.
        end
        break;
    end
    if(eMoteSilentConnect ~= 1)
        fprintf('Connect attempt %d to %s failed\n',j,portName);
    end
end

%% Verify we're connected
if (m_eng.ConnectionSource ~= Microsoft.SPOT.Debugger.ConnectionSource.TinyCLR)
    fprintf('################################################################\n');
    fprintf('ERROR! Could not detect TinyCLR running on device at port %s\n', portName);
    fprintf('       ... ensure no other program is using the COM port.\n');
    fprintf('       ... try restarting the eMote .NOW\n');
    fprintf('       ... ensure the TinyCLR is built for DynamicTestRunner\n');
    fprintf('################################################################\n');
    % DynamicTestRunner_DisconnectEmote
    m_eng.Stop();
    m_eng.Dispose();
    clear m_eng;
    return;
end
