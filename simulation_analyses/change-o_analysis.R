#####analyze CHANGE-O output#####
CO_1 <- read.table(file = 'mega_1_db-pass_clone-pass.tsv', sep = '\t', header = TRUE)
CO_1 <- transform(CO_1, name = colsplit(sequence_id, split = "\\_", names = c('fam', 'sim', 'seq')))
CO_1 <- do.call(data.frame, CO_1)
CO_1_list <- split(CO_1,CO_1$name.sim)

number_fams1 <- list()
med_tables <- list()
med_fam_size1 <- list()
for (i in 1:length(CO_1_list)) {
  number_fams1[[i]] <- length(unique(CO_1_list[[i]]$clone_id))
  number_1 <- data.frame(unlist(number_fams1))
  med_tables[[i]] <- CO_1_list[[i]] %>% group_by(clone_id) %>% summarise(n = n())
  med_fam_size1[[i]] <- median(med_tables[[i]]$n)
  med_1 <- data.frame(unlist(med_fam_size1))
}

CO_2 <- read.table(file = 'mega_2_db-pass_clone-pass.tsv', sep = '\t', header = TRUE)
CO_2 <- transform(CO_2, name = colsplit(sequence_id, split = "\\_", names = c('fam', 'sim', 'seq')))
CO_2 <- do.call(data.frame, CO_2)
CO_2_list <- split(CO_2,CO_2$name.sim)

number_fams2 <- list()
med_tables <- list()
med_fam_size2 <- list()
for (i in 1:length(CO_2_list)) {
  number_fams2[[i]] <- length(unique(CO_2_list[[i]]$clone_id))
  number_2 <- data.frame(unlist(number_fams2))
  med_tables[[i]] <- CO_2_list[[i]] %>% group_by(clone_id) %>% summarise(n = n())
  med_fam_size2[[i]] <- median(med_tables[[i]]$n)
  med_2 <- data.frame(unlist(med_fam_size2))
}

CO_3 <- read.table(file = 'mega_3_db-pass_clone-pass.tsv', sep = '\t', header = TRUE)
CO_3 <- transform(CO_3, name = colsplit(sequence_id, split = "\\_", names = c('fam', 'sim', 'seq')))
CO_3 <- do.call(data.frame, CO_3)
CO_3_list <- split(CO_3,CO_3$name.sim)

number_fams3 <- list()
med_tables <- list()
med_fam_size3 <- list()
for (i in 1:length(CO_3_list)) {
  number_fams3[[i]] <- length(unique(CO_3_list[[i]]$clone_id))
  number_3 <- data.frame(unlist(number_fams3))
  med_tables[[i]] <- CO_3_list[[i]] %>% group_by(clone_id) %>% summarise(n = n())
  med_fam_size3[[i]] <- median(med_tables[[i]]$n)
  med_3 <- data.frame(unlist(med_fam_size3))
}

CO_4 <- read.table(file = 'mega_4_db-pass_clone-pass.tsv', sep = '\t', header = TRUE)
CO_4 <- transform(CO_4, name = colsplit(sequence_id, split = "\\_", names = c('fam', 'sim', 'seq')))
CO_4 <- do.call(data.frame, CO_4)
CO_4_list <- split(CO_4,CO_4$name.sim)

number_fams4 <- list()
med_tables <- list()
med_fam_size4 <- list()
for (i in 1:length(CO_4_list)) {
  number_fams4[[i]] <- length(unique(CO_4_list[[i]]$clone_id))
  number_4 <- data.frame(unlist(number_fams4))
  med_tables[[i]] <- CO_4_list[[i]] %>% group_by(clone_id) %>% summarise(n = n())
  med_fam_size4[[i]] <- median(med_tables[[i]]$n)
  med_4 <- data.frame(unlist(med_fam_size4))
}