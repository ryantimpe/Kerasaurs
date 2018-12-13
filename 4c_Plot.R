# Make a silly plot for the blog

library(tidyverse)
library(png)

source("2_Names_Chart_Functions.R")

phylo1 <- "Archaeopteryx"
phylo2 <- "Bissektipelta"

phylo1.p <- phylo1 %>% 
  import_phylo(100)

phylo2.p <- phylo2 %>% 
  import_phylo(100)

#Adapt plot from Kerasaurs
fill_complement <- sample(c("#ff4040", "#2dd49c", "#5384ff", "#ff25ab", "#ff6141", "#ff9e53"), 1)
fill_grad <- sample(c(fill_complement, "#00436b"), 2, replace = FALSE)


dat.chart <- phylo1.p %>% 
  mutate(x = max(x)-x-110,
         y = y + 5) %>% 
  bind_rows(
    phylo2.p %>% 
      mutate(
        x = x + 150,
        y = y + 60
      )
  )

# Bottom rect details
rect.b.x = 250
rect.b.y = 40
rect.b.padding = 2

dat.chart %>% 
  ggplot() + 
  annotate("polygon", x = c(25, 110, 110), y = c(50, 55, 45), fill = "black") +
  annotate("polygon", x = c(180, 120, 120), y = c(105, 110, 100), fill = "black") +
  geom_raster(aes(x=x, y=y, alpha=value^(1/2), fill = x+y)) +
  scale_fill_gradient(high = fill_grad[1], low = fill_grad[2]) +
  geom_rect(xmin = 0, ymin =0, xmax = rect.b.x, ymax = rect.b.y, fill = "#00436b") +
  geom_rect(xmin = rect.b.padding, ymin =rect.b.padding, 
            xmax = rect.b.x-rect.b.padding, ymax = rect.b.y-rect.b.padding, 
            fill = "#FFD700") +
  geom_rect(xmin = rect.b.padding*3, ymin =rect.b.padding*3, 
            xmax = rect.b.x-rect.b.padding*3, ymax = rect.b.y-rect.b.padding*3, 
            fill =  "#00436b", color = "white", size = 2) +
  annotate("text", x = rect.b.padding*5, y=rect.b.y-rect.b.padding*5,
           label = paste0(toupper(phylo1), " uses convolutional neural networks!\n",
                         "Foe ", toupper(phylo2), " may be overfit."),
           color = "white", hjust = 0, vjust = 1, size = 6) +
  #Dino 1 box
  geom_rect(xmin = rect.b.padding*3+30, ymin = rect.b.y*3-25, 
            xmax = 100+30, ymax = rect.b.y*3-rect.b.padding*3, 
            fill =  "#fffdec", color = "#333333", size = 2) +
  annotate("text", x = rect.b.padding*4+30, y=rect.b.y*3-rect.b.padding*4,
           label = paste0(toupper(phylo2), "\nHP 38/38"), hjust = 0, vjust = 1, size = 5) +
  geom_segment(x = rect.b.padding*4+60, xend = 120, y =rect.b.y*3-rect.b.padding*4-10, yend = rect.b.y*3-rect.b.padding*4-10,
               size = 4, color = "#9affd0", lineend = "round")+
  #Dino 2 box
  geom_rect(xmin = 100, ymin = rect.b.y+2, 
            xmax = 200, ymax = rect.b.y + 20, 
            fill =  "#fffdec", color = "#333333", size = 2) +
  annotate("text", x = rect.b.padding*4+100, y=rect.b.y - rect.b.padding*4 + 25,
           label = paste0(toupper(phylo1), "\nHP 87/87"), hjust = 0, vjust = 1, size = 5) +
  geom_segment(x = rect.b.padding*4+130, xend = 200-10, y = rect.b.y+6, yend = rect.b.y+6,
               size = 4, color = "#9affd0", lineend = "round")+
  coord_fixed(xlim = c(0, rect.b.x), ylim = c(0, rect.b.y*3), expand = FALSE) +
  labs(caption = "@ RyanTimpe .com") +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "#fcedcc"),
    panel.background = element_rect(fill = "#fcedcc"),
    plot.title = element_text(color = "#00436b", size = 18, face = "bold"),
    plot.subtitle = element_text( size = 14),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = "none"
  )


