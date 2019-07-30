#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2-0
#SBATCH --mem=16GB
#SBATCH --job-name=genFreqPhaseCNN_train_pedbike
#SBATCH --mail-type=ALL
#SBATCH --output=genFreqPhaseCNN_train_pedbike_%j.out
  
module purge
module load matlab/2017b

if [ "$SLURM_JOBTMP" == "" ]; then
    export SLURM_JOBTMP=/state/partition1/$USER/$$
    mkdir -p $SLURM_JOBTMP
fi

export MATLAB_PREFDIR=$(mktemp -d $SLURM_JOBTMP/matlab-XXXXXX)

RUNDIR=$SCRATCH/MATLAB_Scripts/Scripts
cd $RUNDIR

echo "Job starts: $(date)"
echo "Hostname: $(hostname)"

cat<<EOF | matlab -nodisplay -nodesktop
try
   genFreqPhaseData_train
catch err
    fprintf('\n\nTime: %s\n', datestr(datetime('now')));
    fprintf('Matlab error: %s\n', err.message);
    exit(1);
end
EOF

matlab_status=$?
echo "Job ends: $(date)"
rm -rf $MATLAB_PREFDIR
exit $matlab_status
