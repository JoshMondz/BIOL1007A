##### Finishing up Matricies and Data Frames
##### 19 January 2023
##### JJM

m <- matrix(data = 1:12, nrow=3)

## Subsetting based on elements
m[1:2, ]
m[,2:4]

## subset with logical (conditional) statements
## select all columns for which totals are > 15

colSums(m) > 15 #colSums sums up the columns
m[,colSums(m)>15]

m[rowSums(m) == 22, ]
m[rowSums(m) != 22, ]

### Logical operators: == = > <

## Subsetting to a vector changes the data type
z <- m[1,]
str(z)

z2 <- m[1,, drop = F ] #Drop = FALSE means that it stays as a matrix rather than turning to a vector like z
str(z2)

#simulate new matrix
m2 <- matrix(data = runif(9), nrow = 3)
m2
m2[3,2]

## Use assignment operator to substitute values
m2[m2 > 0.6] <- NA
m2

data <- iris
head(data) #First 6 rows
tail(data) #last 6 rows

data[3,2] #Indicies still work

dataSub <- data[,c("Species", "Petal.Length")]

#### sort a data frame by values
orderedIris <- iris[order(iris$Petal.Length),]
head(orderedIris)


#################### FUNCTIONS #################################

# Everything in R is a function
# ex
sum(3,2)
3 + 2
sd #Shows the code of a function
sum


### User Defined functions

#functionName <- function(argX = defaultX, argY = defaultY){
#  Curley Brackets starts the body of the functions
#  Create local variables (only visable to R within the function)
#  return(z)
#}

myFunc <- function(a=3, b=4){
  z <- a + b
  return(z)
}

myFuncBad <- function(a = 3){       #Does Not Work
  z <- a + b
  return(z)
}

### Multiple return statements

#########################################################################
# FUNCTION: HardyWeinberg
# input: all allele frequency p(0,1)
# output: p and the frequencies of 3 genotypes AA AB BB
#-----------------------------------------------------------------------
HardyWeinberg <- function(p = runif(1)){
  if(p > 1.0 | p < 0.0){
    return("Function failure: p must be between 0 and 1")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p = p, AA =fAA, AB = fAB, BB=fBB), digits = 3)
  return(vecOut)
}
#########################################################################


### Create a complex default value
#########################################################################
#Function: fitLinear2
# fits a simple regression line
# input: list of predictor (x)  and response (y)
# outputs: slope and p-value

fitLinear2 <- function(p=NULL){
  if(is.null(p)){
    p <- list(x = runif(20), y = runif(20))
  }
  myMod <- lm(p$x~p$y)
  myOut <- c(slope = summary(myMod)$coefficients[2,1], pValue = summary(myMod)$coefficients[2,4])
  plot(x = p$x, y = p$y)
  return(myOut)
}

myPars <- list(x=1:10, y=runif(10))


