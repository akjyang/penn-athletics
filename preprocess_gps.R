install.packages("openxlsx")
install.packages("plotly")
library(openxlsx)
library(lubridate)
library(data.table)
library(dplyr)
library(ggplot2)
library(plotly)
library(hms)

# combine all players' gps info for each game
# "/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek/Brown"
# "dir" is the directory for the game folder
event_gps <- function(dir, event) {
  
  files <- list.files(path = paste0(dir, "/", event), pattern = "*.csv", full.names = TRUE)
  
  df_list <- lapply(files, function(x) {
    df <- fread(x)
    fname <- basename(x)
    fparsed <- unlist(strsplit(fname, "_|\\."))
    df <- mutate(df, athlete = fparsed[-1][1])
    return(df)
  })
  
  combined_df <- bind_rows(df_list)
  return(combined_df)
  
}

import_gtimes <- function(dir) {
  source(dir)
}

import_gtimes("/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek/FH_constants_gametimes.R")

# format for event: in gametimes.R
# format for gametime: HR:MIN:SEC (string)
# format for timernage: number of seconds (int)
find_time <- function(dir, event, gametime, timerange) {
  varname <- paste0(event, "22_gamestrt")
  start_dt <- as.POSIXct(get(varname) + hours(4), tz = "EST")
  
  gtime_vec <- unlist(strsplit(gametime, ":"))
  time_id <- start_dt + hours(gtime_vec[1]) + minutes(gtime_vec[2]) + seconds(gtime_vec[3])
  
  lower <- as.POSIXct(time_id - seconds(timerange), tz = "EST")
  upper <- as.POSIXct(time_id, tz = "EST")
  
  lower_xl <- as.numeric(lower - as.POSIXct("1899-12-30", tz = "EST"))
  upper_xl <- as.numeric(upper - as.POSIXct("1899-12-30", tz = "EST"))

  df <- event_gps(dir, event) %>%
     filter(`Excel Timestamp` >= lower_xl & `Excel Timestamp` <= upper_xl)
  
  df <- df %>%
        mutate(datetime = convertToDateTime(`Excel Timestamp`) + hours(1),
               gametime = as_hms(difftime(datetime, start_dt)),
               datetime = format(datetime, format = "%Y-%m-%d %H:%M:%OS3", tz = "EST"))
  
  return(df)
  
}

temp <- find_time("/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek", "Brown", "00:40:12", 5)

temp <- temp %>%
  mutate(gametime = as.character(gametime)) %>%
  filter(grepl("\\.0$", gametime) | grepl("\\.5$", gametime))

colnames(temp)

for (time in unique(temp$gametime)) {
  
  inst <- temp %>%
    filter(gametime == time) %>%
    ggplot(aes(Speed, `Heart Rate`, color = athlete)) +
    geom_point() +
    theme_bw()
  
  print(ggplotly(inst))
}

