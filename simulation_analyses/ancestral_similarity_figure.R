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

## load resampling level naive sequences
# 0 level
p0 <- read.table(file="root_naive.txt")
temp0 <- read.table(file="list.txt")
temp0 <- as.vector(temp0)
p0$name <- temp0
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name = colsplit(V1.1, "_", name = c('1', '2', '3')))
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name.3 = colsplit(name.3, ".fasta", names = c('1', '2')))
p0 <- do.call(data.frame, p0)
p0 <- p0[,-c(1,3,4,7)]
colnames(p0) <- c("seq", "fam", "sim")
p0$name <- paste0(p0$fam,"_",p0$sim)
p0$name <- gsub("fam", "family", p0$name)
#####fix naive#####
naive2 <- naive[naive$name %in% p0$name, ]
naive2 <- naive2[order(match(naive2$name,p0$name)),]
naive2$full <- paste0("n_",naive2$name)
df_n <- data.frame(cbind(naive2$full, naive2$seq))
colnames(df_n) <- c("name", "seq")
##########
p0$full <- paste0("0_",p0$name)
df_0 <- data.frame(p0$full, p0$seq)
colnames(df_0) <- c("name", "seq")
#df_0$name <- gsub("fam", "family", df_0$name)

# 2.5 level
p0 <- read.table(file="root_naive.txt")
temp0 <- read.table(file="list.txt")
temp0 <- as.vector(temp0)
p0$name <- temp0
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name = colsplit(V1.1, "_", name = c('1', '2', '3')))
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name.3 = colsplit(name.3, ".fasta", names = c('1', '2')))
p0 <- do.call(data.frame, p0)
p0 <- p0[,-c(1,3,4,7)]
colnames(p0) <- c("seq", "fam", "sim")
p0$name <- paste0(p0$fam,"_",p0$sim)
p0$full <- paste0("2_",p0$name)

df_2.5 <- data.frame(p0$full, p0$seq)
colnames(df_2.5) <- c("name", "seq")

# 5 level
p0 <- read.table(file="root_naive.txt")
temp0 <- read.table(file="list.txt")
temp0 <- as.vector(temp0)
p0$name <- temp0
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name = colsplit(V1.1, "_", name = c('1', '2', '3')))
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name.3 = colsplit(name.3, ".fasta", names = c('1', '2')))
p0 <- do.call(data.frame, p0)
p0 <- p0[,-c(1,3,4,7)]
colnames(p0) <- c("seq", "fam", "sim")
p0$name <- paste0(p0$fam,"_",p0$sim)
p0$full <- paste0("5_",p0$name)

df_5 <- data.frame(p0$full, p0$seq)
colnames(df_5) <- c("name", "seq")

# 10 level
p0 <- read.table(file="root_naive.txt")
temp0 <- mixedsort(list.files(pattern="*.ancestralStates.txt.txt"))
p0$name <- temp0
p0<-p0[,-1]
p0 <- transform(p0, name = colsplit(name, "_", name = c('1', '2', '3')))
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name.3 = colsplit(name.3, ".fasta", names = c('1', '2')))
p0 <- do.call(data.frame, p0)
p0 <- p0[,-c(2,5)]
colnames(p0) <- c("seq", "fam", "sim")
p0$name <- paste0(p0$fam,"_",p0$sim)
p0$full <- paste0("10_",p0$name)

df_10 <- data.frame(p0$full, p0$seq)
colnames(df_10) <- c("name", "seq")

# 20 level
p0 <- read.table(file="root_naive.txt")
temp0 <- mixedsort(list.files(pattern="*.ancestralStates.txt.txt"))
p0$name <- temp0
p0<-p0[,-1]
p0 <- transform(p0, name = colsplit(name, "_", name = c('1', '2', '3')))
p0 <- do.call(data.frame, p0)
p0 <- transform(p0, name.3 = colsplit(name.3, ".fasta", names = c('1', '2')))
p0 <- do.call(data.frame, p0)
p0 <- p0[,-c(2,5)]
colnames(p0) <- c("seq", "fam", "sim")
p0$name <- paste0(p0$fam,"_",p0$sim)
p0$full <- paste0("20_",p0$name)

