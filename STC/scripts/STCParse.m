% STCParse - convert .txt file to .data file which only contain [I Q I Q ..]
% input: string - file name (.txt file)
% output: none.
% do: write into a .data file

function STCParse(fileName)
%close all;
%clear all;clc;
%fileName='';

numSamplesPerPkt = 20; 
InId = fopen(sprintf('../txt files/%s.txt', fileName), 'r');

if exist(sprintf('../data files/%s.data', fileName))==0
    OutId = fopen(sprintf('../data files/%s.data', fileName), 'w');
else 'Exist!'
end

if (InId < 0)
  fprintf(1,'Could not open input file');
  return;
end

indexPkt = 0;
missingSeq = 0;
prevSeq = 0;
firstSeq = 0;


if OutId < 0
    fprintf(1,'Colud not open output file');
    return;
end

Line = fgetl(InId);
while ischar(Line)
    Bytes = sscanf(Line, '%x');
    if (length(Bytes) > 50)
        src = Bytes(9)*256 + Bytes(10);
        seqnum = Bytes(11)*256 + Bytes(12); 
        if (indexPkt == 0)
            prevSeq = seqnum;
            firstSeq = seqnum;
        else
            diff = seqnum - prevSeq - 1;
            missingSeq = missingSeq + diff;
            prevSeq = seqnum;
        end
  
        for (k = 1:1:numSamplesPerPkt)
            offset = 4*(k-1);
  
            I = Bytes(13+offset)*256 + Bytes(14+offset);
            Q = Bytes(15+offset)*256 + Bytes(16+offset);
            fwrite(OutId, [I Q], 'int16');
        end
  
        indexPkt = indexPkt + 1;
    end
numPkt=indexPkt;
    
%     if mod(indexPkt,1e3) == 0
%         fprintf(1, '%d ', indexPkt/1e3);
%         if mod(indexPkt, 10e3) == 0
%           fprintf(1, '\n');
%         end
%     end
    Line = fgetl(InId);
end

fclose(InId);
fclose(OutId);

fprintf(1, '\n Missing = %d out of %d\n', missingSeq, seqnum-firstSeq);

%Visualize(fileName);
%ImplementClassifier;                 %%%% TO DO %%%



