## resample the sequences in a family at a certain rate
## this code is written in for loops to run over multiple simulation results

## load packages
require("Biostrings")
require("reshape")
require("seqRFLP")

## load fasta file
fastaFile <- readDNAStringSet("file.fasta") #eg file: "aligned_pd1_correct_sized_families_together.fasta"
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

## make new dataframes for each new family, looped for each simulation
dfs_split <- list()
for (k in 1:length(dfs)){
  dfs_split[[k]] <- split(dfs[[k]], f = dfs[[k]]$fam_new)
}

## extract only information about old and new family + sequence
dfs2_split1 <- list()
dfs3_split1 <- list()

for (i in 1:length(dfs_split)){
  df2 <- data.frame(lapply(dfs_split[[i]]$family1, as.character), stringsAsFactors=FALSE)
  dfs2_split1[[i]] <- df2
  dfs2_split1[[i]]$id <- paste(dfs2_split1[[i]]$famID, dfs2_split1[[i]]$sim_number, dfs2_split1[[i]]$seq_number, dfs2_split1[[i]]$fam_new, sep="_")
  df3 <- data.frame(dfs2_split1[[i]]$id, dfs2_split1[[i]]$sequence)
  dfs3_split1[[i]] <- df3
}

dfs2_split2 <- list()
dfs3_split2 <- list()

for (i in 1:length(dfs_split)){
  df2 <- data.frame(lapply(dfs_split[[i]]$family2, as.character), stringsAsFactors=FALSE)
  dfs2_split2[[i]] <- df2
  dfs2_split2[[i]]$id <- paste(dfs2_split2[[i]]$famID, dfs2_split2[[i]]$sim_number, dfs2_split2[[i]]$seq_number, dfs2_split2[[i]]$fam_new, sep="_")
  df3 <- data.frame(dfs2_split2[[i]]$id, dfs2_split2[[i]]$sequence)
  dfs3_split2[[i]] <- df3
}

dfs2_split3 <- list()
dfs3_split3 <- list()

for (i in 1:length(dfs_split)){
  df2 <- data.frame(lapply(dfs_split[[i]]$family3, as.character), stringsAsFactors=FALSE)
  dfs2_split3[[i]] <- df2
  dfs2_split3[[i]]$id <- paste(dfs2_split3[[i]]$famID, dfs2_split3[[i]]$sim_number, dfs2_split3[[i]]$seq_number, dfs2_split3[[i]]$fam_new, sep="_")
  df3 <- data.frame(dfs2_split3[[i]]$id, dfs2_split3[[i]]$sequence)
  dfs3_split3[[i]] <- df3
}

dfs2_split4 <- list()
dfs3_split4 <- list()

for (i in 1:length(dfs_split)){
  df2 <- data.frame(lapply(dfs_split[[i]]$family4, as.character), stringsAsFactors=FALSE)
  dfs2_split4[[i]] <- df2
  dfs2_split4[[i]]$id <- paste(dfs2_split4[[i]]$famID, dfs2_split4[[i]]$sim_number, dfs2_split4[[i]]$seq_number, dfs2_split4[[i]]$fam_new, sep="_")
  df3 <- data.frame(dfs2_split4[[i]]$id, dfs2_split4[[i]]$sequence)
  dfs3_split4[[i]] <- df3
}

dfs2_split5 <- list()
dfs3_split5 <- list()

for (i in 1:length(dfs_split)){
  df2 <- data.frame(lapply(dfs_split[[i]]$family5, as.character), stringsAsFactors=FALSE)
  dfs2_split5[[i]] <- df2
  dfs2_split5[[i]]$id <- paste(dfs2_split5[[i]]$famID, dfs2_split5[[i]]$sim_number, dfs2_split5[[i]]$seq_number, dfs2_split5[[i]]$fam_new, sep="_")
  df3 <- data.frame(dfs2_split5[[i]]$id, dfs2_split5[[i]]$sequence)
  dfs3_split5[[i]] <- df3
}

dfs3_split1_edit <- dfs3_split1[sapply(dfs3_split1, nrow)>0]
dfs3_split2_edit <- dfs3_split2[sapply(dfs3_split2, nrow)>0]
dfs3_split3_edit <- dfs3_split3[sapply(dfs3_split3, nrow)>0]
dfs3_split4_edit <- dfs3_split4[sapply(dfs3_split4, nrow)>0]
dfs3_split5_edit <- dfs3_split5[sapply(dfs3_split5, nrow)>0]

for (k in 1:length(dfs3_split1_edit)){
  colnames(dfs3_split1_edit[[k]]) <- c("ID", "sequence")
}
for (k in 1:length(dfs3_split2_edit)){
  colnames(dfs3_split2_edit[[k]]) <- c("ID", "sequence")
}
for (k in 1:length(dfs3_split3_edit)){
  colnames(dfs3_split3_edit[[k]]) <- c("ID", "sequence")
}
for (k in 1:length(dfs3_split4_edit)){
  colnames(dfs3_split4_edit[[k]]) <- c("ID", "sequence")
}
for (k in 1:length(dfs3_split5_edit)){
  colnames(dfs3_split5_edit[[k]]) <- c("ID", "sequence")
}

together <- c(dfs3_split1_edit, dfs3_split2_edit, dfs3_split3_edit, dfs3_split4_edit, dfs3_split5_edit)

together_names <- list()
named <- list()
unique_names <- list()
for (i in 1:length(together)){
  together_names[[i]] <- transform(together[[i]], ID = colsplit(ID, split = "\\_", names = c('family_old', 'sim_number', 'seq_number', "family_new")))
  together_names[[i]] <- do.call(data.frame, together_names[[i]])
  named[[i]] <- data.frame(together_names[[i]]$ID.family_new, together_names[[i]]$ID.sim_number)
  named[[i]]$name <- paste0(named[[i]]$together_names..i...ID.family_new, "_", named[[i]]$together_names..i...ID.sim_number)
  unique_names[[i]] <- unique(named[[i]]$name)
}

## save files, one fasta file for each family
lapply(1:length(together), function(i) dataframe2fas(together[[i]], 
                                                     file = paste0(as.vector(unique_names[[i]]), ".fasta")))
       
## save files, all information saved for each family
#lapply(1:length(dfs2), function(i) write.csv(dfs2[[i]], file = paste0(names(dfs)[i], ".csv"),row.names = FALSE))


