# clonal-misclassification

## Download-data

``tsv_to_fasta.py`` converts iReceptor data into a fasta file

## GMYC

``gmyc_clusters.R`` goes through each step in running the GMYC

``gmyc_mega.R`` runs the GMYC function on the mega trees as a loop

``gmyc_output_formatting.R`` finds the clusters in each tree

## Pseudocode

**part1**
  
``part_1_code.R`` project information

**part2**

``part_2_code.R``project information

## analyze_partis_output

This folder is to partition non-simulated sequences.

``partition_to_fasta.py`` moves each _partis_ partition into a fasta file

``python_partitioning.txt`` instructions on using ``partition_to_fasta.py``  and ``yaml_to_families.py``

``yaml_to_families.py`` converts each yaml file to family files

## analyze_partis_simulation_output

This folder is to partition simulated sequences.

``fasta_per_partition.py`` moves all of the same numbered partitions into a file

``partition_to_fasta.py``  moves each _partis_ partition into a fasta file

``yaml_to_families.py`` converts each yaml file to family files

## germline_search

``find_germline_phangorn.R`` use phangorn for germline sequence search

``germline_search_RevertToGermline`` instructions on using RevertToGermline

## partis

**partis_simulation**

``simulate_partition_steps.txt`` instructions on using partis

## resampling

``resample_families.R`` resample family steps

``resample_families_looped.R`` resample loops to run on all families

## simulation_analyses

This folder corresponds to additional family assignment methods and figures for manuscript:

``ancestral_similarity_figure.R`` figure for different reshuffling levels ancestral sequence similarity

``change-o.sh`` run CHANGE-O

``change-o_analysis.R`` converting CHANGE-O output

``diptest_phylogenetic_distances.R`` calculate phylogenetic distances and distributions

``family_distribution_figure.R`` figure for different methods

``family_distribution_figure_monophyletic_only.R`` figure for different methods on monophyletic families only

``format_families.sh`` steps for data processing

``medusa_analysis.R`` running MEDUSA

``megatree_summary.R`` investigate the trees that are monophyletic

``mixcr.sh`` run MiXCR

``mixcr_analysis.R`` convert MiXCR output

``outputs_trees_5_families.R`` analyzing only monophyletic families

``partis_distribution_output.R`` convert _partis_ output

## tree_building

``ancestral_search_RAxML.txt`` instructions for ancestral sequence search

``build_tree.txt`` instructions for tree building 

``simulations_asr.sh`` ancestral sequence search on simulated data

``simulations_build_family_trees.sh`` family level tree building for simulated data

``simulations_build_mega_trees.sh`` mega tree building for simulated data
