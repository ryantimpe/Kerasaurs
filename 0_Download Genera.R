####
# Download list of genera
####

library(tidyverse); library(rvest)

url_dino     <- "https://en.wikipedia.org/wiki/List_of_dinosaur_genera"
dat_raw_dino <- read_html(url_dino)

url_ptero     <- "https://en.wikipedia.org/wiki/List_of_pterosaur_genera"
dat_raw_ptero <- read_html(url_ptero)

url_mosa     <- "https://en.wikipedia.org/wiki/List_of_mosasaur_genera"
dat_raw_mosa <- read_html(url_mosa)

url_ichthy     <- "https://en.wikipedia.org/wiki/List_of_ichthyosaur_genera"
dat_raw_ichthy <- read_html(url_ichthy)

url_plesio     <- "https://en.wikipedia.org/wiki/List_of_plesiosaur_genera"
dat_raw_plesio  <- read_html(url_plesio)

#Dinosaurs
dino_genera_raw <- dat_raw_dino %>% 
  html_nodes("li i") %>% 
  html_text() 

dino_genera <- unique(dino_genera_raw[!grepl("nomen |nomina ", tolower(dino_genera_raw))])

#Mosasaurs
ptero_genera_raw <- dat_raw_ptero %>% 
  html_nodes("tr td p i") %>% 
  html_text() 

ptero_genera <- unique(ptero_genera_raw)
ptero_genera <- ptero_genera[!grepl(".", ptero_genera, fixed=TRUE)]
ptero_genera <- ptero_genera[!grepl(" ", ptero_genera, fixed=TRUE)]
ptero_genera <- ptero_genera[!grepl("-", ptero_genera, fixed=TRUE)]

#Mosasaurs
mosa_genera_raw <- dat_raw_mosa %>% 
  html_nodes("tr td p i") %>% 
  html_text() 

mosa_genera <- unique(mosa_genera_raw)

#Ichthyosaurs
ichthy_genera_raw <- dat_raw_ichthy  %>% 
  html_nodes("tr td p i") %>% 
  html_text() 

ichthy_genera <- unique(ichthy_genera_raw)
ichthy_genera <- ichthy_genera[!grepl(".", ichthy_genera, fixed=TRUE)]
ichthy_genera <- ichthy_genera[!grepl(" ", ichthy_genera, fixed=TRUE)]

#Plesiosaurs
plesio_genera_raw <- dat_raw_plesio %>% 
  html_nodes("tr td p i") %>% 
  html_text() 

plesio_genera <- unique(plesio_genera_raw)
plesio_genera <- plesio_genera[!grepl(".", plesio_genera, fixed=TRUE)]

#Combined
kerasaurs <- c(dino_genera, ptero_genera, mosa_genera, ichthy_genera, plesio_genera)
kerasaurs <- kerasaurs[!grepl(" ", kerasaurs, fixed=TRUE)]

kerasaurs <- kerasaurs[nchar(kerasaurs) >= 8]

saveRDS(kerasaurs, "data/list_of_extinct_reptiles.RDS")
