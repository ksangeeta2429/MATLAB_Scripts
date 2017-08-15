function [valid,data,sequenceNumber,ID,version] = checkValid(packet, packetLength)
    valid = 0;
    data = 0;
    sequenceNumber = 0;
ID = packet(3);
version = packet(4);    
    
if (length(packet) ~= packetLength)
    return;
end
checksum = packet(packetLength);

%calculating checksum
calcChecksum16 = 0;
calcChecksum = cast(calcChecksum16, 'double');
for i = 1:(packetLength-1)
    pVal = cast(packet(i), 'double');
    calcChecksum = calcChecksum + pVal;
end
calcChecksum = mod(calcChecksum,65536);

if (checksum == calcChecksum)    
    sequenceNumber = packet(2);
else
    %disp('Failed checksum');
    valid = 0;
    data = 0;
    return;
end

valid = 1;
data = packet(5:length(packet)-1);
ID = packet(3);
version = packet(4);

