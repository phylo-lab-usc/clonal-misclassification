require(ape)
require(phytools)
require(splits)
require(gtools)

temp <- mixedsort(list.files(pattern="*.bestTree"))
trees <- lapply(temp,read.tree)

bin <- list()
for (i in 1:250){
  bin[[i]] <- multi2di(trees[[i]])
}

for (i in 1:250){
  bin[[i]]$edge.length <- bin[[i]]$edge.length+0.01
}

tree_edit <- list()
for (i in 1:250){
  tree_edit[[i]] <- force.ultrametric(bin[[i]], method = "extend")
}

t1 <- list()
for (i in 1:250){
  t1[[i]] <- gmyc(tree_edit[[i]])
}

saveRDS(t1, "gmyc_output_megatrees.rds")

