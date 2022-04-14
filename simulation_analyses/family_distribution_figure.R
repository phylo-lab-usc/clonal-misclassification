###### plot distributions 

## load packages
require(ggplot2)
require(gtools)
require(dplyr)
require(reshape)
require(cowplot)

##### load GMYC distributions #####
gmyc_1 <- readRDS(file="gmyc_pd1_size_distribution.rds")
number_fams1 <- list()
med_fam_size1 <- list()
for (i in 1:250) {
  number_fams1[[i]] <- length(unique(gmyc_1[[i]]$GMYC_spec))
  med_fam_size1[[i]] <- median(gmyc_1[[i]]$n)
  number_1 <- data.frame(unlist(number_fams1))
  med_1 <- data.frame(unlist(med_fam_size1))
  number_1$group <- "1"
  med_1$group <- "1"
  colnames(number_1) <- c("val", "pd")
  colnames(med_1) <- c("val", "pd")
}

gmyc_2 <- readRDS(file="gmyc_pd2_size_distribution.rds")
number_fams2 <- list()
med_fam_size2 <- list()
for (i in 1:194) {
  number_fams2[[i]] <- length(unique(gmyc_2[[i]]$GMYC_spec))
  med_fam_size2[[i]] <- median(gmyc_2[[i]]$n)
  number_2 <- data.frame(unlist(number_fams2))
  med_2 <- data.frame(unlist(med_fam_size2))
  number_2$group <- "2"
  med_2$group <- "2"
  colnames(number_2) <- c("val", "pd")
  colnames(med_2) <- c("val", "pd")
}

gmyc_3 <- readRDS(file="gmyc_pd3_size_distribution.rds")
number_fams3 <- list()
med_fam_size3 <- list()
for (i in 1:223) {
  number_fams3[[i]] <- try(length(unique(gmyc_3[[i]]$GMYC_spec))) #4 trees did not find clusters
  med_fam_size3[[i]] <- try(median(gmyc_3[[i]]$n))#4 trees did not find clusters
  number_3 <- data.frame(unlist(number_fams3))
  med_3 <- data.frame(unlist(med_fam_size3))
  number_3$group <- "3"
  med_3$group <- "3"
  colnames(number_3) <- c("val", "pd")
  colnames(med_3) <- c("val", "pd")
}

# remove 4 trees where GMYC did not find clusters
med_3 <- med_3[-c(29,147,170,178),]
number_3 <- number_3[-c(29,147,170,178),]

gmyc_4 <- readRDS(file="gmyc_pd4_size_distribution.rds")
number_fams4 <- list()
med_fam_size4 <- list()
for (i in 1:207) {
  number_fams4[[i]] <- length(unique(gmyc_4[[i]]$GMYC_spec))
  med_fam_size4[[i]] <- median(gmyc_4[[i]]$n)
  number_4 <- data.frame(unlist(number_fams4))
  med_4 <- data.frame(unlist(med_fam_size4))
  number_4$group <- "4"
  med_4$group <- "4"
  colnames(number_4) <- c("val", "pd")
  colnames(med_4) <- c("val", "pd")
}

## bind GMYC results together
GMYC_number_all <- rbind(number_1, number_2, number_3, number_4)
GMYC_med_all <- rbind(med_1, med_2, med_3, med_4)

##### load partis distributions #####
sim_1 <- readRDS(file="simulation_distributions.rds")
s_med_fam_size1 <- list()
for (i in 1:250) {
  s_med_fam_size1[[i]] <- median(sim_1[[i]]$freq)
  s_med_1 <- data.frame(unlist(s_med_fam_size1))
  s_med_1$group <- "1"
  colnames(s_med_1) <- c("val", "pd")
}

sim_2 <- readRDS(file="simulation_distributions.rds")
s_med_fam_size2 <- list()
for (i in 1:194) {
  s_med_fam_size2[[i]] <- median(sim_2[[i]]$freq)
  s_med_2 <- data.frame(unlist(s_med_fam_size2))
  s_med_2$group <- "2"
  colnames(s_med_2) <- c("val", "pd")
}

sim_3 <- readRDS(file="simulation_distributions.rds")
s_med_fam_size3 <- list()
for (i in 1:223) {
  s_med_fam_size3[[i]] <- median(sim_3[[i]]$freq)
  s_med_3 <- data.frame(unlist(s_med_fam_size3))
  s_med_3$group <- "3"
  colnames(s_med_3) <- c("val", "pd")
}

sim_4 <- readRDS(file="simulation_distributions.rds")
s_med_fam_size4 <- list()
for (i in 1:207) {
  s_med_fam_size4[[i]] <- median(sim_4[[i]]$freq)
  s_med_4 <- data.frame(unlist(s_med_fam_size4))
  s_med_4$group <- "4"
  colnames(s_med_4) <- c("val", "pd")
}

## bind partis results together
partis_med_all <- rbind(s_med_1, s_med_2, s_med_3, s_med_4)

##### load MIXCR results #####
temp <- mixedsort(list.files(pattern="*.txt"))
mixcr_1 <- lapply(temp,read.table, header=TRUE, fill=TRUE)

mixcr_n <- list()
for (i in 1:250) {
  mixcr_n[[i]] <- mixcr_1[[i]] %>% group_by(cloneCount) %>% summarise(n = n())
}

