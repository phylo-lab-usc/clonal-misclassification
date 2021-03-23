##Pseudocode for Part 1 of Clonal Misclassification
##Authors: Katrina Kaur & Rituparna Banerjee

#####Part 1#####
# What is the effect of clonal misclassification on how 
# sensitive diversification, SHM, and ancestral state reconstruction analyses are?

# 1. Download B-cell repertoires from iReceptor

# 2. Group B-cell clones into clusters using partis/clonify/BRILIA
  # (these programs are lineage assignment methods)
  # Potentially also use alignment based methods to group clones
  # into clusters?

# 3. Build a phylogeny for each cluster
  # potentially the clustering methods may also include trees
  # other methods include FastTREE, IQTree, RAxML

# 4. Investigate:
  # diversification rates and if rates change over branches (BEAST)
  # SHM rates (partis/BRILIA ?)
  # ancestral states / germline sequences (GMYC/Revert to Germline)

# **5. Reshuffle the nodes at a certain rate (try several rates)
  # During step 2?
  # After reshuffling clones into different clusters, is alignment
  # required for each new cluster?

# 6. Build a new phylogeny of each cluster
  # same methods from step 3

# 7. Compare the original trees to reshuffled trees
  # Tree-likeness to compare trees

