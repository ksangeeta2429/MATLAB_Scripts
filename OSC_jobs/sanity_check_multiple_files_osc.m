%{
	Given multiple detect_begs and detect_end files corresponding to different combinations of threshold, adjustmentParameter and window size,
	genearte times__radar.csv for all datasets.	
%}


addpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts'));
rmpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/Radar/Jin'));
rmpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts/STC/'));
rmpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts/Deconv-Matlab/'));

%SetEnvironment;
%SetPath;

prefix = '/users/PAS1090/osu10640/box.com/Data_Repository/';
t = [10:50];
adj = [0:0.05:2];
w = [1]; %windows

start_hrs = 0; start_minutes = 0; start_seconds = 0;
%dates = {'Aug 13 2018','20180815','20180814','Sept 26 2018','Aug 31 2018','Sept 4 2018','Sept 5 2018','Sept 12 2018','Aug 19 2018'}; 
dates = {'June 3 2018','June 17 2018','May 30 2018'};
c = {'c1','c2'};
%radars = {'aus','aus2','a16','a15','a17'};
radars = {'r1','r2','r3'};

ofile_version = '_bora_det_win_N_125';

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
                    collection = strcat('t',string(threshold),'/adj',string(adjustmentParameter),'/',radar,'/');
                    detect_begs = strcat(parent_path,collection,'detect_beginnings__',r,ofile_version);
                    detect_ends = strcat(parent_path,collection,'detect_ends__',r,ofile_version);
                    output_file = strcat(parent_path,collection,'times__',radar,ofile_version);
                    sanityCheckOSC(start_hrs,start_minutes,start_seconds,detect_begs,detect_ends,output_file,window,prefix);
                end
            end
        end
    end
end
end
quit();