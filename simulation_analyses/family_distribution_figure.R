# plot distributions

## load GMYC distributions
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

#remove 4 trees where GMYC did not find clusters
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

#bind GMYC results together
number_all <- rbind(number_1, number_2, number_3, number_4)
med_all <- rbind(med_1, med_2, med_3, med_4)

#plot family median values - violin plot
p1 <- ggplot(med_all, aes(factor(pd), as.numeric(val))) + theme_classic()
p1 <- p1 + geom_violin(aes(fill = factor(pd))) + labs(fill="Parameter Directory") +
  scale_fill_manual(values=c("#1b9e77","#ce1256","#7570b3","#a6761d")) +
  xlab("Parameter Directory") + ylab("Median Family Size")

#plot family numbers - violin plot
p2 <- ggplot(number_all, aes(factor(pd), as.numeric(val))) + theme_classic()
p2 <- p2 + geom_violin(aes(fill = factor(pd))) + labs(fill="Parameter Directory") +
  scale_fill_manual(values=c("#1b9e77","#ce1256","#7570b3","#a6761d")) +
  xlab("Parameter Directory") + ylab("Number of Families") + geom_hline(yintercept=5, linetype='dotted', col = 'black')

