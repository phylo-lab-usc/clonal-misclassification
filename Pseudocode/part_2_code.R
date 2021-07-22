##Pseudocode for Part 2 of Clonal Misclassification
##Authors: Katrina Kaur & Rituparna Banerjee

#####Part 2#####
# Are there phylogenetic methods to assign B-Cell clones to clades, 
# do they perform better than similarity based metrics?

# 1. Align the entire B-cell repertoire (MiXCR/MUSCLE/MAFFT/Clustal)

# 2. Build a megatree of all of the clones (RAxML/IQTree/FastTree)

# 3. Split the megatree into clonal groups (GMYC)

# 4. Re-align the clonal groups (same method as step 1)

# 5. Build trees for each clonal group (same method as step 2)

# 6. Method A - Germline: Using "tips" (clones) to find the germline (similar to part 1)
  # Give the trees of the clonal groups to IMGT for example to find the VDJ regions
  # Give output of IMGT to RevertToGermline to find the germline sequences
  # one clonal group at a time

# 7. Method B - Germline: Using "ancestor" (ancestral clone) to find germline (similar to part 1)
  # use the phylogeny to find the ancestral clone using:
  # Phangorn/RAxML/IQTree/ IMGT / IgBlast / iHMMune-align / MIXCR
  # give ancestral clones to IMGT/RevertToGermline to find germline sequences

#8. Compare Method A (clones) to method B (ancestor) on the set of trees (from part 2 only)

#9. After part 1 and part 2 are complete: 
  # Compare Method A from part 2 to method A from part 1 original
  # Compare method B from part 2 to method B from part 1 original



