#####
# Plot kerasaur names
#####

library(tidyverse)
library(png)

source("2_Names_Chart_Functions.R")

###
#Which PhyloPic image is closest in name to the Kerasaur
###
kerasaurs <- read.csv("Output/2_Names_Output_ptero.csv", stringsAsFactors = FALSE)[,1]
phylo <- gsub(".png", "", list.files("PhyloPic")) #
#!!! These imagaes are not on git... see github.com/ryantimpe/datasaurs for a copy of this folder

#Drop some non-saur images
phylo <- phylo[!(phylo %in% c("Hyaenodon", "Camelus ferus", "Coelodonta antiquitatis",
                              "Coelodonta", "Dromornis", "Hoffstetterius",
                              "Ictitherium", "Libralces", "Megacerops", "Megaloceraos", 
                              "Menoceras", "Mesonyx", "Oxydactylus", "Prothoatherium", "Raphus",
                              "Suminia", "Theosodon", "Vulpes"))]


#Run Functions
n_kerasaurs <- 16
phylo_resolution <- 32

kerasaurs %>% 
  find_similar_phylopic(phylo) %>% 
  create_tree_data( n_kerasaurs, phylo_resolution) %>% 
  generate_tree(phylo_resolution)
