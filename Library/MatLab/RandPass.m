function Result = RandPass(NumCharByType)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creates a password according to WAWF rules. Hard to do by hand.

%% Do arguments
if nargin < 1
 [NLower, NCap, NNum, NSpecial] = Split([5,5,3,3]);
else
  [NLower, NCap, NNum, NSpecial] = Split(NumCharByType);
end;
N = NCap + NLower + NNum + NSpecial;

%% Generate Rangom numbers
rand('seed', sum(clock));

Cap = RandReplace(26,NCap) + 'A' - 1;
Lower = RandReplace(26,NLower) + 'a' - 1;
Number = RandReplace(10,NNum) + '0' - 1;

FirstSpecial = ' ' + 1;
NumSpecial = '0' - FirstSpecial;
Special = RandReplace(NumSpecial, NSpecial) + FirstSpecial - 1;

%% Shuffle the output
Temp = char([Cap, Lower, Number, Special]);
Result = Temp(RandUnique(N,N));
