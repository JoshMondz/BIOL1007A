##### Simple Data Analysis and More Complex Control Structures
##### 30 January 2023
##### LVA

dryadData <- read.table(file = "Data/veysey-babbit_data_amphibians.csv", header = TRUE, sep = ",")

library(tidyverse)
library(ggthemes)

### Analyses
### Expiremental designs
### independent/explanatory variable (x-axis) vs dependent/response variable (y-axis)

### Continuous (range of numbers: heighht, weight, temperature) vs discrete/categirucal (Categories: Species, Treatments, site)

### x = cont, y = cont -> Linear regresssion/scatterplot
### x = cat, y = cont -> t-test,Anova, and Box Plot/Bar plot
### x = cont, y = cat -> Logistic regression
### x = cat, y = cat -> chi-squared, table, mosaic plot

glimpse(dryadData)
### Basic linear regression analysis ( 2 continuous variables)
## Is there a relationship between the mean pool hydroperiod and the number of breeding frogs caught?
## y ~ x
regModel <- lm(count.total.adults ~ mean.hydro, data = dryadData)
print(regModel)
summary(regModel)
hist(regModel$residuals)


regPlot <- ggplot(data = dryadData, aes(x = mean.hydro, y = count.total.adults + 1)) +
  geom_point(size = 2) +
  stat_smooth(method = "lm", se = 0.99)
regPlot + theme_few()

### Basic ANOVA
### Was there a statistically significant difference in the number of adults among wetlands
#y~x

ANOmodel <- aov(count.total.adults ~ factor(wetland), data = dryadData)
summary(ANOmodel)

dryadData %>%
  group_by(factor(wetland)) %>%
  summarise(avgHydro = mean(count.total.adults), na.rm = T, N = n())

### Boxplot

dryadData$wetland <- factor(dryadData$wetland)

ANOplot <- ggplot(data = dryadData, mapping = aes(x = wetland, y = count.total.adults, fill = species)) +
  geom_boxplot() +
  scale_fill_grey()
ANOplot

ggsave(file = "SpeciesBoxplots.pdf", plot = ANOplot, device = "pdf")

### Logistical regression
## Data Frame
# gamma probabilities - continuous variables that are always positibe and have a skewed distribution

xVar <- sort(rgamma(n=200, shape = 5, scale = 5))
yVar <- sample(rep(c(1,0), each = 100), prob = seq_len(200))
logRegData <- data.frame(xVar, yVar)

### Logistic regression model
logRegModel <- glm(yVar ~ xVar, data = logRegData, family = binomial(link = logit)) #Specifys logistic regression
summary(logRegModel)

logRegPlot <- ggplot(data = logRegData, aes(x = xVar, y = yVar)) + 
  geom_point() +
  stat_smooth(method = "glm", method.args = list(family = binomial))
logRegPlot


### Contingency table (chi-squared) Analysis
### Are there differences in counts of males and femalses between species?

countData <- dryadData %>%
  group_by(species) %>%
  summarize(Males = sum(No.males,na.rm=T), Females = sum(No.females, na.rm=TRUE)) %>%
  select(-species) %>%
  as.matrix()
countData

row.names(countData) = c("SS", "WF")

## chi-squared 
## get residuals
chisq.test(countData)$residuals

mosaicplot(x = countData, col = c("goldenrod", "grey"), shade = F)

### bar plot

countDataLong <-countData %>%
  as_tibble() %>%
  mutate(Species = c(rownames(countData))) %>%
  pivot_longer(cols = Males:Females, names_to = "Sex", values_to = "Count")

ggplot(countDataLong, aes(x = Species, y = Count, fill = Sex)) +
  geom_bar(stat = "identity", position = "dodge") + 
  scale_fill_manual(values = c("darkslategrey", "midnightblue"))

#######################################################################
#### Control Structures

# if and ifelse statements

##### if statement
#### if (condition) {Expression 1}

### Nested if statements if(){expresssion} else{ if () {expression}}

z <- signif(runif(1), digits = 2)
z > 2.8

### use {} or 
if (z >= 0.8){ cat(z, "is a large number", "\n")} else
    if (z < 0.2){ cat(z, "is a small number", "\n")} else 
      {cat(z, "is a number of typical size", "\n")
      cat("z^2 = ", z^2, "\n") 
      y <- T }

### ifelse to fill vectors

### ifelse(condition, yes, no)

### incesct population where the females lay 10.2 eggs on average, follows poisson distribution (discrete probibility distribution showing the likely number of times an event will occur). 35% parasitism where no eggs are laid. Lets make a distribution for 1000 individuals
tester <- runif(1000)
eggs <- ifelse(tester > 0.35, rpois(n = 1000, lambda = 10.2), 0)
hist(eggs)    

#### vector of p values from a simulation and we want to create a vector to highlight the significant ones for plotting  
pVals <- runif(1000)
z <- ifelse(pVals <= 0.025, "lowerTail", "notSig")
z[pVals >= 0.975] <- "upperTail"
table(z)

##### for loops
### workhorse function for doing repetitive tasks
### universal in all computer languages
### controversial in R - often not necessary
### very slow
### there already exists a family of apply functions

#### anatomy of a for loop
### for(var in seq){ Starts for loop
#body
#}
# var is a counter variable that holds the current value of the loop
# sequence is an integer vector that defines the starting and endpoints of a loop
# counter variables (i,j,k)

for(i in 1:5){
  cat("Stuck in a loop", i, "\n")
  cat(3+2, "\n")
  cat(3+i, "\n")
}

### use a counter variable that maps to the position of each element
my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
for(i in 1: length(my_dogs)) {
  cat("i=", i, "my_dogs[i]=", my_dogs[i], "\n")
}

#### use double for loops
m <- matrix(round(runif(20), digits = 2), nrow = 5)
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i 
}
m
for (i in 1:nrow(m)) {
  for (k in 1:ncol(m)){
    m[i,k] <- m[i,k] + i + k
  }
}
m

m <- matrix(round(runif(20), digits = 2), nrow = 5)
for(j in 1:ncol(m)){
  m[,j] <- m[,j] + j
}
