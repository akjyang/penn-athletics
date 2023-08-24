library(dplyr)
library(data.table)
library(tidyverse)
library(lubridate)

# Importing GPS data for all relevant games
import_all_player <- function(dir, event) {
  files <- list.files(path = paste0(dir, "/", event), pattern = "*.csv", full.names = TRUE)
  df_list <- lapply(files, function(x) {
    df <- fread(x)
    fname <- basename(x)
    fparsed <- unlist(strsplit(fname, "_|\\."))
    df <- mutate(df, athlete = fparsed[-1][1])
    return(df)
  })
  combined_df <- bind_rows(df_list) %>%
    add_column(game = event)
  return(combined_df)
}

# Import game start time data
import_gtimes <- function(dir) {
  source(dir)
}
import_gtimes("/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek/FH_constants_gametimes.R")

# Add a game time column
add_gtime_col <- function(df, game_col) {
  varname <- paste0(df[[game_col]][1], "22_gamestrt")
  gamestart <- get(varname) + hours(4)
  ans <- df %>%
    mutate(dt_converted = convertToDateTime(`Excel Timestamp`),
           gametime = as.numeric(as_hms(difftime(dt_converted, gamestart))))
  return(ans)
}

# Scale GPS coordinates to plottable
gps_scale <- function(lat, lon) {
  ll <- c(39.945694, -75.191583)
  lr <- c(39.945354, -75.191119)
  ul <- c(39.946285, -75.190842)
  ur <- c(39.945943, -75.190378)
  coord <- c(lat, lon)
  x_axis <- lr - ll
  y_axis <- ul - ll
  from_origin <- matrix(c(coord - ll), 2, 1)
  transform <- matrix(c(x_axis, y_axis), 2, 2)
  scaled <- solve(transform) %*% from_origin
  pos <- c(scaled[1,1] * 55, scaled[2,1] * 91.4)
  return(pos)
}

# Apply GPS scaling function to data frame
# Requires coordinate column names to be Longitude and Latitude
gps_scale_df <- function(df) {
  ans <- df %>%
    rowwise() %>%
    mutate(plot_x = gps_scale(Latitude, Longitude)[1],
           plot_y = gps_scale(Latitude, Longitude)[2]) %>%
    ungroup()
  return(ans)
}
  