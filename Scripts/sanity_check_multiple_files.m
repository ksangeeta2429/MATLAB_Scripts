%{
	Given multiple detect_begs and detect_end files corresponding to different combinations of threshold, adjustmentParameter and window size,
	genearte times__radar.csv for all datasets.	
%}


SetEnvironment;
SetPath;

%t = [1,2,3,4,5]; %thresholds
t = 22;
%t = 4;
%t = [9];
%t = [23,24,25,26,27,28,29,30];
%t = [13,14,15,16,17,18,19,20,21];
%adj = [0.5];
%adj = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5,1.55,1.6,1.65,1.7,1.75,1.8,1.85,1.9,1.95,2,2.1, 2.15, 2.2, 2.25, 2.3, 2.35, 2.4, 2.45,2.5, 2.55, 2.6, 2.65, 2.7, 2.75, 2.8, 2.85, 2.9, 2.95, 3]; %adjustment parameters
%adj = 19;
%adj = 10;
%adj = [0.4,0.45,0.5,0.55,0.6,0.7,0.75,0.8,0.85,0.9,0.95,1,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5,1.55,1.6,1.65,1.7,1.75,1.8,1.85,1.9,1.95,2,2.1, 2.15, 2.2, 2.25, 2.3, 2.35, 2.4, 2.45, 2.5, 2.55, 2.6, 2.65, 2.7, 2.75, 2.8, 2.85, 2.9, 2.95, 3];
adj = [19];
w = [1]; %windows

%start_hrs = 16; start_minutes = 51; start_seconds = 20; %start time of the radar for one particular raw file
start_hrs = 0; start_minutes = 0; start_seconds = 0;
%dates = {'Aug 13 2018','20180815','20180814','Sept 26 2018','Aug 31 2018','Sept 4 2018','Sept 5 2018','Sept 12 2018','Aug 19 2018'}; 
dates = {'Aug 13 2018'};
c = {'c3'};
radars = {'aus','aus2','a16','a15','a17'};
ofile_version = '_bora_det_win_N_128';

for date = dates
date = char(date);
for radar = radars
    radar = char(radar);
    r = strcat(radar,'');
    for coll = c
        coll = char(coll);
        parent_path = strcat('/Bike data/',date,'/Detect_begs_and_ends/',coll,'/'); %the prefix to this path is set using setEnvironment and setPath in sanityCheck.m
        if exist(strcat(g_str_pathbase_data,'/Bike data/',date,'/',radar,'_',coll,'.bbs'),'file') ~= 2
            continue;
        end
        %fprintf('Date : %s   Coll : %s  Radar : %s',date,coll,radar);
        for window = w
            for threshold = t
                for adjustmentParameter = adj 
                    disp(strcat(date,' Radar : ',radar,' Collection : ',coll));
                    fprintf('Window : %d   Threshold : %d  Adj : %f\n',window,threshold,adjustmentParameter);
                    %collection = strcat('w',string(window),'/t',string(threshold),'/param',string(adjustmentParameter),'/',radar,'/');
                    collection = strcat('t',string(threshold),'/bgr',string(adjustmentParameter),'/',radar,'/');
                    detect_begs = strcat(parent_path,collection,'detect_beginnings__',r,ofile_version);
                    detect_ends = strcat(parent_path,collection,'detect_ends__',r,ofile_version);
                    output_file = strcat(parent_path,collection,'times__',radar,ofile_version);
                    sanityCheck(start_hrs,start_minutes,start_seconds,detect_begs,detect_ends,output_file,window);
                end
            end
        end
    end
end
end