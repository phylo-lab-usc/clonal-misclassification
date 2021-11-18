## load packages
require("splits")
require("ape")

## load phylogeny
phy <- read.tree(file="file_name")

## run gmyc function
t1 <- gmyc(phy)

## summarize cluster information
summary.gmyc(t1)
#plot.gmyc(t1)

## extract species information per cluster
t2 <- spec.list(t1)

## split into each cluster
t3 <- split(t2, t2$GMYC_spec)

## loop to split the original phylogeny into phylogenies of each cluster
# empty list
phy_split <- list()

for (i in 1:length(t3)) {
  phy_sp <- keep.tip(phy, as.vector(t3[[i]]$sample_name))
  phy_split[[i]] <- phy_sp
}

## save all phylogenies 
saveRDS(phy_split, "gmyc_clades.rds")

## save each phylogeny as a separate file (.txt and .tree)
index <- 0 
for(i in 1:length(phy_split)){
  index <- index +1
  output_fn <- paste0("tree_",  index, ".txt") #making unique file name
  write.nexus(phy_split[[i]],file = output_fn )
}

index <- 0 
for(i in 1:length(phy_split)){
  index <- index +1
  output_fn <- paste0("tree_",  index, ".tree") #making unique file name
  write.nexus(phy_split[[i]],file = output_fn )
}
