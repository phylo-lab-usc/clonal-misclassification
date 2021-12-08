## load packages
require("splits")
require("ape")

##### Run GMYC Function #####
## load phylogeny
phy <- read.tree(file="file_name")

## resolve polytomies
phy2 <- multi2di(phy)

# make ultrametric and ensure all edge lengths are > 0
phy3 <- force.ultrametric(phy2, method = "extend")
phy3$edge.length <- phy3$edge.length+0.01
phy4 <- force.ultrametric(phy3, method = "extend")

## run gmyc function
t1 <- gmyc(phy4)

## summarize cluster information
summary.gmyc(t1)
#plot.gmyc(t1)

## extract species information per cluster
t2 <- spec.list(t1)

## split into each cluster
t3 <- split(t2, t2$GMYC_spec)

## loop to split the original phylogeny into phylogenies of each cluster
# empty list
phy_split <- list()

for (i in 1:length(t3)) {
  phy_sp <- keep.tip(phy, as.vector(t3[[i]]$sample_name))
  phy_split[[i]] <- phy_sp
}

## save all phylogenies 
saveRDS(phy_split, "gmyc_clades.rds")

## save each phylogeny as a separate file (.txt and .tree)
index <- 0 
for(i in 1:length(phy_split)){
  index <- index +1
  output_fn <- paste0("tree_",  index, ".txt") #making unique file name
  write.nexus(phy_split[[i]],file = output_fn )
}

index <- 0 
for(i in 1:length(phy_split)){
  index <- index +1
  output_fn <- paste0("tree_",  index, ".tree") #making unique file name
  write.nexus(phy_split[[i]],file = output_fn )
}

##### Plots #####
t4 <- do.call(rbind.data.frame, t3)
write.csv(t4, "gmyc_info.csv")

info <- read.csv("gmyc_info.csv", header = TRUE) #split columns

## reformat data
summarized_info_gmyc <- info %>% group_by(GMYC_spec) %>% summarize(count=n_distinct(family))
summarized_info_gmyc2 <- info %>% group_by(GMYC_spec) %>% summarize(count=n())
summarized_info_gmyc3 <- cbind(summarized_info_gmyc,summarized_info_gmyc2)
summarized_info_gmyc3 <- summarized_info_gmyc3[,-3]
colnames(summarized_info_gmyc3) <- c("GMYC_spec", "count_unique_families", "count_sequences")
summarized_info_gmyc3 <- summarized_info_gmyc3[with(summarized_info_gmyc3, order(-rank(count_sequences))), ]

## plot
p1 <- ggplot(summarized_info_gmyc3, aes(x=seq_along(GMYC_spec),y=count_sequences, 
                                        fill=count_unique_families)) + 
  geom_bar(stat = "identity") + theme_classic() + xlab("GMYC Delimitation") + 
  ylab("Count Tips") + labs(fill='Number of Partis Families') 
p1 <- p1 + scale_fill_continuous(high = "#67001f", low="#c994c7")

##### Phylogenetic Distance #####
temp <- gtools::mixedsort(list.files(pattern="*.tree")) #load all trees from GMYC
tree0 <- lapply(temp,read.nexus)

## calculate phylogenetic distance
cp0s <- list()
cp02s <- list()
for (i in 1:11) {
  cp0 <- as.data.frame(ape::cophenetic.phylo(tree0[[i]]))
  cp0s[[i]] <- cp0
  cp02 <- tidyr::gather(cp0s[[i]], cols, value)
  cp02s[[i]] <- cp02
} 

no_0 <- list()
dtno_0 <- list()
p_vals <- list()

## run dip.test 
for (i in 1:11) {
  data1 <- cp02s[[i]]$value[cp02s[[i]]$value!=0]
  no_0 [[i]] <- data1
  dtno_0[[i]] <- diptest::dip.test(no_0[[i]])
  p_vals[[i]] <- dtno_0[[i]]$p.value
}

length(p_vals[p_vals <= 0.05])