df_20 <- data.frame(p0$full, p0$seq)
colnames(df_20) <- c("name", "seq")

## join together
all <- rbind(df_n,df_0,df_2.5, df_5, df_10, df_20)
df.fasta <- dataframe2fas(all, file="df.fasta") #align in MAFFT

## load aligned fasta file
fastaFile <- readDNAStringSet("df_aligned.fasta")
seq_name <- names(fastaFile)
sequence <- paste(fastaFile)
df <- data.frame(seq_name, sequence)
df <- transform(df, seq_name = colsplit(seq_name, "_f", names = c('1', '2')))
df <- do.call(data.frame, df)

df_split <- df %>% group_split(seq_name.1)
df_split1 <- df_split[[1]][match(df_split[[6]]$seq_name.2, df_split[[1]]$seq_name.2),]
df_split2 <- df_split[[2]][match(df_split[[6]]$seq_name.2, df_split[[2]]$seq_name.2),]
df_split3 <- df_split[[3]][match(df_split[[6]]$seq_name.2, df_split[[3]]$seq_name.2),]
df_split4 <- df_split[[4]][match(df_split[[6]]$seq_name.2, df_split[[4]]$seq_name.2),]
df_split5 <- df_split[[5]][match(df_split[[6]]$seq_name.2, df_split[[5]]$seq_name.2),]
df_split6 <- df_split[[6]][match(df_split[[6]]$seq_name.2, df_split[[6]]$seq_name.2),]

string1 <- list()
string2 <- list()
string3 <- list()
string4 <- list()
string5 <- list()
string6 <- list()
str1 <- list()
str2 <- list()
str3 <- list()
str4 <- list()
str5 <- list()
str6 <- list()
result1n <- list()
result2n <- list()
result3n <- list()
result4n <- list()
result5n <- list()
result6n <- list()

r1 <- list()
r2 <- list()
r3 <- list()
r4 <- list()
r5 <- list()
r6 <- list()

for (i in 1:length(df_split)) { 
  string1[[i]] <-  as.vector(df_split1$sequence)[i]
  string2[[i]] <-  as.vector(df_split2$sequence)[i]
  string3[[i]] <-  as.vector(df_split3$sequence)[i]
  string4[[i]] <-  as.vector(df_split4$sequence)[i]
  string5[[i]] <-  as.vector(df_split5$sequence)[i]
  string6[[i]] <-  as.vector(df_split6$sequence)[i]
  
  str1[[i]] <- str_split(string1, "")[[i]]
  str2[[i]] <- str_split(string2, "")[[i]]
  str3[[i]] <- str_split(string3, "")[[i]]
  str4[[i]] <- str_split(string4, "")[[i]]
  str5[[i]] <- str_split(string5, "")[[i]]
  str6[[i]] <- str_split(string6, "")[[i]]
  
  #compare characters one by one
  result1n[[i]] <- str6[[i]]==str1[[i]]
  result2n[[i]] <- str6[[i]]==str2[[i]]
  result3n[[i]] <- str6[[i]]==str3[[i]]
  result4n[[i]] <- str6[[i]]==str4[[i]]
  result5n[[i]] <- str6[[i]]==str5[[i]]
}

for (i in 1:length(df_split)) { 
  r1[[i]] <- length(result1n[[i]][result1n[[i]] == TRUE])/length(result1n[[i]]) * 100
  r2[[i]] <- length(result2n[[i]][result2n[[i]] == TRUE])/length(result2n[[i]]) * 100
  r3[[i]] <- length(result3n[[i]][result3n[[i]] == TRUE])/length(result3n[[i]]) * 100
  r4[[i]] <- length(result4n[[i]][result4n[[i]] == TRUE])/length(result4n[[i]]) * 100
  r5[[i]] <- length(result5n[[i]][result5n[[i]] == TRUE])/length(result5n[[i]]) * 100
}

r1_values <- data.frame(unlist(r1))
r1_values$group <- "original"
colnames(r1_values) <- c("value", "group")

r2_values <- data.frame(unlist(r2))
r2_values$group <- "10%"
colnames(r2_values) <- c("value", "group")

r3_values <- data.frame(unlist(r3))
r3_values$group <- "2.5%"
colnames(r3_values) <- c("value", "group")

