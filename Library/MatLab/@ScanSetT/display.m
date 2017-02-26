function display(Obj)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ScanSetT/display -- The display method for the ScanSetT class.

display(' ')
display([inputname(1), ' = ', ...
  sprintf('ScanSetT(NumScan=%d, NumSamp=%d, NumChan=%d)', ...
    Obj.NumScan, Obj.NumSamp, Obj.NumChan)])
display(' ')