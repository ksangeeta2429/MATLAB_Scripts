%{
    This script is written by neel to invoke CutFile_Manual_RadarAlgorithmGraph_multiple_datasets.m for multiple datasets.
    Requires all datasets to be stored under Data Repository. Follows a particular path structure.
    Use dates to name the folders containing .bbs files. Name .bbs files as radarName_collection Ex: a16_c1.bbs
%}

SetEnvironment;
SetPath;

%austere FPGA datasets
dates = {'Aug 13 2018','20180815','20180814','Sept 26 2018','Aug 31 2018','Sept 4 2018','Sept 5 2018','Sept 12 2018','Aug 19 2018'};
dates = {'Aug 13 2018'};
c = {'c1'};
radars = {'aus','aus2','a16','a15','a17'};
CUT_USING_SAMPLE_INDEXES = 1;
ifile_version = '_bora_det_window_res';
indexFile_version = '_bora_det_window_res_index';
ths = [22];
adjs = [19];
sampRate = 256;
min_cut_length = 0;
cutoff_halfsecs = 999999;

for date = dates
    date = char(date);
    for radar = radars
        radar = char(radar);
        for coll = c
            coll = char(coll);
            if exist(strcat(g_str_pathbase_data,'/Bike data/',date,'/',radar,'_',coll,'.bbs'),'file') ~= 2
                continue;
            end
            fprintf('Date : %s  Radar : %s  coll : %s\n',date,radar,coll);
            for th = ths
                th = num2str(th);
                for adj = adjs
                    adj = num2str(adj);
                    output_folder = strcat('Detect_begs_and_ends/',coll,'/t',th,'/bgr',adj,'/',radar,'/cut')
                    r = strcat(radar,'');
                    f = strcat(g_str_pathbase_data,'/Bike data/',date,'/',radar,'_',coll,'.bbs');
                    %wb = strcat('C:/Users/neel/Downloads/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/',date,'/Detect_begs_and_ends/',coll,'/w1/t',th,'/param',adj,'/',radar,'/detect_beginnings__',r,ifile_version);
                    %we = strcat('C:/Users/neel/Downloads/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/',date,'/Detect_begs_and_ends/',coll,'/w1/t',th,'/param',adj,'/',radar,'/detect_ends__',r,ifile_version);
                    if(CUT_USING_SAMPLE_INDEXES == 0)
                        wb = strcat(g_str_pathbase_data,'/Bike data/',date,'/Detect_begs_and_ends/',coll,'/t',th,'/bgr',adj,'/',radar,'/detect_beginnings__',r,ifile_version);
                        we = strcat(g_str_pathbase_data,'/Bike data/',date,'/Detect_begs_and_ends/',coll,'/t',th,'/bgr',adj,'/',radar,'/detect_ends__',r,ifile_version);
                        CutFile_Manual_RadarAlgorithmGraph(f,wb,we,min_cut_length,cutoff_halfsecs,date,sampRate,output_folder)
                    else
                        wb = strcat(g_str_pathbase_data,'/Bike data/',date,'/Detect_begs_and_ends/',coll,'/t',th,'/bgr',adj,'/',radar,'/detect_beginnings__',r,indexFile_version);
                        we = strcat(g_str_pathbase_data,'/Bike data/',date,'/Detect_begs_and_ends/',coll,'/t',th,'/bgr',adj,'/',radar,'/detect_ends__',r,indexFile_version);
                        CutFile_Manual_From_Sample_Index(f,wb,we,date,output_folder)
                    end
                end
            end
        end
    end
end
