## Step 1: use yaml_to_families.py to get partitions.txt that all 5 families in one file,
## and get naive.txt that has all 5 families' naive sequences in one file
for i in $(seq 1 250);do echo "$i.yaml"; python yaml_to_families.py $i.yaml $i.sim.partitions.txt $i.sim.naive.txt ; done

## Step 2: convert partitions.txt file to fasta format per simulation (stil includes all 5 families)
for i in $(seq 1 250);do echo "$i.sim.partitions.txt"; python partition_to_fasta.py $i.sim.partitions.txt $i.sim.fasta ; done

## Step 3: convert fasta file that has all families into 5 files, 
## where each file contains all family #1 for the simulations, 
## all family #2 for the simulations etc called partition_# files
for i in $(seq 1 250);do echo "$i.sim.fasta"; python fasta_per_partition.py $i.sim.fasta ; done

## Step 4: convert partition file which includes the sequences for specific family number into separate files
## output is each file is 1 family from 1 simulation (total 250 simulations x 5 families = 1,000 files)
## Step 5: rename the sequences within each file to also contain the family number and rename the files to be numbered
## Step 6: join all the families to later reshuffle and align in MAAFT

# partition #1
awk -v RS= '{print > ("sim" NR ".fasta")}' partition_1? #move output of these into a folder, in that folder run the next commands
for sim in *; do mv $sim family1_$sim; done 
for i in $(seq 1 250); do echo family1_sim"$i.fasta"; awk '/>/{sub(">","&"FILENAME"_");sub(/\.fasta/,x)}1' family1_sim$i.fasta > named/fam1_sim$i.fasta ; done 
n=1
for i in *.fasta; do mv $i ${n}_${i}; ((n++)); done
cat *fasta > pd1_correct_sized_families_together.fasta
mafft  --retree 2 --reorder pd1_correct_sized_families_together.fasta > aligned_pd1_correct_sized_families_together.fasta

# partition #2
awk -v RS= '{print > ("sim" NR ".fasta")}' partition_2? #move output of these into a folder, in that folder run the next commands
for sim in *; do mv $sim family2_$sim; done
for i in $(seq 1 250); do echo family2_sim"$i.fasta"; awk '/>/{sub(">","&"FILENAME"_");sub(/\.fasta/,x)}1' family2_sim$i.fasta > named/fam2_sim$i.fasta ; done 
n=1
for i in *.fasta; do mv $i ${n}_${i}; ((n++)); done
cat *fasta > pd2_correct_sized_families_together.fasta
mafft  --retree 2 --reorder pd2_correct_sized_families_together.fasta > aligned_pd2_correct_sized_families_together.fasta

# partition #3
awk -v RS= '{print > ("sim" NR ".fasta")}' partition_3?#move output of these into a folder, in that folder run the next commands
for sim in *; do mv $sim family3_$sim; done 
for i in $(seq 1 250); do echo family3_sim"$i.fasta"; awk '/>/{sub(">","&"FILENAME"_");sub(/\.fasta/,x)}1' family3_sim$i.fasta > named/fam3_sim$i.fasta ; done 
n=1
for i in *.fasta; do mv $i ${n}_${i}; ((n++)); done
cat *fasta > pd3_correct_sized_families_together.fasta
mafft  --retree 2 --reorder pd3_correct_sized_families_together.fasta > aligned_pd3_correct_sized_families_together.fasta

# partition #4
awk -v RS= '{print > ("sim" NR ".fasta")}' partition_4? #move output of these into a folder, in that folder run the next commands
for sim in *; do mv $sim family4_$sim; done 
for i in $(seq 1 250); do echo family4_sim"$i.fasta"; awk '/>/{sub(">","&"FILENAME"_");sub(/\.fasta/,x)}1' family4_sim$i.fasta > named/fam4_sim$i.fasta ; done 
n=1
for i in *.fasta; do mv $i ${n}_${i}; ((n++)); done
cat *fasta > pd4_correct_sized_families_together.fasta
mafft  --retree 2 --reorder pd4_correct_sized_families_together.fasta > aligned_pd4_correct_sized_families_together.fasta

# partition #5
awk -v RS= '{print > ("sim" NR ".fasta")}' partition_5? #move output of these into a folder, in that folder run the next commands
for sim in *; do mv $sim family5_$sim; done 
for i in $(seq 1 250); do echo family5_sim"$i.fasta"; awk '/>/{sub(">","&"FILENAME"_");sub(/\.fasta/,x)}1' family5_sim$i.fasta > named/fam5_sim$i.fasta ; done 
n=1
for i in *.fasta; do mv $i ${n}_${i}; ((n++)); done
cat *fasta > pd5_correct_sized_families_together.fasta
mafft  --retree 2 --reorder pd5_correct_sized_families_together.fasta > aligned_pd5_correct_sized_families_together.fasta

## separated fasta files are used to build trees
## aligned files are input into the resample_families_looped.R file


## Step 7: move outputs of renamed sequences within fasta commands into one folder and run
## the following to concatentate sequences for all 5 familes per simulation for megatree
## total is 250 files for 250 simulations per parameter directory
for i in $(seq 1 250); do echo *sim"$i.fasta"; cat *sim$i.fasta > cat_megatree_sim$i.fasta; done

## Step 8: align concatenated files in MAAFT for each parameter directory
for i in $(seq 1 250); do echo cat_megatree_sim$i.fasta;
mafft  --retree 2 --reorder cat_megatree_sim$i.fasta > aligned_cat_megatree_sim$i.fasta; done

## Step 9: to ensure that the correct sequences will be compared for sequence similarity, 
# and the correct trees will be compared for phylogenetic distances, rename for each parameter directory
for f in *bestTree; do mv "$f" "${f/*_f/f}"; done
n=0
n=1
for i in *.bestTree; do mv $i ${n}_${i}; ((n++)); done

for f in *States; do mv "$f" "${f/*_f/f}"; done
n=0
n=1
for i in *States; do mv $i ${n}_${i}; ((n++)); done

## Step 10: move all naive sequences into one file
for i in $(seq 1 250);do echo "$i.sim.naive.txt"; python partition_to_fasta.py $i.sim.naive.txt $i.sim.fasta ; done 
  # naive.txt files are from Step 1
for i in $(seq 1 250);do echo "$i.sim.fasta"; python fasta_per_partition.py $i.sim.fasta ; done
  # rename outputs to partition_number_naive.txt
  
## Step 11: after tree building and after ASR is reconstructed
## get outputs of root ASR sequence, run this for all resampled outputs
for i in *.fasta.raxml.ancestralStates; do  sed '/^N/ s/./>&/' $i > $i.txt; done
for i in *.fasta.raxml.ancestralStates.txt; do  sed '/>/h; //,$ { //!H; }; $!d; x' $i > $i.txt; done
cat *txt.txt > root_naive.txt #all together
ls *txt.txt > list.txt #file list

