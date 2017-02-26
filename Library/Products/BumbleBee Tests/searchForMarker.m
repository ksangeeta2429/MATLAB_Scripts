function [validLoc, FileData] = searchForMarker(marker, currentFileLoc, FileData, packetLength)

N = currentFileLoc + packetLength*4;
markerDec = hex2dec(marker);

% searching file expecting even byte drop
for (i= currentFileLoc:N)
    if (FileData(i) == markerDec)
        testPacket = FileData(i : i+packetLength-1 );
        [valid, data, sequenceNumber, ID,version] = checkValid(testPacket, packetLength);
        if (valid ==1)
            validLoc = i;
            return
        end
    end
end

% couldn't find marker, perhaps everything is offset by one byte
FileData8 = typecast(uint16(FileData), 'uint8');
FileData8 = FileData8(2:length(FileData8)-1-mod(length(FileData8),2));
FileDataShift = typecast(uint8(FileData8), 'uint16');

N = length(FileDataShift);
for (i= currentFileLoc:N)
    if (FileDataShift(i) == markerDec)
        validLoc = i;
        FileData = FileDataShift;
        return
    end
end

validLoc = N;