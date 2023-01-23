##### Entering the tidyverse(dplyr)
##### 23 January 2023
##### JJM

### tidyverse: collection of packages that share philosophy, grammar, and data structures

## operators: symbols that tell R to perform different operations (Between variables, functions, etc)

## Arithmetic operators: + - / * ^ ~
## Assignment operator: <-
## Logical operators: ! & |
## Relational operators: == != > < >= <= 
## Miscellaneous operators: %>% (Forward Pipe), %in%

### Only need to install packages once

library(tidyverse) #library function to load in packages

# dplyr: new packages that provide a set of tools for manipulating data sets
# specifically written to be fast
# individual functions that correspond to common operations

#### Core verbs
## filter()
## arrange()
## select()
## group_by() and summarize()
## mutate()

## built in data set
data(starwars)
class(starwars)

## Tibble: modern take on data frames
# GReat aspects of dfs and drops frustrating ones (change variables)

glimpse(starwars) # a clear view of the data

### NAs
anyNA(starwars) #is.na, complete.cases

starwarsClean <- starwars[complete.cases(starwars[,1:10]),]

### filter(): picks/subsets observations (rows) by their values

filter(starwarsClean, gender == "masculine" & height < 180)
filter(starwarsClean, gender == "masculine" , height < 180, height > 100) #commas interchangeable with and sign
filter(starwarsClean, gender == "masculine" | gender == "feminine")

#### %in% operator (matching); similar to == but you can compare vectors of different length
# sequence of letter
a <- LETTERS[1:10]
b <- LETTERS[4:10]

## output of %in% operator depends on first vector
a %in% b
b %in% a

# use %in% to subset
filter(starwars, eye_color %in% c("blue", 'brown'))
eyes <- filter(starwars, eye_color %in% c("blue", 'brown'))

## arrange(): Reorders rows

aSt<-arrange(starwars, by = desc(height)) #default is ascending order, can use helper function desc()

arrange(starwarsClean, height, desc(mass)) #second variable breaks ties

sw <- arrange(starwars, by = height)
tail(sw) #missing values are put at the end of the ordering

#### select(): chooses variables (columns) by their names
select(starwarsClean, 1:10)
select(starwarsClean, name:species)
select(starwarsClean, -(films:starships))

### Rearrange columns
select(starwarsClean, name, gender, species, everything()) #everything() is a helper function that stands for every other variable not described

# contains() helper function
select(starwarsClean, contains("color")) #selects the columns with the word color in it
#others include ends_with(), start_with(), num_range()

### Select can also rename columns
select(starwarsClean, haircolor = hair_color) # returns only new column
rename(starwarsClean, haircolor = hair_color) # returns new column + everything else

#### mutate(): create new variables using functions of existing variables
#create a new column that is height / mass
View(mutate(starwarsClean, ratio = height/mass))

starwars_lbs <- mutate(starwarsClean, mass_lbs = mass * 2.2)
starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything())

# transmute - only returns mutates columns
transmute(starwarsClean, mass_lbs = mass*2.2) 
transmute(starwarsClean, mass, mass_lbs = mass*2.2, height) 

#### group_by() and summarize()
summarize(starwarsClean, meanHeight = mean(height))
summarize(starwars, meanHeight = mean(height, na.rm = T))
summarize(starwarsClean, meanHeight = mean(height), TotalNumber = n())

# use group_by for maximum usefulness
starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders)

summarize(starwarsGenders, meanHeight = mean(height, na.rm = T), TotalNumber = n())

# Piping %>%
# Used to emphasize a sequence of actions
# allows you to pass an intermediate result onto the next function  (uses output of one function as input of next function)
#avoid if you need ti manipulate more than one object/variable at a time; or if variable is meaningful
#formatting: should have a space before %>% followed by new line

starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height, na.rm = T), TotalNumber = n())

## case_when(): is useful for multiple if or elif statements
starwarsClean %>%
  mutate(sp = case_when(species == "Human" ~ "Human", TRUE ~ "Non-Human"))

