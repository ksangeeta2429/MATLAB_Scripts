% Input: time1(s) time2(s)
% Output: none
% Do: Wait for time1 seconds, Collect for time2 seconds, stop Collecting

function Collect(time1, time2)
pause(time1);
DataControl(1,1);
pause(time2);
DataControl(1,2);
