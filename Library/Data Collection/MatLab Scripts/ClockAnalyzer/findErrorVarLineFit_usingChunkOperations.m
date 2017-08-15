function r = findErrorVarLineFit_usingChunkOperations(LAMemMap,curIndexNumbers,p)
%This function traverses input to collect stats for a line fi
    p = ChunkOperationOnMemoryMapData3(@findLineFit_usingChunkOperations,LAMemMap, 1000000, [curIndexNumbers(1) curIndexNumbers(end)] );
    r = ChunkOperationOnMemoryMapData3(@findLineFit_usingChunkOperations,LAMemMap, 1000000, [curIndexNumbers(1) curIndexNumbers(end)] );
end