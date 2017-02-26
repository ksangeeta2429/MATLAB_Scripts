%% Description:
%This script analysis the drift.
% 
% Inp: --
% The output is saved into the file specified by MemMapFilename
%
% Input:
% MemMapFilename: The filename of the mmap file
% ChunkSize     : Number of lines to be read at a time
% SamplePeriod  : The sample period for sampled read form the cvs file.
%               Setting this equal to ChunkSize reads all lines. Together with chunk size
%               allows duty cyled, undersampled reading. 
%% Author: Bora Karaoglu
%% Define Inputs
%cur_directory = 'F:\Users\Bora\Samraksh\ClockSyncProject\Data\HSI_32Mhz_19BSamples\';
%cur_directory = 'F:\Users\Bora\Samraksh\ClockSyncProject\Data\HSI_32Mhz_1MSamples_testforbinary\';
MemMapFilename = ['F:\Users\Bora\Samraksh\ClockSyncProject\Data\HSI_32Mhz_19BSamples\' 'changes_64bit.bin'];
%MemMapFilename = ['F:\Users\Bora\Samraksh\ClockSyncProject\Data\HSI_32Mhz_1MSamples_testforbinary\' 'datachanges_64bitword.bin'];

%SamplePeriod = 1000;
ChunkSize = 1000000;
freq_clock = (16*10^6); %Freq of the clok in Hz
%% Initialization
LAMemMap = MemoryMapLogicAnalyzerBinaryExportPerChange( MemMapFilename );

%Save Statistics 1M at a time
r = ChunkOperationOnMemoryMapData3(@findExtendedLineFitStats_MM,LAMemMap, ChunkSize );
save('undersampledLineFitStats.mat');
%% Process results to get variance of error for different size linie fits

% numresults = size(r,2);
% 
% lengthofintervals = 1:floor(numresults/10):numresults;
% sall = cell(1,numel(lengthofintervals));
% for lengthofinterval_ind = 1:10;
%     lengthofinterval = lengthofintervals(lengthofinterval_ind);
%     disp(['lengthofinterval = ' num2str(lengthofinterval)]);
%     numberofintervals = ceil(numresults./lengthofinterval);
%     s = nan(1,numberofintervals);
%     for intindex = 1:numberofintervals
%         intbegindex = (intindex-1)*lengthofinterval+1;
%         intendindex = min(intindex*lengthofinterval,numresults);
%  
%         rtotal = r{1,intbegindex};
%         for i = intbegindex+1:intendindex
%             r_cur = r{1,i};
%             for j = 1:size(rtotal,2)
%                 rtotal(1,j) =  rtotal(1,j) + r_cur(1,j);
%             end
%         end
%         %Construct line fit for this interval 
% %             numelements = (curIndexNumbers(end) - curIndexNumbers(1))/2;
% %             %Construct line fit
% %             %y = bx + a
% %             a = ( rtotal{1,5} * rtotal{1,1} - rtotal{1,4}* rtotal{1,3} ) / (numelements*rtotal{1,1} - (rtotal{1,4})^2 );
% %             b = ( numelements * rtotal{1,3} - rtotal{1,4}* rtotal{1,5} ) / (numelements*rtotal{1,1} - (rtotal{1,4})^2 );
% %             p = [b a];
% 
%         % Calculate var of error for this inteval
%         numelements = ((intendindex - intbegindex)+1)*ChunkSize;
%         SSxx = rtotal(1,1) - ((rtotal(1,4))^2)/numelements;
%         SSyy = rtotal(1,2) - ((rtotal(1,5))^2)/numelements;
%         SSxy = rtotal(1,3) - (rtotal(1,4)*rtotal(1,5))/numelements;
%         s(intindex) = ((SSyy - (SSxy^2)/SSxx)/numelements-2 ) ;
% if (isnan( s(intindex)) ||  s(intindex)<0 )
% a=21;
% end
%     end
%     sall{1,lengthofinterval_ind} = s;
%     
% end
% 
% figure();
% axeshandle = gca;
% xlabel('Length of linearization interval');
% ylabel('Variance of Error');
% hold on;
% for sind = 1:numel(sall)-1
%     ss = sall{1,sind};
%     errorbar(lengthofintervals(sind),mean(ss),var(ss));
% end
