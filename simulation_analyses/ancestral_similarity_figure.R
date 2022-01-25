## load packages
require(stringr)
require(seqRFLP)
require(ggplot2)
require(cowplot)

## naive seq
p1 <- read.table(file="partition_1_naive.txt")
p1$sim <- c(1:250)
p1 <- transform(p1, V1 = colsplit(V1, ">", names = c('remove', 'seq')))
p1 <- do.call(data.frame, p1)
p1 <- p1[,-1]
colnames(p1) <- c("seq", "sim")
p1$sim <- paste0("sim", p1$sim)
p1$fam <- "family1"
p1$name <- paste0(p1$fam,"_",p1$sim)

p2 <- read.table(file="partition_2_naive.txt")
p2$sim <- c(1:250)
p2 <- transform(p2, V1 = colsplit(V1, ">", names = c('remove', 'seq')))
p2 <- do.call(data.frame, p2)
p2 <- p2[,-1]
colnames(p2) <- c("seq", "sim")
p2$sim <- paste0("sim", p2$sim)
p2$fam <- "family2"
p2$name <- paste0(p2$fam,"_",p2$sim)

p3 <- read.table(file="partition_3_naive.txt")
p3$sim <- c(1:250)
p3 <- transform(p3, V1 = colsplit(V1, ">", names = c('remove', 'seq')))
p3 <- do.call(data.frame, p3)
p3 <- p3[,-1]
colnames(p3) <- c("seq", "sim")
p3$sim <- paste0("sim", p3$sim)
p3$fam <- "family3"
p3$name <- paste0(p3$fam,"_",p3$sim)

p4 <- read.table(file="partition_4_naive.txt")
p4$sim <- c(1:250)
p4 <- transform(p4, V1 = colsplit(V1, ">", names = c('remove', 'seq')))
p4 <- do.call(data.frame, p4)
p4 <- p4[,-1]
colnames(p4) <- c("seq", "sim")
p4$sim <- paste0("sim", p4$sim)
p4$fam <- "family4"
p4$name <- paste0(p4$fam,"_",p4$sim)

p5 <- read.table(file="partition_5_naive.txt")
p5$sim <- c(1:250)
p5 <- transform(p5, V1 = colsplit(V1, ">", names = c('remove', 'seq')))
p5 <- do.call(data.frame, p5)
p5 <- p5[,-1]
colnames(p5) <- c("seq", "sim")
p5$sim <- paste0("sim", p5$sim)
p5$fam <- "family5"
p5$name <- paste0(p5$fam,"_",p5$sim)

## all naive seqs across families together
naive <- rbind(p1,p2,p3,p4,p5)

