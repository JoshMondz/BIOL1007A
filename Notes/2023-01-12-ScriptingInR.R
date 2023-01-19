##### Programming in R
##### January 12th 2023
##### JJM

#  Advantages
## Interactive use
## graphics, statistics
## very active community of contributors
## works on multiple platforms

#  Disadvantages
## lazy evaluation
## Some packages are poorly documented
## Some functions are hard to learn (Steep learning curve)
## Unreliable packages
## Problems with big data (Multiple GBs)

# Lets start with the basic

## Assignment operator: Used to assign a new value to a variable

x <- 5
print(x)
x

y = 4 #Legal but not used except in function arguments
y = y + 1.1

y <- y + 1.1

## Variables: used to store information (a container)

z <- 3 #Single letter variables
plantHeight <- 10 #camel case format
plant_height <- 3.3 # snake case format (preferred method)
plant.height <- 4.2 # best to stay away from this method
. <- 5.5 #Reserved for temporary variable

## Functions: blocks of code that perform a task; use short command over again instead of writing out that block of code multiple times

# You can create your own functions

square <- function(x = NULL){
  x <- x^2
  print(x)
}
z = 103
square(x=3) # The argument name is x
square(z)

### ore there are built in functions
sum (109, 3, 10) ### Look at package info using ?sum or going to help panel

#### Atomic Vectors
# One Dimensional (a single row)
# One of the most fundamental data structure in R Programming

### Types
# character strings (Within quotes)
# integers (whole numbers)
# double (real numbers, decimals)
# both integers and doubles are numeric
# Logical (Boolean) (TRUE or FALSE)
# factor (Categorizes, groups variable)

# c function (combine)
z <- c(3.2, 5, 5, 6)
print (z)
class(z) # Returns class of variable
typeof(z) # returns type of variable
is.numeric(z) #returns T/F

## c() always flattens to a vector
z <- c (c(3,4), c(5,6))

# character vectors
z <- c("perch", "bass", "trout")
print(z)
z <- c("this is only 'one' character string", "a second", "a third")
print(z)
typeof(z)
is.character(z)

z<-c(TRUE, FALSE, T, F)
typeof(z)
is.logical(z)
z<-as.character(z)

# Tyoe
# is.numeric / as.character
# typeof()

# Length
length(z)
dim(z) #NULL because vectors are 1 dimension

## Name
z <- runif(5)
names(z) #NULL (No names)

# add names
names(z) <- c("chow", "pug", "beagle", "greyhound", "atika")
names(z) #Shows names now
print(z)
names(z) <- NULL #Will erase names


#### NA
### missing data
z <- c(3.2,3.5,NA)
typeof(z) #will return the type of the other data points
sum(z) #this and many other functions will return a NA because there is a NA

#check for NAs
anyNA(z)
is.na(z)
which(is.na(z)) #Helpful for exploring data and determining where NA's are

## Subsetting vectors
# vectors are indexed
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z[4] #Use square brackets to subset by index
z[c(4,5)] #need to use c for multiple indicies
z[-c(2,3)] # minus signs to exclude elements
z[-1]
z[z==7.5] # z==7.5 is a Boolean, in brackets it returns the target value. Logical statement
z[z<7.5] # Use logical statements within brackets to subset by conditions
which(z < 7.5) #which outputs indices
z[which(z<7.5)] #in square brackets, it outputs exact values

## subsetting characters (named elements)
names(z) <- c("a","b","c","d","e")
z[c("a","d")]

# subset 
subset(x = z, subset = z > 1.5)

# Randomly Sampled
# Sample function
story_vec <- c("A", "Frog", "Jumped", "Here")
sample(story_vec)

# Randomly select 3 elements from vector
sample(story_vec, size=3)

story_vec <- c(story_vec[1], "Green", story_vec[2:4])
story_vec[2] <- "Blue"

# Vector Functions
vec <- vector(mode = "numeric", length=5)

# rep and seq functions
z <- rep(x=0, times = 100)
z <- rep(x = 1:4, each=3)

z <- seq(from = 2, to = 4)
z <- seq(from = 2, to = 4, by = 0.5)
seq(from=1, to =length(z))
