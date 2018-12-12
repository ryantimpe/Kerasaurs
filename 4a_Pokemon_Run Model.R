# code that actually runs all the functions
library(tidyverse)
library(tokenizers)
library(keras)
library(rvest)

source("1_Names_Load Data Functions.R")
source("1_Names_Model Functions.R")

# get the plates from the database
pokemon <- read_html("https://pokemondb.net/pokedex/national")

pokemon2 <- pokemon %>% 
  html_nodes(".infocard-list") %>% 
  html_nodes(".ent-name") %>% 
  html_text()

max_length <- max(nchar(pokemon2))

saveRDS(pokemon2, "data/list_of_pokemon.RDS")

# format the _saurs into the appropriate datapoints
Encoding(pokemon2)
iconv(pokemon2,from="UTF-8",to="ASCII//TRANSLIT")

data <- pokemon2 %>%
  #Drop accents, etc
  iconv(from="UTF-8",to="ASCII//TRANSLIT") %>% 
  tolower() %>% 
  str_replace_all("[^[:alnum:] ]", "") %>%
  add_stop() %>%
  split_into_subs() %>%
  fill_data(max_length = max_length)

# create the vector of characters in the data
characters <- data %>% 
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
result <- runif(500,0.5,1.5) %>% #randomly choose diversity for each plate
  map_chr(~ generate_saur(model, characters, max_length, .x))

result_df <- result %>% 
  data_frame(kerasaur = .) %>%
  distinct %>%
  filter(!is.na(kerasaur), kerasaur != "") %>%
  anti_join(data_frame(kerasaur = tolower(pokemon2)), by="kerasaur") %>%  # remove actual animals
  mutate(kerasaur = tools::toTitleCase(kerasaur))


write.csv(result_df, "Output/4a_Pokemon_Output.csv", row.names = F, quote = F)
