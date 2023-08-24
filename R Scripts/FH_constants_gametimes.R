# field hockey constants

library(tidyverse)
library(tidyr)
library(lubridate)

timestep <- 0.001666665

# HR recovery time window after period end
recovery_strt_tm <- 1/60
recovery_end_tm <- 1 + 30/60

# Penn home field - rwalters RUN
p_lat_0_0 <- 39.94535
p_long_0_0 <- -75.19109
p_lat_0_1 <- 39.94566
p_long_0_1 <- -75.1914353405188
p_lat_1_0 <- 39.94592
p_long_1_0 <- -75.19053
p_lat_1_1 <- 39.9462622100513
p_long_1_1 <- -75.1908873968543

corners_lat <-  c(p_lat_0_0, p_lat_0_1, p_lat_1_1, p_lat_1_0)
corners_long <-  c(p_long_0_0, p_long_0_1, p_long_1_1, p_long_1_0)
corners_df <- as.data.frame(cbind(corners_lat, corners_long))


# Boston College game times
BosCol22_gamestrt <- as.POSIXct('2022-09-09 11:00:00')  + minutes(5) + seconds(25)
# BosCol22_P1_end <- BosCol22_gamestrt + minutes(16) + seconds(55)
# BosCol22_P2_start <- BosCol22_gamestrt + minutes(18) + seconds(50)
# BosCol22_P2_end <- BosCol22_gamestrt + minutes(35) + seconds(50)
# BosCol22_P3_strt <- BosCol22_gamestrt + minutes(42)
# BosCol22_P3_end <- BosCol22_gamestrt + minutes(64)+ seconds(5)
# BosCol22_P4_start <- BosCol22_gamestrt + minutes(67)
# BosCol22_gameend <- BosCol22_gamestrt + minutes(89)+ seconds(50)
# 
# BosCol22_OT1_start <- BosCol22_gamestrt + minutes(92) + seconds(5)
# BosCol22_OT1_end <- BosCol22_gamestrt + minutes(102) + seconds(50)


#################################################

# Delaware game times
Deleware22_gamestrt <- as.POSIXct('2022-10-02 08:00:44')  + minutes(7) + seconds(20)
# Delwr22_P1_end <- Delwr22_gamestrt + minutes(19) + seconds(50)
# Delwr22_P2_start <- Delwr22_gamestrt + minutes(21)
# Delwr22_P2_end <- Delwr22_gamestrt + minutes(37)
# Delwr22_P3_strt <- Delwr22_gamestrt + minutes(45)
# Delwr22_P3_end <- Delwr22_gamestrt + minutes(65)+ seconds(25)
# Delwr22_P4_start <- Delwr22_gamestrt + minutes(78)
# Delwr22_gameend <- Delwr22_gamestrt + minutes(96)
#################################################

# Harvard game times
Harvard22_gamestrt <- as.POSIXct('2022-09-30 11:00:16') + minutes(8)
# Hvrd22_P1_end <- Hvrd22_gamestrt + minutes(16) + seconds(15)
# Hvrd22_P2_start <- Hvrd22_gamestrt  + minutes(18) + seconds(50)
# Hvrd22_P2_end <- Hvrd22_gamestrt + minutes(34) + seconds(10)
# Hvrd22_P3_strt <- Hvrd22_gamestrt + minutes(45) + seconds(50)
# Hvrd22_P3_end <- Hvrd22_gamestrt + minutes(63) + seconds(0)
# Hvrd22_P4_start <- Hvrd22_gamestrt + minutes(66) + seconds(0)
# Hvrd22_gameend <- Hvrd22_gamestrt + minutes(88) + seconds(50)
# 
# Hvrd22_P1_brk_st <- Hvrd22_gamestrt + minutes(74) + seconds(40)
# Hvrd22_P1_brk_end <- Hvrd22_gamestrt + minutes(76) + seconds(50)
# Hvrd22_P2_brk_st <- Hvrd22_gamestrt + minutes(81) + seconds(0)
# Hvrd22_P2_brk_end <- Hvrd22_gamestrt + minutes(83) + seconds(50)
# Hvrd22_P3_brk_st <- Hvrd22_gamestrt + minutes(63) + seconds(0)
# Hvrd22_P3_brk_end <- Hvrd22_gamestrt + minutes(65) + seconds(0)

#############################################################
# Northwestern game times
Northwestern22_gamestrt <- as.POSIXct('2022-09-16 11:00:00') + minutes(7) + seconds(8)
# NWU22_P1_end <- NWU22_gamestrt + minutes(18) + seconds(20)
# NWU22_P2_start <- NWU22_gamestrt + minutes(21)
# NWU22_P2_end <- NWU22_gamestrt + minutes(43)
# NWU22_P3_strt <- NWU22_gamestrt + minutes(56)
# NWU22_P3_end <- NWU22_gamestrt + minutes(75)
# NWU22_P4_start <- NWU22_gamestrt + minutes(78)
# NWU22_gameend <- NWU22_gamestrt + minutes(101)
# 
# NWU22_P2_brk_st <- NWU22_gamestrt + minutes(27)
# NWU22_P2_brk_end <- NWU22_gamestrt + minutes(29) + seconds(30)
##########################################################


# Brown game times
Brown22_gamestrt <- as.POSIXct('2022-10-15 08:09:05')
# Brown22_P1_end <- Brown22_gamestrt + minutes(17) + seconds(20)
# Brown22_P2_start <- Brown22_gamestrt + minutes(21)
# Brown22_P2_end <- Brown22_gamestrt + minutes(40)
# Brown22_P3_strt <- Brown22_gamestrt + minutes(51)
# Brown22_P3_end <- Brown22_gamestrt + minutes(66)+ seconds(25)
# Brown22_P4_start <- Brown22_gamestrt + minutes(78)
# Brown22_gameend <- Brown22_gamestrt + minutes(101)
###########################################################

# LIU game times
LIU22_gamestrt <- as.POSIXct('2022-10-02 08:09:30')
# LIU22_P1_end <- LIU22_gamestrt + minutes(19) + seconds(50)
# LIU22_P2_start <- LIU22_gamestrt + minutes(21)
# LIU22_P2_end <- LIU22_gamestrt + minutes(37)
# LIU22_P3_strt <- LIU22_gamestrt + minutes(45)
# LIU22_P3_end <- LIU22_gamestrt + minutes(65)+ seconds(25)
# LIU22_P4_start <- LIU22_gamestrt + minutes(78)
# LIU22_gameend <- LIU22_gamestrt + minutes(96)
#################################################

# yale game times
Yale22_gamestrt <- as.POSIXct('2022-10-22 08:00:29')  + minutes(7) + seconds(20)
# yale22_P1_end <- yale22_gamestrt + minutes(17) + seconds(20)
# yale22_P2_start <- yale22_gamestrt + minutes(19) + seconds(50)
# yale22_P2_end <- yale22_gamestrt + minutes(42)
# yale22_P3_strt <- yale22_gamestrt + minutes(51)
# yale22_P3_end <- yale22_gamestrt + minutes(74) + seconds(5)
# yale22_P4_start <- yale22_gamestrt + minutes(78)
# 
# yale22_gameend <- yale22_gamestrt + minutes(110)
# yale22_P4_end <- yale22_gamestrt + minutes(98)+ seconds(25)
# 
# yale22_P5_start <- yale22_gamestrt + minutes(102)

#################################################



