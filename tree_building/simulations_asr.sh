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

for i in "$SLURM_ARRAY_TASK_ID"*.fasta
do
echo $i
done

raxml-ng-mpi --ancestral --msa $i --tree $i.raxml.bestTree --model GTR --prefix $i


