function qd = findQuadrant8(Comp)

qd = NaN(size(Comp));

I = real(Comp);
Q = imag(Comp);

qd(and(I>=0, Q>=0, Q>=I  )) = 2;
qd(and(I>=0, Q>=0, Q<I )) = 1;

qd(and(I>=0, Q<0, Q>=-I)) = 8;
qd(and(I>=0, Q<0, Q<-I)) = 7;

qd(and(I<0, Q>=0, Q>=-I)) = 3;
qd(and(I<0, Q>=0, Q<-I )) = 4;

qd(and(I<0, Q<0, Q>=I)) = 5;
qd(and(I<0, Q<0, Q<I)) = 6;



end

