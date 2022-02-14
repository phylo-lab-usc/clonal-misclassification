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
}

saveRDS(m1, file="pd1_mega_medusa.RDS")

shifts <- list()
for (i in 1:length(m1)){
shifts[[i]] <- length(unique(m1[[i]]$summary$Shift.Node)) #is this number of families?
}

shifts2 <- list()
descendants <- list()
descendants_shift1 <- list()
equal1 <- list()
for (i in 1:length(m1)){
  shifts2[[i]] <- as.numeric(unique(m1[[i]]$summary$Shift.Node))
  descendants[[i]] <- phangorn::Descendants(m1[[i]]$cache$phy)
  descendants_shift1[[i]] <- descendants[[i]][[shifts2[[i]][1]]]
  equal1[[i]] <- length(descendants_shift1[[i]]) == length(m1[[i]]$cache$phy$tip.label)
  #if TRUE, there is a shift at the root
}

