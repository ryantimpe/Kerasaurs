#####
# Plot kerasaur names
#####

library(tidyverse)
library(png)

###
# First round of sampling - finds a unique phylopic for a subset of kerasaurs
###
find_similar_phylopic <- function(kerasaurs, phylo){
  as.data.frame(adist(kerasaurs, phylo)) %>% 
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
}




####
# Import the phylo pic
####

import_phylo <- function(phylo_name, height = 25){
  phylo_raw <- readPNG(paste0("PhyloPic/", phylo_name, ".png"))
  
  phylo <- phylo_raw[, , 4] #Only need the transparency matrix
  
  #Reduce resolution to a smaller matrix
  width.to.height = nrow(phylo) / ncol(phylo)
  
  mcol <- ceiling(ncol(phylo)/height * width.to.height)
  mrow <- ceiling(nrow(phylo)/height)
  
  phylo2 <- phylo %>% 
    as.tibble() %>% 
    mutate(y = row_number()) %>% 
    select(y, everything()) %>% 
    gather(x, value, 2:ncol(.)) %>% 
    mutate(x = as.numeric(substr(x, 2, 8))) %>% 
    group_by(x = x %/% mcol, y= y %/% mrow) %>% 
    summarize(value = mean(value)) %>% 
    ungroup() %>% 
    mutate(y = max(y) - y) %>% 
    filter(value > 0)
}


###
# Where on Phylogenetic tree are these kerasaurs?
###

create_tree_data <- function(dat, n_kerasaurs, phylo_resolution){
  n_ker <- min(n_kerasaurs, 20)
  n_ker <- max(n_ker, 10)
  rem_ker <- max(5, n_ker - 9)
  
  y_set <- phylo_resolution
  
  dat %>% 
    sample_n(n_ker) %>% 
    #Deepness of tree - 1 is the starting genus, 4 are the final evolutions
    mutate(tree_x = sample(c(1, rep(2, 3), rep(3, 5), rep(4, rem_ker)), n_kerasaurs, replace = FALSE)) %>% 
    mutate(tree_x = ifelse(!(1 %in% tree_x) & row_number() == floor(n_ker/2), 1, tree_x)) %>% 
    #Vertical location on tree
    group_by(tree_x) %>% 
    mutate(tree_y = case_when(
      tree_x == 1 ~ (n_kerasaurs*(3/2)+1)/2,
      tree_x == 2 ~ (row_number()-0.5)*round(n_kerasaurs*(3/2))/n(),
      TRUE ~ sample(seq(1, n_kerasaurs*(3/2), 2), n())
    )) %>% 
    # mutate(tree_y = ifelse(tree_x == 1, (n_kerasaurs*(3/2)+1)/2, sample(seq(1, n_kerasaurs*(3/2), 2), n()))) %>% 
    ungroup() %>% 
    arrange(tree_x, tree_y)%>% 
    select(-phylo_index, -distance) %>% 
    mutate(tree_size = sample(1:5, nrow(.), replace =TRUE)) %>% 
    left_join(select(., -phylo) %>% 
                rename(tree_size_prev = tree_size) %>% 
                filter(tree_x != 4) %>% 
                spread(kerasaur, tree_y) %>% 
                mutate(tree_x = tree_x + 1)) %>% 
    gather(kerasaur_node, tree_y_prev, 7:ncol(.)) %>%
    mutate(dist = abs(tree_y - tree_y_prev),
           dist = ifelse(tree_x == 1, 1, dist)) %>% 
    group_by(kerasaur) %>% 
    filter(dist == min(dist, na.rm=T)) %>% 
    sample_n(1) %>% 
    ungroup() %>% 
    mutate(tree_x_prev = ifelse(tree_x == 1, NA, tree_x - 1)) %>% 
    select(-dist) %>% 
    mutate(phylo_pic = purrr::map(phylo, import_phylo, height = y_set))
}

generate_tree <- function(dat_phylo, phylo_resolution){
  y_set <- phylo_resolution
  
  dat_phylo_raster <- dat_phylo %>% 
    unnest() %>% 
    mutate(x = round(x + round((tree_x - 0.1)*y_set*4)), 
           y = round(y + (tree_y -    0)*y_set))
  
  x_time <- seq(0, max(dat_phylo$tree_x*y_set*5), y_set*3)
  x_start <- sample(200:100, 1)
  x_axis <- seq(x_start, x_start-30, length.out = length(x_time))
  
  dat_x_labs <- data.frame(x = seq(0, max(dat_phylo$tree_x*y_set*4), y_set*3))
  
  clade_name <- dat_phylo %>% 
    filter(tree_x == 1) %>% 
    pull(kerasaur)
  
  fill_complement <- sample(c("#ff4040", "#2dd49c", "#5384ff", "#ff25ab"), 1)
  fill_grad <- sample(c(fill_complement, "#00436b"), 2, replace = FALSE)
  
  dat_phylo %>% 
    ggplot(aes(x = tree_x*y_set*4, y = tree_y*y_set)) + 
    geom_point() +
    geom_segment(aes(xend = tree_x_prev*y_set*4, yend = tree_y_prev*y_set)) +
    geom_raster(data = dat_phylo_raster, aes(x=x, y=y, alpha=value^(1/2), fill = x+y)) +
    scale_fill_gradient(high = fill_grad[1], low = fill_grad[2]) +
    geom_label(aes(label = kerasaur), 
               nudge_x = (y_set), nudge_y = (-y_set/3), alpha = 0.75,
               fontface = "bold", size = 2.5) +
    scale_x_continuous(breaks = x_time, labels = x_axis, name = "million years ago") + 
    coord_fixed(xlim = c(y_set*2, y_set*20)) +
    labs(title = paste(clade_name, "phylogenetic tree"),
         subtitle = "Deep learning dinosaur names using Keras",
         caption = "@RyanTimpe .com") +
    theme_bw() +
    theme(
      plot.background = element_rect(fill = "#fcedcc"),
      panel.background = element_rect(fill = "#fcedcc"),
      plot.title = element_text(color = "#00436b", size = 18, face = "bold"),
      plot.subtitle = element_text( size = 14),
      axis.text.y = element_blank(),
      axis.text.x = element_text(color = "black", size = 12),
      axis.title.y = element_blank(),
      axis.title.x = element_text(color = "black", size = 14),
      axis.ticks = element_blank(),
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(),
      legend.position = "none"
    )
}


