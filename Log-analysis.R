library(ggplot2)
library(lubridate)
library(here)
data <- read.delim(here("data", "data.txt"),header=FALSE, comment.char="#")
colnames(data) <- c("date")
data$date <- dmy_hm(data$date)
p <- qplot(data$date, bins=200, binwidth=2500) + xlab("Date")
p
data$time_since <- NA
for (row in 2:nrow(data)){
  data$time_since[row] <- as.numeric(difftime(strptime(data$date[row],"%Y-%m-%d %H:%M:%S"),
                                            strptime(data$date[row-1], "%Y-%m-%d %H:%M:%S"), units = "hours"))
}
mean_time_since <- mean(data$time_since, na.rm = TRUE)
q <- ggplot(data, aes(date,time_since)) + geom_point() + geom_line() +
  geom_hline(yintercept=mean_time_since, linetype="dashed", color = "red")
q

data$date_only <- as.Date(data$date)

freq <- data %>% 
  group_by(date_only) %>% 
  summarise(n=n())

mean_freq <- mean(freq$n)
a <- ggplot(freq, aes(date_only,n)) + geom_point() +geom_line() + 
              geom_hline(yintercept = mean_freq, linetype="dashed", color="red")
a
