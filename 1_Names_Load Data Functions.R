#this file loads the packages and creates the functions that will be used in the model
require(readr)
require(stringr)
require(dplyr)
require(purrr)
require(tokenizers)
require(keras)

# This function loads the raw text of the _saurs
get_saurs <- function() {
  readRDS("data/list_of_extinct_reptiles.RDS") %>%
    str_replace_all("[^[:alnum:] ]", "") %>% # remove any special characters
    tolower
}

add_stop <- function(saurs, symbol="+") {
  str_c(saurs, symbol)
} # make a note for the end of a _saur name

# We want to predict each of the n character on the _saur name. Have to split one
# data point into n data points (where n is the number of characters on the plate).
# So _saur ABC would become data points "A", "AB", and "ABC"
split_into_subs <- function(saurs){
  saurs %>%
    tokenize_characters(lowercase=FALSE) %>%
    map(function(saur) map(1:length(saur),function(i) saur[1:i])) %>%
    flatten()
}

# make each data point the same number of characters by
# adding a padding symbol * to the font
fill_data <- function(saur_characters, max_length = 20){
  saur_characters %>%
    map(function(s){
      if (max_length+1  > length(s)) {
        fill <- rep("*", max_length+1 - length(s))
        c(fill, s)
      } else {
        s
      }
    })
}

# convert the data into vectors that can be used by keras
vectorize <- function(data,characters, max_length){
  x <- array(0, dim = c(length(data), max_length, length(characters)))
  y <- array(0, dim = c(length(data), length(characters)))
  
  for(i in 1:length(data)){
    for(j in 1:(max_length)){
      x[i,j,which(characters==data[[i]][j])] <- 1
    }
    y[i,which(characters==data[[i]][max_length+1])] <- 1
  }
  list(y=y,x=x)
}