##Pseudocode for Part 1 of Clonal Misclassification
##Authors: Katrina Kaur & Rituparna Banerjee

#####Part 1#####
# What is the effect of clonal misclassification on how 
# sensitive diversification, SHM, and ancestral state reconstruction analyses are?

# 1. Download B-cell repertoires from iReceptor / OR simulate data
# using partis 

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
    # to find the ancestral clone use PAUP/Phangorn/Castor/RAxML/IQTree
    # use both the tips and the ancestral clone to find the germline
    # ancestor (VDJ genes)

# **5. Reshuffle the nodes at a certain rate (try several rates)
  # During step 2?
  # reshuffle clones into different clusters
  # re-align the reshuffled clonal groups (assuming each cluster shares
  # an ancestor)

# 6. Build a new phylogeny of each cluster
  # same methods from step 3 and step 4

# 7. Compare the original trees to reshuffled trees
  # Tree-likeness to compare trees
  # Are the diversification rates, SHM rates, and ancestral states
  # sensitive to the reshuffling method?



