%{
	Given multiple detect_begs and detect_end files corresponding to different combinations of threshold, adjustmentParameter and window size,
	genearte times__radar.csv for all	
%}


t = [1,2,3,4,5]; %thresholds
%t = [5,6,7,8,9,10];
%t = [13,14,15,16,17,18];
%t = [16];
%adj = [2.5];
adj = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5,1.55,1.6,1.65,1.7,1.75,1.8,1.85,1.9,1.95,2,2.1, 2.15, 2.2, 2.25, 2.3, 2.35, 2.4, 2.45,2.5, 2.55, 2.6, 2.65, 2.7, 2.75, 2.8, 2.85, 2.9, 2.95, 3]; %adjustment parameters
%adj = [0.4,0.45,0.5,0.55,0.6,0.7,0.75,0.8,0.85,0.9,0.95,1,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5,1.55,1.6,1.65,1.7,1.75,1.8,1.85,1.9,1.95,2,2.1, 2.15, 2.2, 2.25, 2.3, 2.35, 2.4, 2.45, 2.5, 2.55, 2.6, 2.65, 2.7, 2.75, 2.8, 2.85, 2.9, 2.95, 3];
%adj = [0.65];
w = [1]; %windows

%start_hrs = 16; start_minutes = 51; start_seconds = 20; %start time of the radar for one particular raw file
start_hrs = 0; start_minutes = 0; start_seconds = 0;
date = 'June 3 2018';
parent_path = strcat('/Bike data/',date,'/Detect_begs_and_ends/c1_s_low/'); %the prefix to this path is set using setEnvironment and setPath in sanityCheck.m

radar = "r1"; r = strcat(radar,"_z");

for window = w
	for threshold = t
		for adjustmentParameter = adj 
            disp(strcat(date,' Radar : ',radar));
            fprintf('Window : %d   Threshold : %d  Adj : %f\n',window,threshold,adjustmentParameter);
			collection = strcat('w',string(window),'/t',string(threshold),'/param',string(adjustmentParameter),'/',radar,'/');
			detect_begs = strcat(parent_path,collection,'detect_beginnings__',r);
			detect_ends = strcat(parent_path,collection,'detect_ends__',r);
			output_file = strcat(parent_path,collection,'times__',r);
			sanityCheck(start_hrs,start_minutes,start_seconds,detect_begs,detect_ends,output_file,window);
		end
	end
end