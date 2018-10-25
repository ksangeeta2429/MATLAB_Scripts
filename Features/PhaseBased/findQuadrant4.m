function qd = findQuadrant4(Comp)

qd = NaN(size(Comp));

I = real(Comp);
Q = imag(Comp);
qd(and(I>=0,Q>=0)) = 1;
qd(and(I>=0,Q<0)) = 4;
qd(and(I<0,Q>=0)) = 2;
qd(and(I<0,Q<0)) = 3;

end

