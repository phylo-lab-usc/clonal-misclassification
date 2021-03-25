##Pseudocode for Part 1 of Clonal Misclassification
##Authors: Katrina Kaur & Rituparna Banerjee

#####Part 1#####
# What is the effect of clonal misclassification on how 
# sensitive diversification, SHM, and ancestral state reconstruction analyses are?

# 1. Download B-cell repertoires from iReceptor / OR simulate data
# using partis 

# 2. Group B-cell clones into clusters using partis/clonify
  # these programs are lineage assignment methods

# 3. Method A - Germline: Using "tips" (clones) to find the germline
  # Give output of partis/clonify to IMGT for example to find the VDJ regions
  # Give output of IMGT to RevertToGermline to find the germline sequences

# 4. Build a phylogeny for each cluster
  # the clustering methods may also include tree building
  # other methods include FastTREE, IQTree, RAxML

# 5. Investigate: use phylogeny in the following - 
  # diversification rates and if rates change over branches (BEAST)
  # SHM rates (partis/BRILIA ?)

# 6. Method B - Germline: Using "ancestor" (ancestral clone) to find germline
    # use the phylogeny to find the ancestral clone using:
    # PAUP/Phangorn/Castor/RAxML/IQTree
    # give ancestral clones to IMGT/RevertToGermline to find germline sequences

# 6. Reshuffle the nodes at a certain rate (try several rates)
  # during step 2 use different rates to reshuffle the clones
  # reshuffle clones into different clusters
  # re-align the reshuffled clonal groups (assuming each cluster shares
  # an ancestor)

# 7. Repeat steps 3-5 on the resuffled clonal groups

# 8. Compare the original trees to reshuffled trees
  # Tree-likeness to compare trees
  # Are the diversification rates, SHM rates, and ancestral states
  # sensitive to the reshuffling method?
  # Compare Method A and B on the original and reshuffled trees



