# Add the following folders to your MATLAB path:

	/SVM_MATLAB_Scripts/Features
	/SVM_MATLAB_Scripts/Features/AcclnBased
	/SVM_MATLAB_Scripts/Features/FftBased
	/SVM_MATLAB_Scripts/Features/PhaseBased
	/SVM_MATLAB_Scripts/Features/VelocityBased
	/SVM_MATLAB_Scripts/MatlabLibrary
	/SVM_MATLAB_Scripts/Scripts
	/SVM_MATLAB_Scripts/Scripts/OSC_PCT_Scripts
	/SVM_MATLAB_Scripts/Scripts/Paper_plots
	/SVM_MATLAB_Scripts/Scripts/Simple
	/SVM_MATLAB_Scripts/Scripts/VisualizeInAfrica
	/SVM_MATLAB_Scripts/Scripts/matlab2weka
	/SVM_MATLAB_Scripts/Scripts/mi
	/SVM_MATLAB_Scripts/Scripts/test
	/SVM_MATLAB_Scripts/Scripts/yaonazoude
	/SVM_MATLAB_Scripts/Haar Features
	/SVM_MATLAB_Scripts/eMote_scripts

# Add the following directories to your MATLAB static Java classpath:

	/home/royd/weka-3-7-13/weka.jar
	/home/royd/wekafiles/packages/LibSVM/LibSVM.jar
	/home/royd/wekafiles/packages/LibSVM/lib/libsvm.jar

The classpath can be edited through the following MATLAB command (need admin rights):

	>> edit classpath.txt

# Create/add your own working directories in /SVM_MATLAB_Scripts/Scripts/SetEnvironment.m. E.g.:

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
	
