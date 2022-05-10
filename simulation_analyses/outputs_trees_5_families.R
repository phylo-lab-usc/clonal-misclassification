require(ape)
require(phytools)
require(splits)
require(gtools)
require(dplyr)
require(Biostrings)

#####GMYC#####
temp <- readRDS(file="trees_perfect_clades_pd1.rds")
trees <- lapply(temp,read.tree)

bin <- list()
for (i in 1:length(trees)){
  bin[[i]] <- multi2di(trees[[i]])
}

for (i in 1:length(trees)){
  bin[[i]]$edge.length <- bin[[i]]$edge.length+0.01
}

tree_edit <- list()
for (i in 1:length(trees)){
  tree_edit[[i]] <- force.ultrametric(bin[[i]], method = "extend")
}

t1 <- list()
for (i in 1:length(trees)){
  t1[[i]] <- gmyc(tree_edit[[i]])
}

saveRDS(t1, "perfect_gmyc_output_megatrees_pd1.rds")

##extract gmyc distributions from gmyc output

t1 <- readRDS("perfect_gmyc_output_megatrees_pd1.rds")

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

saveRDS(t5, "perfect_gmyc_size_distribution_pd1.2.rds")

#####PARTIS#####
sim_1_files <- readRDS(file="trees_perfect_clades_pd1.rds")
sim_1_files <- as.data.frame(sim_1_files)
data <- transform(sim_1_files, name = colsplit(sim_1_files, split = "\\_", names = c('aligned', 'cat', 'megatree', 'sim')))
data <- do.call(data.frame, data)
data <- transform(data, name = colsplit(name.sim, split = "\\.", names = c('sim', 'f', 'r', 'b')))
data <- do.call(data.frame, data)
data <- transform(data, name = colsplit(name.sim.1, split = "\\m", names = c('sim', 'number')))
data <- do.call(data.frame, data)
data_name <- paste("aligned_cat_megatree_sim",data$name.number,".fasta")
data_name <- gsub(" ", "", paste(data_name))

fastaFiles <- lapply(data_name,readDNAStringSet)

seq_name <- list()
sequence <- list()
df <- list()
df2 <- list()
df3 <- list()
count_df <- list()

for(i in 1:length(fastaFiles)){
  seq_name[[i]] <- names(fastaFiles[[i]])
  sequence[[i]] <- paste(fastaFiles[[i]])
  df[[i]] <- data.frame(seq_name[[i]], sequence[[i]])
  df2[[i]] <- transform(df[[i]], seq_name..i.. = colsplit(seq_name..i.., "_", names = c('famID', 'simID', 'seq')))
  df3[[i]] <- do.call(data.frame, df2[[i]])
  count_df[[i]] <- plyr::count(df3[[i]], "seq_name..i...famID")
}

## save distribution information
saveRDS(count_df, "partis_pd1_perfect.rds")


#####MIXCR#####
data_name <- paste("cat_megatree_sim",data$name.number,".fasta.txt")
data_name <- gsub(" ", "", paste(data_name))
mixcr_1 <- lapply(data_name ,read.table, header=TRUE, fill=TRUE)
saveRDS(mixcr_1, "m1_perfect.rds")

#####CHANGEO#####
CO_1 <- read.table(file = 'mega_1_db-pass_clone-pass.tsv', sep = '\t', header = TRUE)
CO_1 <- transform(CO_1, name = colsplit(sequence_id, split = "\\_", names = c('fam', 'sim', 'seq')))
CO_1 <- do.call(data.frame, CO_1)
CO_1_list <- split(CO_1,CO_1$name.sim)

sorting <- mixedsort(names(CO_1_list))
CO_1_list <- CO_1_list[as.character(sorting)]

data_name <- paste("sim",data$name.number)
data_name <- gsub(" ", "", paste(data_name))

CO_1_list_perfect <- CO_1_list[data_name]
saveRDS(CO_1_list_perfect, "CO1_perfect.rds")



