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
  number_fams3[[i]] <- length(unique(gmyc_3[[i]]$GMYC_spec))
  med_fam_size3[[i]] <- median(gmyc_3[[i]]$n)
  number_3 <- data.frame(unlist(number_fams3))
  med_3 <- data.frame(unlist(med_fam_size3))
  number_3$group <- "3"
  med_3$group <- "3"
  colnames(number_3) <- c("val", "pd")
  colnames(med_3) <- c("val", "pd")
}

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

