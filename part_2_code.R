##Pseudocode for Part 2 of Clonal Misclassification
##Authors: Katrina Kaur & Rituparna Banerjee

#####Part 2#####
# Are there phylogenetic methods to assign B-Cell clones to clades, 
# do they perform better than similarity based metrics?

# 1. Align the entire B-cell repertoire (MiXCR/MUSCLE/MAFFT/Clustal)

# 2. Build a megatree of all of the clones (RAxML/IQTree/FastTree)

# 3. Split the megatree into clonal groups (GMYC/RevertToGermline/Clonify)

# 4. Re-align the clonal groups (same method as step 1)

# 5. Build trees for each clonal group (same method as step 2)

# 6. Investigate:
  # ancestral states / germline sequences (GMYC/Revert to Germline)
  # to find the ancestral clone use PAUP/Phangorn/Castor/RAxML/IQTree
  # use both the tips and the ancestral clone to find the germline
  # ancestor (VDJ genes)

# 7. Compare to Part 1 - do phylogenetic methods perform better than 
# similarity based methods from part 1 in determining what the ancestral clone
# and germline sequence(s) are?


