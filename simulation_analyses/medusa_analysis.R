## load packages
library(geiger)
library(ape)
library(phytools)
library(gtools)

temp <- mixedsort(list.files(pattern="*.bestTree"))
trees <- lapply(temp,read.tree)

## empty lists
tree2 <- list()
tree3 <- list()
m1 <- list()

## run MEDUSA in geiger R package
for (i in 1:length(trees)){
tree2[[i]] <- multi2di(trees[[i]])
tree2[[i]]$edge.length <- tree2[[i]]$edge.length + 0.01
tree3[[i]] <- phytools::force.ultrametric(tree2[[i]], method = "extend")
m1[[i]] <- medusa(tree3[[i]]) 
#print(m1[[i]]$summary)
}

