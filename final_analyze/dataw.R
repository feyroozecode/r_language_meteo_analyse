# Load necessary libraries
library(ggplot2)

# Load the data
setwd("/Users/ahmad/dev/r_projects/etude/new")
# Replace 'weather_data.csv' with your actual file path
data <- read.csv("vdpoussieres.csv", sep = ";", stringsAsFactors = FALSE)

# Convert the Date column to Date-Time format
data$Date <- as.POSIXct(data$Date, format = "%d/%m/%Y %H:%M")

# Plot TmaxC and TminC with different colors
ggplot(data, aes(x = Date)) +
  geom_line(aes(y = TmaxC, color = "TmaxC"), size = 1) +
  geom_line(aes(y = TminC, color = "TminC"), size = 1) +
  labs(
    title = "Temperature Curve",
    x = "Date",
    y = "Temperature (°C)",
    color = "Legend"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("TmaxC" = "red", "TminC" = "blue"))
