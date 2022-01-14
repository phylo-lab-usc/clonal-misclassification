## load packages

require(ggplot2)
require(Biostrings)
require(reshape2)
require(ape)
require(phytools)
require(splits)
require(gtools)
require(dplyr)
require(FNN)

## extract information about partis clusters
temp <- mixedsort(list.files(pattern="*.fasta"))
fastaFiles <- lapply(temp,readDNAStringSet)

seq_name <- list()
sequence <- list()
df <- list()
df2 <- list()
df3 <- list()
count_df <- list()

for(i in 1:length(temp)){
  seq_name[[i]] <- names(fastaFiles[[i]])
  sequence[[i]] <- paste(fastaFiles[[i]])
  df[[i]] <- data.frame(seq_name[[i]], sequence[[i]])
  df2[[i]] <- transform(df[[i]], seq_name..i.. = colsplit(seq_name..i.., "_", names = c('famID', 'simID', 'seq')))
  df3[[i]] <- do.call(data.frame, df2[[i]])
  count_df[[i]] <- plyr::count(df3[[i]], "seq_name..i...famID")
}

## save distribution information
saveRDS(count_df, "simulation_distributions.rds")
