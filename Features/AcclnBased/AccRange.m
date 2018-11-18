% Data - array of Datalex humbers, mean subtracted
% Window - window length in seconds
% Overlap - Fractional overlap
% Rate - sampling rate
% Implemented as per VV.docx

function Out = AccRange(Data, Window, Overlap, Rate, Quant,USEBGR,bgr,numQuads,short_term_buffer_length)

% I=[442, 747, 406, 2006, 792, 3669, 406, 181, 2283, 3164, 1278, 733, 1389, 861, 2090, 3712, 2576, 416, 1601, 224, 2053, 1768, 4086, 3324, 1989, 3663, 564, 1598, 3798, 3758, 2923, 2533];
% Q=[1406, 3834, 511, 2992, 2648, 3412, 1631, 3071, 3421, 1321, 2262, 4010, 2250, 1354, 2537, 1477, 3098, 1695, 2017, 2845, 3984, 1343, 3431, 3027, 3908, 131, 1462, 2714, 1153, 944, 2913, 2558];
% I=I-2048;
% Q=Q-2048;
% I=[zeros(1,256-32) I];
% Q=[zeros(1,256-32) Q];

% Window=0.5;
% Rate=256;
% Overlap = 0.25;
% Quant=0.9;
% Data=I+i*Q;
% Data=Data';


WindowSamples = round(Window*Rate);
OverlapSamples = round(Overlap*WindowSamples);

% lambda = 3e8/5.8e9;
% Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* lambda/2;

if(USEBGR == 1)
    [qd_Diff,qd_unwrap] = findqd_diff_Bora(Data, numQuads, bgr );
    Range = qd_unwrap;
else
    Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*4096;
end

N = length(Range);

Tau = zeros(1,WindowSamples);
for j = 1:WindowSamples
    number = (j-1) / (WindowSamples - 1);
    Tau(j) = number - 0.5;
end

k=1;
for j = 1:(WindowSamples-OverlapSamples):(N + 1 - WindowSamples)
    A = polyfit(Tau',Range(j:j+WindowSamples-1),3);
    A3 = A(1);
    A2 =A(2);
    
%     k
%     A3 
%     A2
    
    Sign0 = sign(2*A2 + 3*A3);
    Sign1 = sign(2*A2 - 3*A3);

    if (Sign0 == Sign1)
        AccList(k) = abs(2*A2);
    else
        AccList(k) = abs(2*A2/3 + 3*A3/2);
    end
    k=k+1;
end

sort(AccList);   

numAcc = length(AccList);
Index = round(Quant*numAcc);

Out = AccList(Index);


