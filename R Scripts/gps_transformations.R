install.packages("devtools")
devtools::install_github("ChrisAFry/aymR")
library(tidyverse)
library(ggplot2)
library(ggforce)
library(aymR)

# optional: filter time for in-game
# 1. combine all players' data
# 2. time stamp to just every second

# order of operations:
# 1) combine all players 2) (new function) filter to inputted time stamp 3) filter to plus minus x seconds
# 4) normalize/adjust coordinates 5) plot/export plot for each second with respective file name/title

ll <- c(39.945694, -75.191583)
lr <- c(39.945354, -75.191119)
ul <- c(39.946285, -75.190842)
ur <- c(39.945943, -75.190378)

gps_scale <- function(coord) {
  x_axis <- lr - ll
  y_axis <- ul - ll
  
  from_origin <- matrix(c(coord - ll), 2, 1)
  transform <- matrix(c(x_axis, y_axis), 2, 2)
  
  scaled <- solve(transform) %*% from_origin
  pos <- c(scaled[1,1] * 55, scaled[2,1] * 91.4)
  return(pos)
}

test <- gps_scale(c(39.945749, -75.191033))
test

pos_df <- data.frame(x = test[1], y = test[2])

ggplot(pos_df) + 
  hockey_field("#bfbfbf", "#7CA867", "#ffffff", "#ffffff", .5, .75, 1) + geom_point(aes(x, y))

