library(ggplot2)
library(lubridate)
data <- read.delim("/cloud/project/data/data.txt",header=FALSE, comment.char="#")
colnames(data) <- c("date")
data$date <- dmy_hm(data$date)
p <- qplot(data$date, bins=200, binwidth=2500) + xlab("Date")
p
