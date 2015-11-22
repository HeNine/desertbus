data <- read.table(
  "predictions.csv",
  header = T,
  colClasses = c(
    "Date",
    "numeric",
    "numeric","numeric","numeric",
    "factor",
    "factor",
    "numeric"
  ),
  sep = ","
)
summary(data)
n <- nrow(data)

hist(data$DonationTotal)
boxplot(data$DonationTotal)

donation.mean <- mean(data$DonationTotal)
donation.sd <- sd(data$DonationTotal)
donation.error <- qnorm(0.95) * donation.sd / sqrt(n)
dontaion.interval <-
  c(donation.mean - donation.error, donation.mean + donation.error)

hist(data$TotalCrashes)
boxplot(data$TotalCrashes)
  
crashes.mean <- mean(data$TotalCrashes)
crashes.sd <- sd(data$TotalCrashes)
crashes.error <- qnorm(0.95) * crashes.sd / sqrt(n)
crashes.interval <-
  c(crashes.mean - crashes.error, crashes.mean + crashes.error)

points.mean <- mean(data$TotalPoint)
points.sd <- sd(data$TotalPoint)
points.error <- qnorm(0.95) * points.sd / sqrt(n)
points.interval <-
  c(points.mean - points.error, points.mean + points.error)

plot(data$TopDriver)
plot(data$SecondDriver)
