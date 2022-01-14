## dip.test for phylogenetic distances to assess unimodality
## outputs for different levels of resampling are in a separate folder

library(tidyr)
library(ape)
library(phytools)
library(ggplot2)
require(gtools)
library(diptest)

## load original trees
temp <- mixedsort(list.files(pattern=".*bestTree"))
tree0 <- lapply(temp,read.tree)

## calculate pd
cp0s <- list()
cp02s <- list()
for (i in 1:length(temp)) {
  cp0 <- as.data.frame(ape::cophenetic.phylo(tree0[[i]]))
  cp0s[[i]] <- cp0
  cp02 <- tidyr::gather(cp0s[[i]], cols, value)
  cp02s[[i]] <- cp02
  cp02s[[i]]$group <- "0%"
  cp02s[[i]] <- cp02s[[i]][cp02s[[i]]$value != 0,] #remove 0s since these are distances between the same tip
} 

## load resampled at 2.5%
temp2 <- mixedsort(list.files(pattern=".*bestTree"))
tree2.5 <- lapply(temp2,read.tree)

## calculate pd
cp01s <- list()
cp01.2s <- list()
for (i in 1:length(temp2)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree2.5[[i]]))
  cp01s[[i]] <- cp01
  cp01.2 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.2s[[i]] <- cp01.2
  cp01.2s[[i]]$group <- "2.5%"
  cp01.2s[[i]] <- cp01.2s[[i]][cp01.2s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 

## load resampled at 5% 
temp3 <- mixedsort(list.files(pattern=".*bestTree"))
tree5 <- lapply(temp3,read.tree)

## calculate pd
cp01s <- list()
cp01.3s <- list()
for (i in 1:length(temp3)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree5[[i]]))
  cp01s[[i]] <- cp01
  cp01.3 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.3s[[i]] <- cp01.3
  cp01.3s[[i]]$group <- "5%"
  cp01.3s[[i]] <- cp01.3s[[i]][cp01.3s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 

## load resampled at 10% 
temp4 <- mixedsort(list.files(pattern=".*bestTree"))
tree10 <- lapply(temp4,read.tree)

## calculate pd
cp01s <- list()
cp01.4s <- list()
for (i in 1:length(temp4)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree10[[i]]))
  cp01s[[i]] <- cp01
  cp01.4 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.4s[[i]] <- cp01.4
  cp01.4s[[i]]$group <- "10%"
  cp01.4s[[i]] <- cp01.4s[[i]][cp01.4s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 

## load resampled at 20% 
temp5 <- mixedsort(list.files(pattern=".*bestTree"))
tree20 <- lapply(temp5,read.tree)

## calculate pd
cp01s <- list()
cp01.5s <- list()
for (i in 1:length(temp5)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree20[[i]]))
  cp01s[[i]] <- cp01
  cp01.5 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.5s[[i]] <- cp01.5
  cp01.5s[[i]]$group <- "20%"
  cp01.5s[[i]] <- cp01.5s[[i]][cp01.5s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 
