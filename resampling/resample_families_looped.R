## resample the sequences in a family at a certain rate
## this code is written in for loops to run over multiple simulation results

## load packages
require("Biostrings")
require("reshape")
require("seqRFLP")

## load fasta file
fastaFile <- readDNAStringSet("file.fasta") 
seq_name <- names(fastaFile)
sequence <- paste(fastaFile)

## convert to data frame
df <- data.frame(seq_name, sequence)

## separate columns for seqID, famID, seqID within family
df <- transform(df, seq_name = colsplit(seq_name, split = "\\_", names = c('family', 'sim', 'seq')))
df <- do.call(data.frame, df)

##split for each simulation
dfs <- split(df, f = df$seq_name.sim)

## rename columns, looped for each simulation
for (k in 1:length(dfs)){
  colnames(dfs[[k]]) <- c("famID", "sim_number", "seq_number", "sequence")
}

## set r to the desired resampling level
r <- 0.2 ##change value to change resampling level

## sample value 1 between 0 and 1, looped for each simulation
u <- list()
for (k in 1:length(dfs)){
  for (i in 1:dim(dfs[[k]])[[1]]){
    u[[i]] <- runif(1)
    dfs[[k]]$u[[i]] <- u[[i]]
  }}


## if u <= r then move the sequence to a new family, looped for each simulation
for (k in 1:length(dfs)){
  dfs[[k]]$fam_new <- 0
}

for (k in 1:length(dfs)){
  for (i in 1:dim(dfs[[k]])[[1]]){
    if (dfs[[k]]$u[i] <= r) {
      fam_new <- as.vector(sample(dfs[[k]]$famID))[1]
      dfs[[k]]$fam_new[i] <- fam_new
    }
    else{
      fam_old <- as.vector(dfs[[k]]$famID)[i]
      dfs[[k]]$fam_new[i] <- fam_old
    }}}

