## investigate family distribution in megatrees

##### load packages #####
library(geiger)
library(ape)
library(phytools)
library(gtools)
library(ggplot2)
library(reshape)
library(dplyr)

##### load strict functions #####
## Load old functions

## FUNCTION 1: drop sister tips that share the same trait value
same_nodes <- function(phylogeny, trait, label_tip){
  # get tip numbers
  ntips <- Ntip(phylogeny)
  
  # matrix to fill in with parent nodes (node paths)
  parent_nodes <- matrix(NA_integer_, nrow = ntips, ncol = ntips-1,
                         dimnames = list(phylogeny$tip.label, 
                                         seq(ntips+1, (2*ntips)-1, by = 1)))
  # retrieve paths
  full_paths <- path_vec(1:ntips, phylogeny$edge, ntips+1)
  
  # fill in matrix
  for(i in 1:ntips){
    parent_nodes[i, full_paths[[i]]-ntips] = 
      trait[which(phylogeny$tip.label == label_tip[i])]
  }
  
  # nodes that will be dropped
  drop_nodes <- apply(parent_nodes, 2, function(x) length(unique(na.exclude(x))) )
  
  return(as.numeric(names(which(drop_nodes == 1))))
}

## FUNCTION 2: retrieve the node numbers for each tip from tip to root (path)
path_retrieve <- function(tip_number, edge, root_number){
  
  #empty list
  final_path <- c()
  
  #get path
  while(tip_number != root_number){
    final_path <- c(which(edge[ , 2] == tip_number), final_path)
    tip_number <- edge[final_path[1], 1]
  }
  
  final_path <- edge[final_path , 1]
  
  return(rev(final_path))
}

# tips as vector
path_vec <- Vectorize(FUN = path_retrieve, vectorize.args = "tip_number")



##### analyze mega trees #####

## load trees
temp <- mixedsort(list.files(pattern="*.bestTree"))
trees <- lapply(temp,read.tree)

## load data
data <- list()

for (i in 1:length(trees)) { 
data[[i]] <- as.data.frame(trees[[i]]$tip.label)
colnames(data[[i]]) <- "name"
data[[i]] <- transform(data[[i]], name = colsplit(name, split = "\\_", names = c('fam', 'sim', 'seq')))
data[[i]] <- do.call(data.frame, data[[i]])
data[[i]] <- transform(data[[i]], name.fam = colsplit(name.fam, split="\\y", names = c('word', 'trait')))
data[[i]] <- do.call(data.frame, data[[i]])
data[[i]]$tip_label <- trees[[i]]$tip.label
data[[i]] <- data[[i]][,-1]
data[[i]] <- data[[i]][,-c(2,3)]
data[[i]] <- data[[i]][,c(2,1)]
colnames(data[[i]]) <- c("tip_label", "trait")
}

## run functions
dtest_ofs_1090 <- list()
ltest_ofs_1090 <- list()
rtest_ofs_1090 <- list()
ptest_ofs_1090 <- list()

for (i in 1:length(trees)) { 
dtest_ofs_1090[[i]] <- same_nodes(trees[[i]], data[[i]]$trait, data[[i]]$tip_label)
}

for (i in 1:length(trees)) { 
ltest_ofs_1090[[i]] <- lapply(dtest_ofs_1090[[i]], function(x) extract.clade(trees[[i]], x)$tip.label)
}

for (i in 1:length(trees)) { 
rtest_ofs_1090[[i]] <- unique(unlist(sapply(ltest_ofs_1090[[i]], '[', -1, simplify = TRUE)))
}

for (i in 1:length(trees)) { 
ptest_ofs_1090[[i]] <- drop.tip(phy = trees[[i]], tip = rtest_ofs_1090[[i]])
}

## number of extra tips
lengths <- list()

for (i in 1:length(trees)) {
lengths[[i]] <- length(ptest_ofs_1090[[i]]$tip.label)
}

## number of tips per family 
data_pruned <- list()
summary <- list()
count <- list()

for (i in 1:length(trees)) {
data_pruned[[i]] <- data[[i]][data[[i]]$tip_label %in% ptest_ofs_1090[[i]]$tip.label,]
summary[[i]] <- dplyr::count(data_pruned[[i]], trait)
count[[i]] <- nrow(subset(summary[[i]],n > 1))
}

##### save trees with perfectly grouped clades #####
#which_5 <- lengths == 5
#files_to_keep <- temp[as.logical(which_5)]
#saveRDS(files_to_keep, "trees_perfect_clades.rds")

##### plotting #####
#lengths
length <- as.data.frame(unlist(lengths))
val <- 5 # add as a line on graph
length$group <- ifelse(length$`unlist(lengths)` <= 5, "5", 
                       ifelse(length$`unlist(lengths)` > 5, ">5", ">5")) # to colour bars on graph

# plot example with line at number 5
ggplot(length, aes(x=unlist(lengths), fill=group)) + geom_histogram(binwidth=1, color="black") + 
  theme_classic() + xlab("Number of Clades") + ylab("Count") + scale_fill_manual(values = c("5" = "#d95f02", ">5" = "#C0C0C0")) + 
  geom_vline(aes(xintercept = val), colour="blue", linetype="dashed")

# plots with different colour bars
a <- ggplot(length, aes(x=unlist(lengths), fill=group)) + geom_histogram(binwidth=1, color="black") + 
  theme_classic() + xlab("Number of Clades") + ylab("Count") + scale_fill_manual(values = c("5" = "#d95f02", ">5" = "#C0C0C0"))
a <- a + theme(legend.position="none")
b <- ggplot(length, aes(x=unlist(lengths), fill=group)) + geom_histogram(binwidth=1, color="black") + 
  theme_classic() + xlab("Number of Clades") + ylab("Count") + scale_fill_manual(values = c("5" = "#d95f02", ">5" = "#C0C0C0"))
b <- b + theme(legend.position="none")
c <- ggplot(length, aes(x=unlist(lengths), fill=group)) + geom_histogram(binwidth=1, color="black") + 
  theme_classic() + xlab("Number of Clades") + ylab("Count") + scale_fill_manual(values = c("5" = "#d95f02", ">5" = "#C0C0C0"))
c <- c + theme(legend.position="none")
d <- ggplot(length, aes(x=unlist(lengths), fill=group)) + geom_histogram(binwidth=1, color="black") + 
  theme_classic() + xlab("Number of Clades") + ylab("Count") + scale_fill_manual(values = c("5" = "#d95f02", ">5" = "#C0C0C0"))
d <- d + theme(legend.position="none")


#counts
counts <- as.data.frame(unlist(count))

ggplot(counts, aes(x=unlist(count))) + geom_histogram(binwidth=1, color="black", fill="grey") + 
  theme_classic() + xlab("Number of Non-Monophyletic Families") + ylab("Count") 

