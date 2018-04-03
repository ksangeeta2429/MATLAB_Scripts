% input: I Q
% output: vector
% Time domain features


function f=FeatureClass7(I,Q)   % changed, hasn't  been tested
f(1)=var(I);
f(2)=var(Q);

 f(3)=mean(abs(I-median(I)));
 f(4)=var(abs(I-median(I)));
f(5)=mean(abs(Q-median(Q)));
f(6)=var(abs(Q-median(Q)));
f(7)=mean(((I-median(I)).^2+(Q-median(Q)).^2).^0.5);
f(8)=var(((I-median(I)).^2+(Q-median(Q)).^2).^0.5);

% [Range,Index]=doUnwrap(I,Q,300);
% f(9)=var(Range); % meaningless
% diffRange=Range(2:length(Range))-Range(1:(length(Range)-1));
% f(10)=var(diffRange);
% f(11)=mean(abs(diffRange));
% f(12)=var(abs(diffRange));

