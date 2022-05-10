#!/bin/bash
#SBATCH --account=                # replace this with your own account
#SBATCH --mem-per-cpu=            # memory; default unit is megabytes
#SBATCH --time=                   # time (DD-HH:MM)
#SBATCH --array=1-5000
#SBATCH --job-name=mega_loop

module load StdEnv/2016.4
module load nixpkgs/16.09
module load gcc/7.3.0
module load openmpi/3.1.4
module load raxml-ng/0.9.0

# after STEP 1: tree building
# search for the naive sequence

for i in "$SLURM_ARRAY_TASK_ID"*.fasta
do
echo $i
done

##### STEP 2: find ancestral sequence ###
 #--ancestral finds the ancestral sequences of each node
 #--msa use the same alignment from the tree building
 #--tree use the bestTree file from the tree search
raxml-ng-mpi --ancestral --msa $i --tree $i.raxml.bestTree --model GTR --prefix $i
