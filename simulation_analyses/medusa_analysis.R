## load packages
library(geiger)

## run MEDUSA in geiger R package
tree <- read.tree(file="*.bestTree")
tree <- multi2di(tree)
tree$edge.length <- tree$edge.length + 0.01
tree <- phytools::force.ultrametric(tree, method = "extend")
m1 <- medusa(tree)
print(m1$summary)


