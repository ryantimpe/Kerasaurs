####
# Classify pokemon or extinct animal
####

library(tidyverse)
library(tidytext)
library(keras)

set.seed(12334)

#Consolidate data  ----

animals <- readRDS("data/list_of_extinct_reptiles.RDS") %>%
  str_replace_all("[^[:alnum:] ]", "") %>% # remove any special characters
  tolower

pokemon <- readRDS("data/list_of_pokemon.RDS") %>%
  iconv(from="UTF-8",to="ASCII//TRANSLIT") %>% 
  str_replace_all("[^[A-Za-z] ]", "") %>% # remove any special characters
  tolower %>% 
  unique()

full_data <- tibble(Category = "Animal", Name = animals) %>% 
  bind_rows(tibble(Category = "Pokemon", Name = pokemon)) %>% 
  arrange(Name) %>% 
  distinct()

train_data <- full_data %>% 
  sample_frac(0.8)

test_data <- full_data %>% 
  anti_join(train_data)

# Descriptive stats on Train data ---
train_data %>% 
  count(Category)

train_data %>% 
  group_by(Category) %>% 
  summarize(chars = mean(nchar(Name)))

#Classification with Keras ----
source("1_Names_Load Data Functions.R")
source("1_Names_Model Functions.R")

max_length <- 20

pad_data <- function(dat, max_length){
  dat %>% 
    map_chr(function(x, max_length){
      y <- str_c(paste0(rep("*", max(0, max_length - nchar(x))), collapse=""), x)
      return(y)
    }, max_length)
}

x_train <- train_data$Name %>% 
  pad_data(max_length)

characters <- x_train %>% 
  tokenize_characters(strip_non_alphanum = FALSE) %>% 
  flatten() %>% 
  unlist() %>% 
  unique() %>% 
  sort()

# make the vector/3D-array as the y and x data for keras
# convert the data into vectors that can be used by keras
vectorize <- function(dat, characters, max_length){
  x <- array(0, dim = c(length(dat), max_length))
  
  for(i in 1:length(dat)){
    for(j in 1:(max_length)){
      x[i,j] <- which(characters==substr(dat[[i]], j, j)) - 1
    }
  }
  x
}

x_train_v <- x_train %>% vectorize(characters, max_length)

y_train <- as.numeric(train_data$Category == "Pokemon")

vocab_size <- length(characters)

#This model specification is borrowed heavily from the RStudio example
# https://keras.rstudio.com/articles/tutorial_basic_text_classification.html

model <- keras_model_sequential()
model %>% 
  layer_embedding(input_dim = vocab_size, output_dim = 16) %>%
  layer_global_average_pooling_1d() %>%
  layer_dense(units = 16, activation = "relu") %>%
  layer_dense(units = 1, activation = "sigmoid")

model %>% summary()

model %>% compile(
  optimizer = 'adam',
  loss = 'binary_crossentropy',
  metrics = list('accuracy')
)

#Validation, training
validation_size <- sample(1:nrow(x_train_v), 250)
partial_x_train <- x_train_v[-validation_size, ]
partial_y_train <- y_train[-validation_size]

x_val <- x_train_v[validation_size, ]
y_val <- y_train[validation_size]

#Save these batches ----
saveRDS(x_train, "SplitData/x_train.RDS")
saveRDS(y_train, "SplitData/y_train.RDS")
saveRDS(partial_x_train, "SplitData/partial_x_train.RDS")
saveRDS(partial_y_train, "SplitData/partial_y_train.RDS")
saveRDS(x_val, "SplitData/x_val.RDS")
saveRDS(y_val, "SplitData/y_val.RDS")
saveRDS(x_test, "SplitData/x_test.RDS")
saveRDS(test_data$Category, "SplitData/y_test.RDS")

history <- model %>% fit(
  partial_x_train,
  partial_y_train,
  epochs = 80,
  batch_size = 512,
  validation_data = list(x_val, y_val),
  verbose=1
)


#Predict test data ----

x_test <- test_data$Name %>% 
  pad_data(max_length)

x_test_v <- x_test %>%  vectorize(characters, max_length)

final_res <- test_data %>% 
  mutate(pred_raw = model %>% predict(x_test_v),
         pred = round(pred_raw*100),
         pred_cat = ifelse(round(pred_raw, 0 ) == 1, "Pokemon", "Animal"),
         conf = abs(pred_raw - 0.5) + 0.5,
         conf2 = case_when(
           conf > 0.8 ~ "3 - High",
           conf > 0.6 ~ "2 - Med",
           TRUE ~ "1 - Low"
         )) %>% 
  mutate(validation = Category == pred_cat)

final_res %>% 
  count(Category, validation) %>% 
  group_by(Category) %>% 
  mutate(perc = n / sum(n))

final_res %>% 
  count(Category, validation, conf2) %>% 
  mutate(perc = n / sum(n)) %>% 
  select(-n) %>% 
  spread(conf2, perc, fill = 0)

saveRDS(final_res, "Data/4b_Output_TestResults.RDS")
save(model, file = "Data/4b_Models")

# Make up a name ----
made_up <- c("Electro", "Electrosaur", "Buttosaur", "Buzzsaur")

made_up_v <- made_up %>% 
  tolower() %>% 
  pad_data(max_length) %>% 
  vectorize(characters, max_length)

model %>% predict(made_up_v)

# What about the generated animal and pokemon names?

kerasaurs <- read_csv("Output/2_Names_Output_ptero_highertemp.csv") %>% 
  mutate(Category = "Animal") %>% 
  bind_rows(read_csv("Output/4a_Pokemon_Output.csv") %>% 
              mutate(Category = "Pokemon")) %>% 
  rename(Name = kerasaur) %>% 
  arrange(Name)

kerasaurs_pred <- kerasaurs$Name %>% 
  tolower() %>% 
  str_replace_all("[^[A-Za-z] ]", "") %>%
  pad_data(max_length) %>%  
  vectorize(characters, max_length)
  
kerasaurs2 <- kerasaurs %>% 
  mutate(pred_raw = model %>% predict(kerasaurs_pred),
         pred = round(pred_raw*100),
         pred_cat = ifelse(round(pred_raw, 0 ) == 1, "Pokemon", "Animal"),
         conf = abs(pred_raw - 0.5) + 0.5,
         conf2 = case_when(
           conf > 0.8 ~ "3 - High",
           conf > 0.6 ~ "2 - Med",
           TRUE ~ "1 - Low"
         )) %>% 
  mutate(validation = Category == pred_cat)

kerasaurs2 %>% 
  count(Category, validation) %>% 
  group_by(Category) %>% 
  mutate(perc = n / sum(n))


kerasaurs2 %>% 
  count(Category, validation, conf2) %>% 
  mutate(perc = n / sum(n)) %>% 
  select(-n) %>% 
  spread(conf2, perc, fill = 0)

saveRDS(kerasaurs2, "Data/4b_Output_Kerasaurs.RDS")
