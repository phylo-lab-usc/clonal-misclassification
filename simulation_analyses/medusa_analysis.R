## load packages
library(geiger)
library(ape)
library(phytools)
library(gtools)

## load mega trees
temp <- mixedsort(list.files(pattern="*.bestTree"))
trees <- lapply(temp,read.tree)

## exclude trees with less than or equal to 6 tips
trees_edit <- list()

for (i in 1:length(trees)) {
  if (length(trees[[i]]$tip.label)>6)
  {
    trees_edit[[i]]<-trees[[i]]
  }
}  

## new list of trees
trees_edit <- trees_edit[-which(sapply(trees_edit, is.null))]


## run MEDUSA in geiger R package --> tree needs to be at least 7 tips?
tree2 <- list()
tree3 <- list()
m1 <- list()

for (i in 1:length(trees_edit)){
tree2[[i]] <- multi2di(trees_edit[[i]])
tree2[[i]]$edge.length <- tree2[[i]]$edge.length + 0.01
tree3[[i]] <- force.ultrametric(tree2[[i]], method = "extend")
m1[[i]] <- medusa(tree3[[i]]) 
#print(m1[[i]]$summary)
}

saveRDS(m1, file="pd1_mega_medusa.RDS")
