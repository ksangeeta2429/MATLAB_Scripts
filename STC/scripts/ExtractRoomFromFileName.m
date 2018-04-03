function roomInFilename=ExtractRoomFromFileName(fileName)

tmp=find(fileName=='_');
tmp2=tmp(1)-1;
roomInFilename=str2num(fileName(1:tmp2));