#!/bin/bash
#SBATCH --account=def-mpennell   # replace this with your own account
#SBATCH --ntasks=1               # number of processes
#SBATCH --mem-per-cpu=10000       # memory; default unit is megabytes
#SBATCH --time=00-23:59        # time (DD-HH:MM)
#SBATCH --mail-user=kaur@zoology.ubc.ca # Send email updates to you or someone else
#SBATCH --mail-type=ALL          # send an email in all cases (job started, job ended, job aborted)
#SBATCH --job-name=CHANGE-O

module load python
source ~/my_venv/bin/activate
python -c "import changeo"

MakeDb.py imgt -i mega_1.txz -s all_fasta_1.fasta --extended
DefineClones.py -d mega_1_db-pass.tsv

MakeDb.py imgt -i mega_2.txz -s all_fasta_2.fasta --extended
DefineClones.py -d mega_2_db-pass.tsv

MakeDb.py imgt -i mega_3.txz -s all_fasta_3.fasta --extended
DefineClones.py -d mega_3_db-pass.tsv

MakeDb.py imgt -i mega_4.txz -s all_fasta_4.fasta --extended
DefineClones.py -d mega_4_db-pass.tsv

