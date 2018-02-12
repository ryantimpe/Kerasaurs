#this file loads the packages and creates the functions that will be used in the model
require(readr)
require(stringr)
require(dplyr)
require(purrr)
require(tokenizers)
require(keras)

# This function loads images of animals.
# ... These images are big, so it will scale to the specified size
# ... Want all images to be square, so pad the short size with  0s
import_phylo <- function(phylo_name, facing = "L", side = 50){
  phylo_raw <- readPNG(paste0("PhyloPic/", phylo_name, ".png"))
  
  phylo <- phylo_raw[, , 4] #Only need the transparency matrix
  phylo[phylo == min(phylo)] <- 0 #Some images don't have a complete 0 background
  
  #Reduce resolution to a smaller matrix
  width.to.height = nrow(phylo) / ncol(phylo)

  divisor <- ceiling(max(ncol(phylo), nrow(phylo))/side)
  
  phylo2 <- phylo %>% 
    as.tibble() %>% 
    mutate(y = row_number()) %>% 
    select(y, everything()) %>% 
    gather(x, value, 2:ncol(.)) %>% 
    mutate(x = as.numeric(substr(x, 2, 8))) %>% 
    group_by(x = x %/% divisor, y= y %/% divisor) %>% 
    summarize(value = mean(value)) %>% 
    ungroup() %>% 
    # mutate(y = max(y) - y) %>%
    do( #Want all animals facing left for now
      if(facing == "R"){
        mutate(., x = max(x) - x + 1)
      } else {.}
    ) %>% 
    filter(value > 0) %>% 
    spread(x, value, fill = 0) %>% 
    select(-y) %>% 
    as.matrix()
  
  if(nrow(phylo2) < ncol(phylo2)){
    phylo2 <- rbind(phylo2, matrix(0, nrow = (side - nrow(phylo2)), ncol = ncol(phylo2)))
  }
  
  if(nrow(phylo2) > ncol(phylo2)){
    phylo2 <- cbind(phylo2, matrix(0, nrow = nrow(phylo2), ncol = (side - ncol(phylo2))))
  }
  
  return(phylo2)
    
}

test <- import_phylo("Allosaurus", "L", side=100)
ceiling(test)
Matrix::image(-t(ceiling(test)))
