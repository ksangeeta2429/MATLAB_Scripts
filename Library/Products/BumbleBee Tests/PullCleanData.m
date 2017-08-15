function [cleanData, ID, version] = PullCleanData(SimultaneousData)

% header is 1 marker and 1 sequence, 250 I, 250 Q, 1 checksum ====> 503
packetLength = 255;

% dropping any incomplete packets
N = length(SimultaneousData) - mod(length(SimultaneousData),packetLength);

currentFileLoc = 1;
currentPacketSequenceNumber = 0;
cleanData = double(0);
lastGoodSequenceNumber = 0;

while (currentFileLoc < (N-packetLength))
    % pulling data from what should be a complete packet (if there was no
    % data loss)
    packetCurrent = SimultaneousData(currentFileLoc : currentFileLoc+packetLength-1 );
    [valid, data, sequenceNumber, ID,version] = checkValid(packetCurrent, packetLength);
    if (valid == 1)
        % for the very first packet pulled we save initialize cleanData
        % with it
        if (cleanData == 0)
            cleanData = double(data);
            %X = ['sequence number: ', num2str(sequenceNumber)];disp( X);
            lastGoodSequenceNumber = sequenceNumber;
        else
           % we have valid data but if we missed a sequence number then we
           % will try and get the backup data for the missing sequence
           % before writing the data we just got
           if (sequenceNumber ~= lastGoodSequenceNumber+1)
               % the sequence number indicates we dropped some data so we
               % will attempt to pull that missing sequence packet from the
               % backup data that should be 0 - 1509 values further on in
               % the data (depending upon how much data was dropped)
               [foundBackup, backupData, sequenceNumberBU] = PullDataBackup(SimultaneousData, lastGoodSequenceNumber + 1, currentFileLoc, N, packetLength);
               if (foundBackup == 1)
                   cleanData = [cleanData; double(backupData)];
                   X = ['sequence number (based on backup): ', num2str(sequenceNumberBU)]; disp( X); 
                   lastGoodSequenceNumber = sequenceNumberBU;
               end			  
           end
           
           % ok, we wrote any missing sequence data to cleanData (shouldn't
           % happen often) so now we save the data we just pulled
           while (sequenceNumber ~= lastGoodSequenceNumber+1)
              X = ['missing sequence number: ', num2str(lastGoodSequenceNumber+1)]; disp( X);   		  
              lastGoodSequenceNumber = lastGoodSequenceNumber + 1;
           end
           %X = ['sequence number: ', num2str(sequenceNumber)];disp( X);
           lastGoodSequenceNumber = sequenceNumber;
           cleanData = [cleanData; double(data)];
        end
        currentFileLoc = currentFileLoc+packetLength;
    else
       X = ['packet not valid for sequence number ', num2str(lastGoodSequenceNumber + 1)];disp( X);
       % the data packet we analyzed was not valid so we probably had data
       % loss...attempting to recover it from the backup data stored a
       % little further on in the data
       [foundBackup, backupData, sequenceNumber] = PullDataBackup(SimultaneousData, lastGoodSequenceNumber + 1, currentFileLoc, N, packetLength);
       if (foundBackup == 1)
           cleanData = [cleanData; double(backupData)];
           X = ['sequence number (based on backup): ', num2str(sequenceNumber)];disp( X);
           lastGoodSequenceNumber = sequenceNumber;
       end
       startSearch = currentFileLoc;
        [currentFileLoc, SimultaneousData] = searchForMarker('f0f0', currentFileLoc+1, SimultaneousData, packetLength);
        % SimultaneousData might have changed
        N = length(SimultaneousData) - mod(length(SimultaneousData),packetLength);
        if ((currentFileLoc - startSearch)>packetLength)
            X = ['dropped ', num2str(currentFileLoc - startSearch), ' bytes'];disp( X);
        else
          %X = ['found marker after ', num2str(currentFileLoc - startSearch), ' bytes'];disp( X);
        end
        if (currentFileLoc == N)  
          disp('Marker not found. Quitting.');
          return;
        end       
    end

    if (currentFileLoc < (N-packetLength))
        packetPrev = SimultaneousData(currentFileLoc : currentFileLoc+packetLength-1 );
        [valid, data, sequenceNumber, ID,version] = checkValid(packetPrev, packetLength);
        if (valid == 1)       
           currentFileLoc = currentFileLoc+packetLength;
        else
          startSearch = currentFileLoc;
          [currentFileLoc, SimultaneousData] = searchForMarker('a5a5', currentFileLoc, SimultaneousData, packetLength);
          % SimultaneousData might have changed
           N = length(SimultaneousData) - mod(length(SimultaneousData),packetLength);
          if ((currentFileLoc - startSearch)>packetLength)
            X = ['dropped ', num2str(currentFileLoc - startSearch), ' bytes'];disp( X);
          else
              %X = ['found marker after ', num2str(currentFileLoc - startSearch), ' bytes'];disp( X);
          end
          if (currentFileLoc == N)  
              disp('Marker not found. Quitting.');
             return;
          end
        end 
    end
end
