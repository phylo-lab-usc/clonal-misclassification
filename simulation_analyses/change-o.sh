#!/bin/bash
#SBATCH --account=             # replace this with your own account
#SBATCH --ntasks=              # number of processes
#SBATCH --mem-per-cpu=         # memory; default unit is megabytes
#SBATCH --time=                # time (DD-HH:MM)
#SBATCH --job-name=            # name

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

