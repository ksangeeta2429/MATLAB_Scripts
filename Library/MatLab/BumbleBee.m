function BumbleBee

SpeedLight = 299792458;
CentFreq = 5.8e9;
lambda = SpeedLight / CentFreq;

assignin('caller','SpeedLight', SpeedLight);
assignin('caller','CentFreq', CentFreq);
assignin('caller','lambda', lambda);