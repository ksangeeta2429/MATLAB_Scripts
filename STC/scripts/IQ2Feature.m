% input: I Q
% output: a vector - features

function f=IQ2Feature(I, Q, sampRate,m,s,fClass)          % given I and Q, produce feature vector f (N*1)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% chosen features %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(fClass)==1
    if fClass==0                           % means already chosen parameters
    %     %%%%%%%%%%%%%%%% Class 1 %%%%%%%%
    %     f(1)=ParamIndex2Feature(59, 1, I, Q);
    %     f(2)=ParamIndex2Feature(11, 1, I, Q);
    %     f(3)=ParamIndex2Feature(35, 1, I, Q);
    %    
    %     % %%%%%%%%%%%%%%% Class 2 %%%%%%%%%
    %     f(4)=ParamIndex2Feature(167, 2, I, Q);
    %     f(5)=ParamIndex2Feature(153, 2, I, Q);
    %     f(6)=ParamIndex2Feature(139, 2, I, Q);
    %     
    % %     % %%%%%%%%%%%%%%% Class 3 %%%%%%%%%
    % %     f(7)=ParamIndex2Feature(127, 3, I, Q);
    % %     f(8)=ParamIndex2Feature(47, 3, I, Q);
    % %     f(9)=ParamIndex2Feature(207, 3, I, Q);
    % %     f(10)=ParamIndex2Feature(607, 3, I, Q);
    % %     f(11)=ParamIndex2Feature(687, 3, I, Q);
    % %     f(12)=ParamIndex2Feature(767, 3, I, Q);
    % %     f(13)=ParamIndex2Feature(367, 3, I, Q);
    %     
    %     % %%%%%%%%%%%%%%% Class 4 %%%%%%%%%
    %     f(14)=ParamIndex2Feature(299, 4, I, Q);
    %     f(15)=ParamIndex2Feature(244, 4, I, Q);
    %     f(16)=ParamIndex2Feature(144, 4, I, Q);
    %     f(17)=ParamIndex2Feature(219, 4, I, Q);
    %     f(18)=ParamIndex2Feature(169, 4, I, Q);
    %     f(19)=ParamIndex2Feature(294, 4, I, Q);
    %     f(20)=ParamIndex2Feature(69, 4, I, Q);
    %     
    %     % %%%%%%%%%%%%%%% Class 5 %%%%%%%%%%
    %     f(21)=ParamIndex2Feature(88, 5, I, Q);
    %     f(22)=ParamIndex2Feature(288, 5, I, Q);
    %     f(23)=ParamIndex2Feature(488, 5, I, Q);
    %     f(24)=ParamIndex2Feature(1298, 5, I, Q);
    %     f(25)=ParamIndex2Feature(1498, 5, I, Q);
    %     f(26)=ParamIndex2Feature(688, 5, I, Q);
    %     
    %     % %%%%%%%%%%%%%%% Class 6 %%%%%%%%%%
    %     f(27)=ParamIndex2Feature(54, 6, I, Q);
    %     f(28)=ParamIndex2Feature(60, 6, I, Q);
    %     f(29)=ParamIndex2Feature(48, 6, I, Q);
    %     f(30)=ParamIndex2Feature(42, 6, I, Q);
    %     f(31)=ParamIndex2Feature(47, 6, I, Q);
    %     f(32)=ParamIndex2Feature(41, 6, I, Q);
    %     
    %     %%%%%%%%%%%%%%%%% Class 7 %%%%%%%%%%%
    %     offset=0;%-32;
    %     f(33+offset)=ParamIndex2Feature(3,7,I,Q);
    %     f(34+offset)=ParamIndex2Feature(1,7,I,Q);
    %     f(35+offset)=ParamIndex2Feature(6,7,I,Q);
    %     f(36+offset)=ParamIndex2Feature(10,7,I,Q);
    %     
    %     %%%%%%%%%%%%%%%%% Class 7.1 %%%%%%%%%
    %     f(37+offset)=ParamIndex2Feature(36,7.1,I,Q);
    %     f(38+offset)=ParamIndex2Feature(33,7.1,I,Q);
    %     f(39+offset)=ParamIndex2Feature(35,7.1,I,Q);
    %     f(40+offset)=ParamIndex2Feature(3,7.1,I,Q);
    %     f(41+offset)=ParamIndex2Feature(5,7.1,I,Q);
    %     f(42+offset)=ParamIndex2Feature(7,7.1,I,Q);
    %     
    %     %%%%%%%%%%%%%%%%% Class 8.1 %%%%%%%%%
    %     f(43+offset)=ParamIndex2Feature(13, 8.1,I,Q);
    %     f(44+offset)=ParamIndex2Feature(15, 8.1,I,Q);
    %     f(45+offset)=ParamIndex2Feature(17, 8.1,I,Q);
    %     f(46+offset)=ParamIndex2Feature(19, 8.1,I,Q);
    %     f(47+offset)=ParamIndex2Feature(23, 8.1,I,Q);
    %     
    %     %%%%%%%%%%%%%%%%% Class 9.1 %%%%%%%%%
    %     f(48+offset)=ParamIndex2Feature(1, 9.1,I,Q);
    %     f(49+offset)=ParamIndex2Feature(7, 9.1,I,Q);
    %     f(50+offset)=ParamIndex2Feature(8, 9.1,I,Q);
    %     f(51+offset)=ParamIndex2Feature(9, 9.1,I,Q);
    %     f(52+offset)=ParamIndex2Feature(10, 9.1,I,Q);
    %     f(53+offset)=ParamIndex2Feature(11, 9.1,I,Q);
    %     f(54+offset)=ParamIndex2Feature(12, 9.1,I,Q);
    %     f(55+offset)=ParamIndex2Feature(13, 9.1,I,Q);
    %     f(56+offset)=ParamIndex2Feature(14, 9.1,I,Q);
    %     f(57+offset)=ParamIndex2Feature(18, 9.1,I,Q);
    %     f(58+offset)=ParamIndex2Feature(19, 9.1,I,Q);
    %     f(59+offset)=ParamIndex2Feature(20, 9.1,I,Q);
    %     f(60+offset)=ParamIndex2Feature(21, 9.1,I,Q);
    %     f(61+offset)=ParamIndex2Feature(22, 9.1,I,Q);
    %     f(62+offset)=ParamIndex2Feature(23, 9.1,I,Q);
    %     f(63+offset)=ParamIndex2Feature(24, 9.1,I,Q);
    %     f(64+offset)=ParamIndex2Feature(25, 9.1,I,Q);
    %     
    %     %%%%%%%%%%%%%%% Class 3.2  %%%%%%%%
    %     f(65)=ParamIndex2Feature(366, 3.2,I,Q);
    %     f(66)=ParamIndex2Feature(551, 3.2,I,Q);
    %     f(67)=ParamIndex2Feature(584, 3.2,I,Q);
    %     f(68)=ParamIndex2Feature(598, 3.2,I,Q);
    %     f(69)=ParamIndex2Feature(601, 3.2,I,Q);
    %     f(70)=ParamIndex2Feature(598, 3.2,I,Q);
    %     
    %     %f()=ParamIndex2Feature(featureIndex, class,I,Q);

        f1=parameterized_features(I,Q,8.2);
        f2=parameterized_features(I,Q,3.2);
        f=[f1,f2];
    else       % if fClass~=0   means chosing parameters
        %%%%%%%%%%%%%%%%%%%%% parameterized features %%%%%%%%%%%%%%%%%%%%%%%%%%                   
        f=parameterized_features(I,Q,fClass); 
    end
else % length(fClass)>1 multiple feature classes
    f=[];
    for i=1:length(fClass)
        tmp=parameterized_features(I,Q,fClass(i));
        f=[f,tmp];
    end
end
    
   
            