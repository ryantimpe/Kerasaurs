# code that actually runs all the functions
library(readr)
library(stringr)
library(dplyr)
library(purrr)
library(tokenizers)
library(keras)

source("1_Names_Load Data Functions.R")
source("1_Names_Model Functions.R")

# Set the max length of the _saurs
max_length <- 20

# get the plates from the database
kerasaurs <- get_saurs()

# format the _saurs into the appropriate datapoints
data <-
  kerasaurs %>%
  add_stop() %>%
  split_into_subs() %>%
  fill_data(max_length = max_length)

# create the vector of characters in the data
characters <- 
  data %>% 
  flatten() %>% 
  unlist() %>% 
  unique() %>% 
  sort()

# make the vector/3D-array as the y and x data for keras
vectors <- vectorize(data, characters, max_length)

# initialize the model
model <- create_model(characters, max_length)

# iterate the model
iterate_model(model, characters, max_length, diversity, vectors, 50)

# create the result
result2 <- 
  runif(250,0.2,0.8) %>% #randomly choose diversity for each plate
  map_chr(~ generate_saur(model, characters, max_length, .x))

result_df <- result %>% 
  data_frame(kerasaur = .) %>%
  distinct %>%
  filter(!is.na(kerasaur), kerasaur != "") %>%
  anti_join(data_frame(kerasaur = kerasaurs), by="kerasaur") %>%  # remove actual animals
  mutate(kerasaur = tools::toTitleCase(kerasaur))


write.csv(result_df, "2_Names_Output.csv", row.names = F, quote = F)
