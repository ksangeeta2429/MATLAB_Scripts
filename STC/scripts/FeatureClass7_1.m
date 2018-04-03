% input: I Q, quan
% output: vector

function f=FeatureClass7_1(I,Q,quan)
f(1)=quantile(abs(I-median(I)),quan);
f(2)=quantile(abs(Q-median(Q)),quan);
f(3)=quantile(((I-median(I)).^2+(Q-median(Q)).^2).^0.5,quan);
% [Range,Index]=doUnwrap(I,Q,300);
% diffRange=Range(2:length(Range))-Range(1:(length(Range)-1));
% f(4)=quantile(abs(diffRange),quan);
