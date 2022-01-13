##extract gmyc distributions from gmyc output

require(ape)
require(phytools)
require(splits)
require(gtools)
require(dplyr)

t1 <- readRDS("gmyc_output_megatrees.rds")

## extract species information per cluster
## split into each cluster
t2 <- list()
t3 <- list()

for(i in 1:length(t1)){
  t2[[i]] <- spec.list(t1[[i]])
  t3[[i]] <- split(t2[[i]], t2[[i]]$GMYC_spec)
}

t4 <- list()
for(i in 1:length(t3)){
  t4[[i]] <- do.call(rbind.data.frame, t3[[i]])
}

t5 <- list()
for(i in 1:length(t4)){
  t5[[i]] <- t4[[i]] %>% count(GMYC_spec) 
}

saveRDS(t5, "gmyc_pd1_size_distribution.rds")
