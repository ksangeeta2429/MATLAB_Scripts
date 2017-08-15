function [foundBackup, backupData, sequenceNumber] = PullDataBackup(SimultaneousData, searchSeqNum, searchLoc, N, packetLength)

foundBackup = 0;
backupData = 0;
[backupDataLoc, temp] = searchForMarker('f0f0', searchLoc, SimultaneousData, packetLength);
% looking for this sequence numbers backup data
if (backupDataLoc < (N-packetLength))
    % it probably won't be the first backup data we find, but if we happen
    % to lose a lot of data it could be
    packetPrev = SimultaneousData(backupDataLoc : backupDataLoc+packetLength-1 );
    [valid, data, sequenceNumber] = checkValid(packetPrev, packetLength);
    if (valid == 1)
        if (sequenceNumber == searchSeqNum)
            foundBackup = 1;
            backupData = double(data);
            return;
        end
    end
end
% if we only lost a little data it will be this one
[backupDataLoc, temp] = searchForMarker('f0f0', backupDataLoc+packetLength, SimultaneousData, packetLength);
if (backupDataLoc < (N-packetLength))
    packetPrev = SimultaneousData(backupDataLoc : backupDataLoc+packetLength-1 );
    [valid, data, sequenceNumber] = checkValid(packetPrev, packetLength);
    if (valid == 1)
        if (sequenceNumber == searchSeqNum)
            foundBackup = 1;
            backupData = double(data);
        end
    end
end


