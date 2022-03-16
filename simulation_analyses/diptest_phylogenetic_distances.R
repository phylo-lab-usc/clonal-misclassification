## dip.test for phylogenetic distances to assess unimodality
## outputs for different levels of resampling are in a separate folder

library(tidyr)
library(ape)
library(phytools)
library(ggplot2)
require(gtools)
library(diptest)
library(cowplot)

## load original trees
temp <- mixedsort(list.files(pattern=".*bestTree"))
tree0 <- lapply(temp,read.tree)

## calculate pd
cp0s <- list()
cp02s <- list()
for (i in 1:length(temp)) {
  cp0 <- as.data.frame(ape::cophenetic.phylo(tree0[[i]]))
  cp0s[[i]] <- cp0
  cp02 <- tidyr::gather(cp0s[[i]], cols, value)
  cp02s[[i]] <- cp02
  cp02s[[i]]$group <- "0%"
  cp02s[[i]] <- cp02s[[i]][cp02s[[i]]$value != 0,] #remove 0s since these are distances between the same tip
} 

## load resampled at 2.5%
temp2 <- mixedsort(list.files(pattern=".*bestTree"))
tree2.5 <- lapply(temp2,read.tree)

## calculate pd
cp01s <- list()
cp01.2s <- list()
for (i in 1:length(temp2)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree2.5[[i]]))
  cp01s[[i]] <- cp01
  cp01.2 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.2s[[i]] <- cp01.2
  cp01.2s[[i]]$group <- "2.5%"
  cp01.2s[[i]] <- cp01.2s[[i]][cp01.2s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 

## load resampled at 5% 
temp3 <- mixedsort(list.files(pattern=".*bestTree"))
tree5 <- lapply(temp3,read.tree)

## calculate pd
cp01s <- list()
cp01.3s <- list()
for (i in 1:length(temp3)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree5[[i]]))
  cp01s[[i]] <- cp01
  cp01.3 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.3s[[i]] <- cp01.3
  cp01.3s[[i]]$group <- "5%"
  cp01.3s[[i]] <- cp01.3s[[i]][cp01.3s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 

## load resampled at 10% 
temp4 <- mixedsort(list.files(pattern=".*bestTree"))
tree10 <- lapply(temp4,read.tree)

## calculate pd
cp01s <- list()
cp01.4s <- list()
for (i in 1:length(temp4)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree10[[i]]))
  cp01s[[i]] <- cp01
  cp01.4 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.4s[[i]] <- cp01.4
  cp01.4s[[i]]$group <- "10%"
  cp01.4s[[i]] <- cp01.4s[[i]][cp01.4s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 

## load resampled at 20% 
temp5 <- mixedsort(list.files(pattern=".*bestTree"))
tree20 <- lapply(temp5,read.tree)

## calculate pd
cp01s <- list()
cp01.5s <- list()
for (i in 1:length(temp5)) {
  cp01 <- as.data.frame(ape::cophenetic.phylo(tree20[[i]]))
  cp01s[[i]] <- cp01
  cp01.5 <- tidyr::gather(cp01s[[i]], cols, value)
  cp01.5s[[i]] <- cp01.5
  cp01.5s[[i]]$group <- "20%"
  cp01.5s[[i]] <- cp01.5s[[i]][cp01.5s[[i]]$value != 0,]  #remove 0s since these are distances between the same tip
} 

## join for plotting examples
together <- list()
for (i in 1:length(temp5)) {
  tg <- rbind(cp02s[[i]], cp01.2s[[i]], cp01.3s[[i]], cp01.4s[[i]], cp01.5s[[i]])
  together[[i]] <- tg
  together[[i]] <- together[[i]][together[[i]]$value != 0,]
}

p_eg <- ggplot(together[[263]], aes(x = value, fill=group)) + 
  geom_histogram(binwidth = 0.01) + 
  theme_classic() + xlab("Phylogenetic Distance") + ylab("Count")
p_eg

## dip.test for all trees 

## original
data0s <- list()
dts0 <- list()
p_vals0 <- list()
for (i in 1:length(temp5)) {
  data0 <- cp02s[[i]]$value[cp02s[[i]]$value!=0]
  data0s[[i]] <- data0
  dts0[[i]] <- dip.test(data0s[[i]])
  p_vals0[[i]] <- dts0[[i]]$p.value
}

p1 <- length(p_vals0[p_vals0 <= 0.05])/length(p_vals0) #type 1 error

## 2.5%
data1s <- list()
dts1 <- list()
p_vals1 <- list()
for (i in 1:length(temp5)) {
  data1 <- cp01.2s[[i]]$value[cp01.2s[[i]]$value!=0]
  data1s[[i]] <- data1
  dts1[[i]] <- dip.test(data1s[[i]])
  p_vals1[[i]] <- dts1[[i]]$p.value
}

p2 <-length(p_vals1[p_vals1 <= 0.05])/length(p_vals1)

## 5%
data3s <- list()
dts3 <- list()
p_vals3 <- list()
for (i in 1:length(temp5)) {
  data3 <- cp01.3s[[i]]$value[cp01.3s[[i]]$value!=0]
  data3s[[i]] <- data3
  dts3[[i]] <- dip.test(data3s[[i]])
  p_vals3[[i]] <- dts3[[i]]$p.value
}

p3 <-length(p_vals3[p_vals3 <= 0.05])/length(p_vals3)

## 10%
data4s <- list()
dts4 <- list()
p_vals4 <- list()
for (i in 1:length(temp5)) {
  data4 <- cp01.4s[[i]]$value[cp01.4s[[i]]$value!=0]
  data4s[[i]] <- data4
  dts4[[i]] <- dip.test(data4s[[i]])
  p_vals4[[i]] <- dts4[[i]]$p.value
}

p4 <-length(p_vals4[p_vals4 <= 0.05])/length(p_vals4)

## 20%
data5s <- list()
dts5 <- list()
p_vals5 <- list()
for (i in 1:length(temp5)) {
  data5 <- cp01.5s[[i]]$value[cp01.5s[[i]]$value!=0]
  data5s[[i]] <- data5
  dts5[[i]] <- dip.test(data5s[[i]])
  p_vals5[[i]] <- dts5[[i]]$p.value
}

p5 <-length(p_vals5[p_vals5 <= 0.05])/length(p_vals5)

## record p1, p2, p3, p4, p5 into df
diptest_df <- read.csv("diptest_all.csv", header=TRUE)

dt <- ggplot(diptest_df, aes(x = resample, y=diptest, color=as.factor(pd))) + 
  geom_point() +
  theme_classic() + xlab("Resampling % ") + ylab("% Phylogenetic Distances Not Unimodal") +
  labs(colour="Parameter Directory") + scale_color_manual(values = c("#1b9e77","#ce1256","#7570b3","#a6761d"))  

dt + geom_line()

## alternative method to dip.test using Mclust (GMM)
library(mclust)

## load original trees
temp <- mixedsort(list.files(pattern=".*bestTree"))
tree0 <- lapply(temp,read.tree)

## calculate pd
cp0s <- list()
cp02s <- list()
for (i in 1:length(temp)) {
  cp0 <- as.data.frame(ape::cophenetic.phylo(tree0[[i]]))
  cp0s[[i]] <- cp0
  cp02 <- tidyr::gather(cp0s[[i]], cols, value)
  cp02s[[i]] <- cp02
  cp02s[[i]]$group <- "0%"
  cp02s[[i]] <- cp02s[[i]][cp02s[[i]]$value != 0,] #remove 0s since these are distances between the same tip
} 

data0s <- list()
dts0 <- list()
dts0.1 <- list()
p_vals0 <- list()
result0 <- list()
for (i in 1:length(cp02s)) {
  data0 <- cp02s[[i]]$value[cp02s[[i]]$value!=0]
  data0s[[i]] <- data0
  dts0[[i]] <- Mclust(data0s[[i]])
  dts0.1[[i]] <- Mclust(data0s[[i]], G=1)
  result0[[i]] <- logLik(dts0[[i]])-logLik(dts0.1[[i]])
  p_vals0[[i]] <- 1-pchisq(result0[[i]], df=dts0[[i]]$df-dts0.1[[i]]$df)
}

#number of significant simulations that have >1 cluster
p_vals0_edit <- as.numeric(p_vals0)
p1 <- length(p_vals0_edit[p_vals0_edit <= 0.05])/length(p_vals0_edit) #type 1 error

#number of  simulations that have >1 cluster
clusters0 <- list()
for (i in 1:length(cp02s)) {
  clusters0[[i]] <- dts0[[i]]$G
}
c1 <- length(clusters0[clusters0 > 1])/length(clusters0)

## plot dip.test and GMMs
diptest_data <- read.csv("diptest_GMM.csv", header=TRUE)

dt <- ggplot(diptest_data, aes(x = resample, y=diptest, color=as.factor(pd))) + 
  geom_point() +
  theme_classic() + xlab("Resampling % ") + ylab("% Phylogenetic Distances Not Unimodal") +
  labs(colour="Parameter Directory") + scale_color_manual(values = c("#377eb8","#e41a1c","#4daf4a","#984ea3"))  

dt <- dt + geom_line()

gmm <- ggplot(diptest_data, aes(x = resample, y=GMM_proportion_g_1, color=as.factor(pd))) + 
  geom_point() +
  theme_classic() + xlab("Resampling % ") + ylab("% GMMs with Greater than 1 Cluster") +
  labs(colour="Parameter Directory") + scale_color_manual(values = c("#377eb8","#e41a1c","#4daf4a","#984ea3")) 

gmm <- gmm + geom_line()

plot_grid(dt, gmm, nrow = 2, labels = c("A", "B"))


