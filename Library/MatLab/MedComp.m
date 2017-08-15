function Med = MedComp(Comp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MedComp -- Fixes non-sense in build in median for complex numbers
%
%   The built in mdeian funciton will sort complex number baised
%   on the amplidute of the numbers and then return the complex
%   value assocated with the midle of that list.  In the case of
%   an odd lenghted list it will return the average of the two
%   complex number near the middle of the list.
%
%   This is a definition.  It's hard to figure what more can be
%   said about it.  It's hard to imagin mathimatical use for 
%   such a definition would serve.
%   
%   This funciton seperates the real and imaginary parts of the
%   complex numbers and returns the medians of each as a complex
%   number.  This is a robust estimation of the center.
%
%   This form of the median is of course, bases on a 
%   projection onto farily arbitarly choose basis.  It's not rotaiton
%   invarent.  But at least it's useful.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = real(Comp);
I = imag(Comp);

Med = median(R) + i*median(I);