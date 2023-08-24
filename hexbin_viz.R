library(dplyr)
library(data.table)
library(tidyverse)
install.packages("openxlsx")
library(openxlsx)
library(lubridate)
library(hms)

install.packages("hms")
install.packages("ggplot2")
install.packages("ggforce")
install.packages("devtools")
install.packages("viridis")
devtools::install_github("ChrisAFry/aymR")

library(ggplot2)
library(ggforce)
library(devtools)
library(viridis)
library(aymR)

source("/Users/akjyang/Desktop/Spring 2023/WAF/Useful Functions.R")
source("/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek/FH_constants_gametimes.R")

games_22 <- read.csv("/Users/akjyang/Desktop/Spring 2023/WAF/FH_games-2022.csv")
has_data <- games_22 %>%
  filter(GPS == TRUE,
         Video == TRUE)
has_data$Opponent
# Northwestern, Harvard, Brown

shots_22 <- read.csv("/Users/akjyang/Desktop/Spring 2023/WAF/all_games_goals_shooter.csv")
shots_has_data <- shots_22 %>%
  filter(OP == "Northwestern" |
         OP == "Harvard" |
         OP == "Brown",
         X != "penalty")

harvard <- import_all_player("/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek", "Harvard")
northwestern <- import_all_player("/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek", "Northwestern")
brown <- import_all_player("/Users/akjyang/Desktop/Spring 2023/WAF/GPS_playertek", "Brown")

harvard_gtime <- add_gtime_col(harvard, "game")
northwestern_gtime <- add_gtime_col(northwestern, "game")
brown_gtime <- add_gtime_col(brown, "game")

harvard_scaled <- gps_scale_df(harvard_gtime)
northwestern_scaled <- gps_scale_df(northwestern_gtime)
brown_scaled <- gps_scale_df(brown_gtime)

combined <- rbind(harvard_scaled, northwestern_scaled, brown_scaled) %>%
  mutate(gametime_int = as.integer(round(gametime)))

test <- combined %>%
  filter(athlete == "F16",
         game == "Brown",
         gametime_int == 4552)

ggplot(test) +
  hockey_field("#bfbfbf", "#7CA867", "#ffffff", "#ffffff", .5, .75, 1) +
  geom_point(aes(x = plot_x, y = plot_y))

shots_gps <- left_join(shots_has_data, combined, by = c("OP" = "game", "time_game" = "gametime_int", "goal_scorer_code" = "athlete"), multiple = "all")

shots_gps_clean <- shots_gps %>%
  select("ID", "plot_x", "plot_y", "goal_scorer_name") %>%
  mutate(outcome = ifelse(is.na(goal_scorer_name), 0, 1))

shots_gps_clean

ggplot(shots_gps_clean) +
  stat_summary_hex(aes(x = plot_x, y = plot_y, z = outcome), bins = 17) +
  scale_fill_gradientn(colours = c("#C0F1FF","#FFF3C0","#FFB3B3")) +
  hockey_field_bottom_half("#ffffff", "#ffffff", "#000000", "#000000", .5, .75, 0) +
  labs(fill = "% scored")
