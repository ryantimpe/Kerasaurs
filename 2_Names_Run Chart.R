#####
# Plot kerasaur names
#####

library(tidyverse)
library(png)

source("2_Names_Chart_Functions.R")

###
#Which PhyloPic image is closest in name to the Kerasaur
###
kerasaurs <- read.csv("Output/2_Names_Output_ptero_highertemp.csv", stringsAsFactors = FALSE)[,1]
phylo <- gsub(".png", "", list.files("PhyloPic")) #
#!!! These imagaes are not on git... see github.com/ryantimpe/datasaurs for a copy of this folder

#Drop some non-saur images
phylo <- phylo[!(phylo %in% c("Hyaenodon", "Camelus ferus", "Coelodonta antiquitatis",
                              "Coelodonta", "Dromornis", "Hoffstetterius",
                              "Ictitherium", "Libralces", "Megacerops", "Megaloceraos", 
                              "Menoceras", "Mesonyx", "Oxydactylus", "Prothoatherium", "Raphus",
                              "Suminia", "Theosodon", "Vulpes", "Kakuru"))]


#Run Functions
n_kerasaurs <- 16
phylo_resolution <- 32

n_kerasaurs %>% 
  find_similar_phylopic(phylo) %>% 
  create_tree_data( n_kerasaurs, phylo_resolution) %>% 
  generate_tree(phylo_resolution)

# c("Ponysaurus", sample(kerasaurs, 20)) %>% 
#   find_similar_phylopic(phylo) %>% 
#   create_tree_data( n_kerasaurs, phylo_resolution) %>% 
#   generate_tree(phylo_resolution)

###Version for Blog image

# generate_tree_long <- function(dat_phylo, phylo_resolution){
#   y_set <- phylo_resolution
#   
#   widen <- 30
#   
#   dat_phylo_raster <- dat_phylo %>% 
#     unnest() %>% 
#     mutate(x = round(x + round((tree_x - 0.1)*y_set*widen)), 
#            y = round(y + (tree_y -    0)*y_set))
#   
#   x_time <- seq(0, max(dat_phylo$tree_x*y_set*widen), y_set*3)
#   x_start <- sample(200:100, 1)
#   x_axis <- seq(x_start, x_start-30, length.out = length(x_time))
#   
#   dat_x_labs <- data.frame(x = seq(0, max(dat_phylo$tree_x*y_set*widen), y_set*3))
#   
#   clade_name <- dat_phylo %>% 
#     filter(tree_x == 1) %>% 
#     pull(kerasaur)
#   
#   fill_complement <- sample(c("#ff4040", "#2dd49c", "#5384ff", "#ff25ab", "#ff6141", "#ff9e53"), 1)
#   fill_complement <- "#2dd49c"
#   fill_grad <- sample(c(fill_complement, "#00436b"), 2, replace = FALSE)
#   
#   dat_phylo %>% 
#     ggplot(aes(x = tree_x*y_set*widen, y = tree_y*y_set*1)) + 
#     geom_point() +
#     geom_segment(aes(xend = tree_x_prev*y_set*widen, yend = tree_y_prev*y_set*1)) +
#     geom_raster(data = dat_phylo_raster, aes(x=x, y=y, alpha=value^(1/2), fill = x+y)) +
#     scale_fill_gradient(high = fill_grad[1], low = fill_grad[2]) +
#     geom_label(aes(label = kerasaur), 
#                nudge_x = (y_set*6), nudge_y = (-y_set/3), alpha = 0.75,
#                fontface = "bold", size = 5) +
#     scale_x_continuous(breaks = x_time, labels = x_axis, name = "million years ago") + 
#     coord_fixed() +
#     labs(title = paste(clade_name, "phylogenetic tree"),
#          subtitle = "Deep learning dinosaur names using Keras",
#          caption = "@RyanTimpe .com") +
#     theme_bw() +
#     theme(
#       plot.background = element_rect(fill = "#fcedcc"),
#       panel.background = element_rect(fill = "#fcedcc"),
#       plot.title = element_text(color = "#00436b", size = 18, face = "bold"),
#       plot.subtitle = element_text( size = 14),
#       axis.text.y = element_blank(),
#       axis.text.x = element_text(color = "black", size = 12),
#       axis.title.y = element_blank(),
#       axis.title.x = element_text(color = "black", size = 14),
#       axis.ticks = element_blank(),
#       panel.grid.major = element_blank(), 
#       panel.grid.minor = element_blank(),
#       legend.position = "none"
#     )
# }
# 
# kerasaurs %>% 
#   find_similar_phylopic(phylo) %>% 
#   create_tree_data( n_kerasaurs, phylo_resolution*2) %>% 
#   generate_tree_long(phylo_resolution)
