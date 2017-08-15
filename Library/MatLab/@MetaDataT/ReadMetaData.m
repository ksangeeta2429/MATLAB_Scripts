function MetaDataSet = ReadMetaData(FileName)

LineStream = LineStreamT(FileName);

while (~eof(File))
  Line = LineStream.Next();
  [Tag, Value] = scanf('\%s %s', Line);
 
  if lowercase(Tag) ~= 'name'
    LineStream.Warn('Record must start with "Name"')
    
    Line = LineStream.Next();
    [Tag, Value] = scanf('\%s %s', Line);
    while (lowercase(Tag) ~= 'name')
      Line = LineStream.Next();
      [Tag, Value] = scanf('\%s %s', Line);
    end
    LineStream.Warn('Resuming on next record')
    
  else
    Name = Value;
    ValueSet = {};
    TagSet = {};
    
    [Tag, Value] = scanf('\%s %s', Line);
    while (lowercase(Tag ~= 'name')
      TagSet = {TagSet, Tag};
      ValueSet = {ValueSet, Value};
      [Tag, Value] = scanf('\%s %s', Line);
    end
    
  end
  
  MetaData{Tag}
end