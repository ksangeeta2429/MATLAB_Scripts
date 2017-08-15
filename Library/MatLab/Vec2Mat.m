function Mat = Vec2Mat(Vec,RowSize,ColumnSize);

N = length(Vec);
if N ~= RowSize * ColumnSize
  ERROR('Size missmatch')
end

Index = MatIndex([1:RowSize], [1:ColumnSize]);
Mat = Vec(Index);