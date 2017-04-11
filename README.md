# Add the following folders to your MATLAB path:

	/MATLAB_Scripts/Features
	/MATLAB_Scripts/Features/AcclnBased
	/MATLAB_Scripts/Features/FftBased
	/MATLAB_Scripts/Features/PhaseBased
	/MATLAB_Scripts/Features/VelocityBased
	/MATLAB_Scripts/MatlabLibrary
	/MATLAB_Scripts/Scripts
	/MATLAB_Scripts/Scripts/OSC_PCT_Scripts
	/MATLAB_Scripts/Scripts/Paper_plots
	/MATLAB_Scripts/Scripts/Simple
	/MATLAB_Scripts/Scripts/VisualizeInAfrica
	/MATLAB_Scripts/Scripts/matlab2weka
	/MATLAB_Scripts/Scripts/mi
	/MATLAB_Scripts/Scripts/test
	/MATLAB_Scripts/Scripts/yaonazoude
	/MATLAB_Scripts/Haar Features
	/MATLAB_Scripts/eMote_scripts
	/MATLAB_Scripts/Library/UserExtensions
	/MATLAB_Scripts/Library/Products
	/MATLAB_Scripts/Library/Products/BubleBee Design
	/MATLAB_Scripts/Library/Products/BumbleBee Tests
	/MATLAB_Scripts/Library/Products/BumbleBee Tests/Tests
	/MATLAB_Scripts/Library/MatLab
	/MATLAB_Scripts/Library/MatLab/NewFolder1
	/MATLAB_Scripts/Library/MatLab/NewFolder2
	/MATLAB_Scripts/Library/MatLab/NumAnal
	/MATLAB_Scripts/Library/MatLab/SigPro
	/MATLAB_Scripts/Library/MatLab/Tests
	/MATLAB_Scripts/Library/MatLab/Visualization
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/ClockAnalyzer
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/LinkDetection
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/LinkDetection/WriteUp
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/Microphone
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/Radar
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/Radar/Jin
	/MATLAB_Scripts/Library/Data Collection/MatLab Scripts/Radar/Nived

# Add the following JAR_files to your MATLAB static Java classpath:

	/MATLAB_Scripts/JAR_files/weka.jar
	/MATLAB_Scripts/JAR_files/LibSVM/LibSVM.jar
	/MATLAB_Scripts/JAR_files/libsvm.jar
	/MATLAB_Scripts/JAR_files/InfoTheoreticRanking_1.7.jar

Follow these instructions for setting the static Java classpath: https://www.mathworks.com/help/matlab/matlab_external/static-path.html#bvjg_eg-3.
DO NOT edit classpath.txt directly, as I encountered an issue with finding the appropriate packages on Ubuntu.

# Create/add your own working directories in /MATLAB_Scripts/Scripts/SetEnvironment.m, e.g.:

	str_pathbase_radar_dhrubo_Ubuntu = '/home/royd/Box Sync/All_programs_data_IPSN_2016/Simulation/toDhruboMichael';
	str_pathbase_data_dhrubo_Ubuntu = '/home/royd/Box Sync/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository';
	str_pathbase_model_dhrubo_Ubuntu = '/home/royd/Box Sync/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/IIITDemo/Models/royd';
	
	%% assign path roots to global variables.
	...
	elseif strcmp(getenv('USER'),'royd'      )==1
	    g_str_pathbase_radar = str_pathbase_radar_dhrubo_Ubuntu;
	    g_str_pathbase_data  = str_pathbase_data_dhrubo_Ubuntu;
	    g_str_pathbase_model = str_pathbase_model_dhrubo_Ubuntu;
	...

# Using dd and MATLAB to visualize raw radar data

1. Exfiltration from SD card (88X LCD reading) 
 
	sudo su 
	diskutil list       (fdisk -l on Ubuntu, cat /proc/partitions on Cygwin) 
	dd if=/dev/disk1 of=./Desktop/Great_Fish_Data_Collect/Nov_26_Lodge/March_4_noise.bbs bs=512 skip=1 count=1188

2. Visualization on MATLAB

	i)  Read generated .bbs file

		Comp = ReadRadar('March_4_noise.bbs'); [preferred]

	or,

		Comp = ReadRadarMedianTrack('March_4_noise.bbs',256,30);

	ii) Visualize on MATLAB

		BatchNoiseProd(Comp, 256, 'Dhrubo Test'); [preferred]
		
	or,

		ParameterAnalysis(Comp,256,'test',7,45,2,3,1);

	 where 7, 45, 2, 3, 1 respectively stand for the threshold, IQ rejection, m, n, and window length.

3. Zero-out SD card. CAREFUL!!! Writing zeros

	dd if=/dev/zero of=/dev/disk1 bs=1M count=20
