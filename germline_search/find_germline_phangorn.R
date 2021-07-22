## After tree building in RAxML, save tree and fasta file

## Load packages
library(ape)
library(phangorn)
library(seqLogo)

#load sequences
seqs <- read.FASTA(file="sim.fasta")

#change format to phyDat format
seqs <- as.phyDat(seqs)

#load tree
#tree is rooted with branch lengths
tree <- read.tree(file="RAxML_result.sim1.RUN.9")

#resolve polytomies
tree2 <- multi2di(tree)

#find likelihood of a tree given a model and sequences
fit <- pml(tree2, seqs, model = "GTR")

#ancestral character reconstruction
anc.ml <- ancestral.pml(fit, type = "ml")

#plot
plotAnc(tree2, anc.ml, 17)

#find site pattern value
#view ancestral sequence
seqLogo(t(subset(anc.ml, getRoot(tree2), 1:site_pattern_value[[1]]), ic.scale=FALSE)
        
        
