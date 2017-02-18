%THIS ILLUSTRATES HOW TO RECONNECT TO A SESSION OR JOB. IT IS USEFUL AFTER
%CLOSING AND RESTARTING MATLAB, AFTER CLEARING THE WORKSPACE, AND AFTER
%OVERWRITING THE VALUE OF A JOB OBJECT.

%This script should be run in your MATLAB client session. Do NOT
%submit it to the cluster using the batch command. You may wish to just
%copy lines out of this script and paste them into your MATLAB command
%window instead of running the entire script.

%Reinitialize the cluster object using the same profile as before
intelCluster = parcluster('genericNonSharedOakleyIntel_R2014b');

%Show all jobs
jobs = intelCluster.Jobs;
disp(jobs);
%Select the job you are interested in and note the ID
matlabJobIndex = 1;
%Get the job object
jobObject = intelCluster.Jobs(matlabJobIndex);
%Get the OSC job ID
oscJobID = intelCluster.getJobClusterData(jobObject).ClusterJobIDs{1};
disp(oscJobID);
%Check the job status
job_status = jobObject.State;
disp(job_status);

%See also client_session_script.m
