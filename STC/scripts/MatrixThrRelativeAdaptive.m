function A_01=MatrixThrRelativeAdaptive(A,thrFactor)
thr=max(A)*thrFactor;

for i=1:size(A,1)
    A_01(i,:)=A(i,:)>=thr;
end