require(gtools)
require(dplyr)

## PD 1
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

## PD 2
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

## PD 3
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

## PD 4
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


