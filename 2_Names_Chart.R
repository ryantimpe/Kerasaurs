#####
# Plot kerasaur names
#####

library(tidyverse)

###
#Which PhyloPic image is closest in name to the Kerasaur
###
kerasaurs <- read.csv("2_Names_Output.csv", stringsAsFactors = FALSE)[,1]
phylo <- gsub(".png", "", list.files("PhyloPic")) #
#!!! These imagaes are not on git... see github.com/ryantimpe/datasaurs for a copy of this folder

dat_dist <- as.data.frame(adist(kerasaurs, phylo)) %>% 
  mutate(kerasaur = kerasaurs) %>% 
  select(kerasaur, everything()) %>% 
  gather(phylo_index, distance, 2:ncol(.)) %>% 
  #Choose one Phylo pic for each Kerasaur
  group_by(kerasaur) %>% 
  filter(distance == min(distance)) %>% 
  sample_n(1) %>% 
  ungroup() %>% 
  #Choose one Kerasaur for each phylopic
  group_by(phylo_index) %>% 
  sample_n(1) %>% 
  ungroup() %>% 
  mutate(phylo_index = as.numeric(substr(phylo_index, 2, 5))) %>% 
  left_join(tibble(phylo_index = 1:length(phylo), phylo=phylo))

###
# Where on Phylogenetic tree are these kerasaurs?
###

n_kerasaurs <- 15

dat_chart <- dat_dist %>% 
  sample_n(n_kerasaurs) %>% 
  #Deepness of tree - 1 is the starting genus, 4 are the final evolutions
  mutate(tree_x = sample(2:4, n_kerasaurs, prob = c(1,3,4), replace = TRUE),
         tree_x = ifelse(kerasaur == sample(kerasaur, 1), 1, tree_x)) %>% 
  #Vertical location on tree
  group_by(tree_x) %>% 
  mutate(tree_y = ifelse(tree_x == 1, (n_kerasaurs+1)/2, sample(seq(1, n_kerasaurs*(3/2), 2), n()))) %>% 
  ungroup() %>% 
  arrange(tree_x, tree_y)

####
# Import the phylo pic
####
