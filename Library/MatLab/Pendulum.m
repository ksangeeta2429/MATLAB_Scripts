function Pendulum()
% Fft_8 -- Call Fft form the DLL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% initial time to estimate I and Q DC values in seconds
MedianEstTime = 10;
SampRate = 167;

OutData = zeros(1,Width);
PendViz = zeros(1,201);

if ~libisloaded('sf')
    loadlibrary('sf','MatLab.h')
end
calllib('sf','init',7); %Virutal COM port number for the Tmote

readarray = [1:3];
rp = libpointer('int16Ptr',readarray);

chI = single(0);
chQ = single(0);
sampNum = 1;

% initialize phase variables
l = 1;
uphase = 0;
wphase = 0;
uphase_prev = 0;
wphase_prev = 0;

% Display parameters
minDisp = -100;
maxDisp = 100;
PendX = [minDisp:maxDisp];

% in an infinite loop, receive data from the mote
while (1 > 0)
    calllib('sf','readVals',rp);
    result = get(rp,'Value');

    valid = result(1);
    chI = single(result(2));
    chQ = single(result(3));
    
    if (valid==1)
        
        % store first MedianEstTime seconds of data in a buffer 
        if (sampNum < MedianEstTime*SampRate)
            medianDataI(sampNum) = chI;
            medianDataQ(sampNum) = chQ;
            sampNum = sampNum + 1;
        end

        % after MedianEstTime seconds, compute the median values for 
        % I and Q DC
        if (sampNum == MedianEstTime*SampRate)
            medI = median(medianDataI)       
            medQ = median(medianDataQ)       
            sampNum = sampNum + 1
        end
        
        % use estimated DC to do phase unwrapping only, w/o origin tracking
        if (sampNum > MedianEstTime*SampRate)
            chI = chI - medI;
            chQ = chQ - medQ;

            c = chI + i*chQ;
        
            phase = angle(c);
        
            if (l==1)
                uphase = phase;
                l = 2;
            else
                phase_diff = phase - wphase_prev;
                if (phase_diff < -pi)
                    phase_diff = phase_diff + 2*pi;
                elseif (phase_diff > pi)
                    phase_diff = phase_diff - 2*pi;
                end
                uphase = uphase_prev + phase_diff;
            end
        
            wphase_prev = phase;
            uphase_prev = uphase;

            % PendViz is an array whose elements are all 0s, except for the
            % current value of the phase, which is set to -10. Based on the
            % pendulum's oscillation amplitude, phase can be from -100 to
            % 100 but array indices have to be +ve so we shift by 100.
            % Also, for efficiency, we only display pendulum position every
            % 10th sample. 
            if (sampNum > MedianEstTime*SampRate && mod(sampNum, 10) == 0)
                phaseIndex = round(uphase) + 100;
                PendViz(phaseIndex) = -10;
                plot(PendX, PendViz);
                axis([minDisp maxDisp -20 10]);
                pause(0.005);
                PendViz(phaseIndex) = 0;
            end

            sampNum = sampNum + 1;
        end
    end
end
calllib('sf','close');
unloadlibrary 'sf';