r4_values <- data.frame(unlist(r4))
r4_values$group <- "20%"
colnames(r4_values) <- c("value", "group")

r5_values <- data.frame(unlist(r5))
r5_values$group <- "5%"
colnames(r5_values) <- c("value", "group")

## save each parameter directory separately
r_all <- rbind(r1_values, r2_values, r3_values,r4_values,r5_values)
r_all <- r_all %>% 
  mutate(group = factor(group, levels=c("original", "2.5%", "5%", "10%", "20%")))
chisq.test(as.vector(r1_values$value), as.vector(r2_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r3_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r4_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r5_values$value))

r_all2 <- rbind(r1_values, r2_values, r3_values,r4_values,r5_values)
r_all2 <- r_all2 %>% 
  mutate(group = factor(group, levels=c("original", "2.5%", "5%", "10%", "20%")))
chisq.test(as.vector(r1_values$value), as.vector(r2_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r3_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r4_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r5_values$value))

r_all3 <- rbind(r1_values, r2_values, r3_values,r4_values,r5_values)
r_all3 <- r_all3 %>% 
  mutate(group = factor(group, levels=c("original", "2.5%", "5%", "10%", "20%")))
chisq.test(as.vector(r1_values$value), as.vector(r2_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r3_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r4_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r5_values$value))

r_all4 <- rbind(r1_values, r2_values, r3_values,r4_values,r5_values)
r_all4 <- r_all4 %>% 
  mutate(group = factor(group, levels=c("original", "2.5%", "5%", "10%", "20%")))
chisq.test(as.vector(r1_values$value), as.vector(r2_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r3_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r4_values$value))
chisq.test(as.vector(r1_values$value), as.vector(r5_values$value))

## retreve info
r_all_s <- r_all %>% group_split(group)
mean(r_all_s[[1]]$value)
mean(r_all_s[[2]]$value)
mean(r_all_s[[3]]$value)
mean(r_all_s[[4]]$value)
mean(r_all_s[[5]]$value)
median(r_all_s[[1]]$value)
median(r_all_s[[2]]$value)
median(r_all_s[[3]]$value)
median(r_all_s[[4]]$value)
median(r_all_s[[5]]$value)

## plot 1 directory at a time
p_all <- ggplot(r_all, aes(x = value, fill=group)) + 
  geom_histogram(binwidth = 0.5)  + 
  theme_classic() + xlab("Percent Sequence Similarity") + ylab("Count") 
p_all+scale_fill_manual(values=c("grey","#f0027f","#386cb0","#bf5b17","#66a61e"), name = "Phylogeny Reshuffled")

r_all.melt <- melt(r_all, measure.vars = c("group"))
ggplot(r_all.melt, aes(x = value)) + geom_line(aes(color = group))

## plotting all parameter directories together
p_1 <- ggplot(r1_values, aes(x = value)) + 
  geom_histogram(binwidth = 0.5)  + 
  theme_classic() + xlab("Percent Sequence Similarity") + ylab("Count") + xlim(50,100)
p_2 <- ggplot(r3_values, aes(x = value)) + 
  geom_histogram(binwidth = 0.5, fill="#f0027f")  + 
  theme_classic() + xlab("Percent Sequence Similarity") + ylab("Count")+ xlim(50,100)
p_3 <- ggplot(r5_values, aes(x = value)) + 
  geom_histogram(binwidth = 0.5, fill="#386cb0")  + 
  theme_classic() + xlab("Percent Sequence Similarity") + ylab("Count") + xlim(50,100)
p_4 <- ggplot(r2_values, aes(x = value)) + 
  geom_histogram(binwidth = 0.5, fill="#bf5b17")  + 
  theme_classic() + xlab("Percent Sequence Similarity") + ylab("Count")+ xlim(50,100)
p_5 <- ggplot(r4_values, aes(x = value)) +
  geom_histogram(binwidth = 0.5, fill="#66a61e")  + 
  theme_classic() + xlab("Percent Sequence Similarity") + ylab("Count") + xlim(50,100)

## plot grid
cowplot::plot_grid(ncol=1, p_1, p_2, p_3, p_4, p_5)



