function TestRange(Real,Imag, Min,Max)

if (min(min(Real),min(Imag)) < Min) || (Max < max(max(Real), max(Imag)))
  error('Data out of range');
end