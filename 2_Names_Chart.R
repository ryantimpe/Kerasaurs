#####
# Plot kerasaur names
#####

library(tidyverse)

###
#Which PhyloPic image is closest in name to the Kerasaur
###
kerasaurs <- read.csv("2_Names_Output.csv", stringsAsFactors = FALSE)[,1]
phylo <- gsub(".png", "", list.files("PhyloPic")) #
#!!! These pics are not on git... see github.com/ryantimpe/datasaurs for a copy of this folder

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