number_fams1 <- list()
med_fam_size1 <- list()
for (i in 1:250) {
  number_fams1[[i]] <- length(unique(mixcr_1[[i]]$cloneCount))
  med_fam_size1[[i]] <- median(mixcr_n[[i]]$n)
  number_1 <- data.frame(unlist(number_fams1))
  med_1 <- data.frame(unlist(med_fam_size1))
  number_1$group <- "1"
  med_1$group <- "1"
  colnames(number_1) <- c("val", "pd")
  colnames(med_1) <- c("val", "pd")
}


temp <- mixedsort(list.files(pattern="*.txt"))
mixcr_2 <- lapply(temp,read.table, header=TRUE, fill=TRUE)

mixcr_n <- list()
for (i in 1:194) {
  mixcr_n[[i]] <- mixcr_2[[i]] %>% group_by(cloneCount) %>% summarise(n = n())
}

number_fams2 <- list()
med_fam_size2 <- list()
for (i in 1:194) {
  number_fams2[[i]] <- length(unique(mixcr_2[[i]]$cloneCount))
  med_fam_size2[[i]] <- median(mixcr_n[[i]]$n)
  number_2 <- data.frame(unlist(number_fams2))
  med_2 <- data.frame(unlist(med_fam_size2))
  number_2$group <- "2"
  med_2$group <- "2"
  colnames(number_2) <- c("val", "pd")
  colnames(med_2) <- c("val", "pd")
}


temp <- mixedsort(list.files(pattern="*.txt"))
mixcr_3 <- lapply(temp,read.table, header=TRUE, fill=TRUE)

mixcr_n <- list()
for (i in 1:223) {
  mixcr_n[[i]] <- mixcr_3[[i]] %>% group_by(cloneCount) %>% summarise(n = n())
}

number_fams3 <- list()
med_fam_size3 <- list()
for (i in 1:223) {
  number_fams3[[i]] <- length(unique(mixcr_3[[i]]$cloneCount))
  med_fam_size3[[i]] <- median(mixcr_n[[i]]$n)
  number_3 <- data.frame(unlist(number_fams3))
  med_3 <- data.frame(unlist(med_fam_size3))
  number_3$group <- "3"
  med_3$group <- "3"
  colnames(number_3) <- c("val", "pd")
  colnames(med_3) <- c("val", "pd")
}


temp <- mixedsort(list.files(pattern="*.txt"))
mixcr_4 <- lapply(temp,read.table, header=TRUE, fill=TRUE)

mixcr_n <- list()
for (i in 1:207) {
  mixcr_n[[i]] <- mixcr_4[[i]] %>% group_by(cloneCount) %>% summarise(n = n())
}

number_fams4 <- list()
med_fam_size4 <- list()
for (i in 1:207) {
  number_fams4[[i]] <- length(unique(mixcr_4[[i]]$cloneCount))
  med_fam_size4[[i]] <- median(mixcr_n[[i]]$n)
  number_4 <- data.frame(unlist(number_fams4))
  med_4 <- data.frame(unlist(med_fam_size4))
  number_4$group <- "4"
  med_4$group <- "4"
  colnames(number_4) <- c("val", "pd")
  colnames(med_4) <- c("val", "pd")
}

## join
mixcr_number_all <- rbind(number_1, number_2, number_3, number_4)
mixcr_med_all <- rbind(med_1, med_2, med_3, med_4)

##### load Change-O results #####
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
  number_1$group <- "1"
  med_1$group <- "1"
  colnames(number_1) <- c("val", "pd")
  colnames(med_1) <- c("val", "pd")
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
  number_2$group <- "2"
  med_2$group <- "2"
  colnames(number_2) <- c("val", "pd")
  colnames(med_2) <- c("val", "pd")
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
  number_3$group <- "3"
  med_3$group <- "3"
  colnames(number_3) <- c("val", "pd")
  colnames(med_3) <- c("val", "pd")
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
  number_4$group <- "4"
  med_4$group <- "4"
  colnames(number_4) <- c("val", "pd")
  colnames(med_4) <- c("val", "pd")
}

## join
changeo_number_all <- rbind(number_1, number_2, number_3, number_4)
changeo_med_all <- rbind(med_1, med_2, med_3, med_4)

##### plot all methods median #####
GMYC_med_all$method <- "GMYC"
partis_med_all$method <- "partis"
mixcr_med_all$method <- "MiXCR"
changeo_med_all$method <- "Change-O"
med_together <- rbind(partis_med_all, GMYC_med_all, mixcr_med_all,changeo_med_all)

p_med <- ggplot(med_together) + aes(x=factor(pd), y=log(as.numeric(val)), color=method) + theme_classic() + 
  geom_boxplot() + labs(color="Method") + scale_color_manual(values=c("#1b9e77","#ce1256","#7570b3", "black")) +
  xlab("Parameter Directory") + ylab("log(Median Family Size)")

##### plot all methods number #####
mixcr_number_all$method <- "MiXCR"
GMYC_number_all$method <- "GMYC"
changeo_number_all$method <- "Change-O"

num_together <- rbind(mixcr_number_all, GMYC_number_all, changeo_number_all)

p_num <- ggplot(num_together) + aes(x=factor(pd), y=log(as.numeric(val)), color=method) + theme_classic() +
 geom_boxplot() + labs(color="Method") +
  scale_color_manual(values=c("#1b9e77","#ce1256","#7570b3")) + #""#7570b3", #a6761d"
  xlab("Parameter Directory") + ylab("log(Number of Families)") + geom_hline(yintercept=log(5), linetype='dotted', col = 'black')

##### join plot #####
plot_grid(p_med, p_num, nrow=2, labels = c("A", "B"))

