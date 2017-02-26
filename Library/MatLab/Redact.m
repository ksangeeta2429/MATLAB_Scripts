function Redact(InFile, OutFile)

FidIn = fopen(InFile, 'r');
FidOut = fopen(OutFile, 'w');

while ~feof(FidIn)
  LineIn = fgetl(FidIn);
  
  for i = 1 : length(LineIn)
    CharIn = LineIn(i);
    
    if ('a' <= CharIn) && (CharIn <= 'z')
      CharOut = floor(rand(1)*26) + 'a';
    elseif ('A' <= CharIn) && (CharIn <= 'Z')
      CharOut = floor(rand(1)*26) + 'A';
    elseif ('0' <= CharIn) && (CharIn <= '9')
      CharOut = floor(rand(1)*10) + '0';
    else
      CharOut = CharIn;
    end
    
    LineOut(i) = CharOut;
  end
  
  fprintf(FidOut, '%s\n', LineOut);
end

fclose(FidIn);
fclose(FidOut);