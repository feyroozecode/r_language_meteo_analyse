# Charger les bibliothèques
library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)

# Définir le chemin du dossier de travail
setwd("/Users/ahmad/dev/r_projects/etude/new")

# Charger les données
data <- read.csv("datatest.csv", stringsAsFactors = FALSE)

head(data)

# Transformation des dates et heures
data$datetime <- ymd_hms(paste(data$Date, data$Time))
data$hour <- hour(data$datetime)
data$day <- day(data$datetime)
data$month <- month(data$datetime, label = TRUE, abbr = TRUE)

data <- data %>%
  mutate(hour = hour(Date))

# Moyenne par heure
hourly_avg <- data %>%
  group_by(hour) %>%
  summarise(mean_temp = mean(TmaxC, na.rm = TRUE))

# Moyenne par jour
daily_avg <- data %>%
  group_by(day) %>%
  summarise(mean_temp = mean(TmaxC, na.rm = TRUE))

# Moyenne par mois
monthly_avg <- data %>%
  group_by(month) %>%
  summarise(mean_temp = mean(TC, na.rm = TRUE))

# Graphique des températures par heure
ggplot(hourly_avg, aes(x = hour, y = mean_temp)) +
  geom_line() +
  labs(title = "Température moyenne par heure",
       x = "Heure",
       y = "Température moyenne (°C)") +
  theme_minimal()

# Graphique des températures par jour
ggplot(daily_avg, aes(x = day, y = mean_temp)) +
  geom_line() +
  labs(title = "Température moyenne par jour",
       x = "Jour",
       y = "Température moyenne (°C)") +
  theme_minimal()

# Graphique des températures par mois
ggplot(monthly_avg, aes(x = month, y = mean_temp)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Température moyenne par mois",
       x = "Mois",
       y = "Température moyenne (°C)") +
  theme_minimal()

# Exportation des résultats
write.csv(hourly_avg, "output/hourly_avg.csv", row.names = FALSE)
write.csv(daily_avg, "output/daily_avg.csv", row.names = FALSE)
write.csv(monthly_avg, "output/monthly_avg.csv", row.names = FALSE)
