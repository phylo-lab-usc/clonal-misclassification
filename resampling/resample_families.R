## resample the sequences in a family at a certain rate
## this is for one simulation or for one real life data set

## load packages
require("Biostrings")
require("reshape")
require("seqRFLP")

## load fasta file
fastaFile <- readDNAStringSet("newfile2.fasta")
seq_name <- names(fastaFile)
sequence <- paste(fastaFile)

## convert to data frame
df <- data.frame(seq_name, sequence)

## separate columns for seqID, famID, seqID within family
df <- transform(df, seq_name = colsplit(seq_name, split = "\\_", names = c('seq_all', 'famseq')))
df <- do.call(data.frame, df)
df <- transform(df, seq_name.famseq = colsplit(seq_name.famseq, split = "s", names = c('famID', 'seqID')))
df <- do.call(data.frame, df)
df$seq_name.famseq.seqID <- paste("s", df$seq_name.famseq.seqID, sep="")

## rename columns
colnames(df) <- c("overall_seqID", "famID", "specific_seqID", "sequence")

## set r to the desired resampling level
r <- 0.1

## sample value 1 between 0 and 1
u <- list()
for (i in 1:dim(df)[[1]]){
  u[[i]] <- runif(1)
}
df$u <- u

## if u <= r then move the sequence to a new family
df$fam_new <- 0

for (i in 1:dim(df)[[1]]){
if (df$u[i] <= r) {
    fam_new <- as.vector(sample(df$famID))[1]
    df$fam_new[i] <- fam_new
}
  else{
    fam_old <- as.vector(df$famID)[i]
    df$fam_new[i] <- fam_old
  }
  }

## make new dataframes for each new family
dfs <- split(df, f = df$fam_new)
dfs2 <- list()
dfs3 <- list()

## extract only information about old and new famoly + sequence
for (i in 1:length(dfs)){
df2 <- data.frame(lapply(dfs[[i]], as.character), stringsAsFactors=FALSE)
dfs2[[i]] <- df2
dfs2[[i]]$id <- paste(dfs2[[i]]$overall_seqID, dfs2[[i]]$famID, dfs2[[i]]$specific_seqID, dfs2[[i]]$fam_new, sep="_")
df3 <- data.frame(dfs2[[i]]$id, dfs2[[i]]$sequence)
dfs3[[i]] <- df3
}

## save files, one fasta file for each family
lapply(1:length(dfs3), function(i) dataframe2fas(dfs3[[i]], 
                                                 file = paste0(names(dfs)[i], ".fasta")))
