#### Vectors, Matrices, Lists, Data frames
#### 17 January 2023
#### JJM

## Coercion

### All atomic vectors are of the same data type
### If you use c() to assemble different types, R coerces them
### logical -> integer -> double -> character

a <- c(2,2.2) #Integer and double
a #coerces to double

b <- c("purple", "green")
typeof(b)

d <- c(a,b) #will coerce to character since its the lowest common type
typeof(d)

### comparison operators yield a logical result

a <- runif(10)
print(a)

a > 0.5 #conditional statement

### How many elements in the vector are > 0.5
sum(a>0.5)
mean(a>0.5) #what proportion of vector are greater than 0.5


### Vectorization
## add a constant to a vector

z <- c(10, 20, 30)
z + 1 #will do the operation for each element
z * 2
z^2

## what happens when vectors are added together
y <- c(1,2,3)

z + y # results in an "element by element" operation on the vector

## Recycling
# what if vector lengths are not equal

z
x <- c(1,2) 
z + x #warning is issued but the calculation is made by having the shorter vector be recycled (its looped through )

#### Simulating data: runif() and rnorm()

runif(5) #or runif(n=5)
runif(n = 5, min = 5, max = 10) #can change the min and max as well

set.seed(123) #With set seed, sets the random number generator to make the random numbers reproducible. MUST SET THE SEED EACH TIME YOU RUN RANDOM
hist(runif(n = 100, min = 5, max = 10)) #historgram is flat because of uniform distribution

set.seed(111) #will be diffeent
runif(n = 5, min = 5, max = 10)

## rnorm: random normal values with mean of 0 and standard deviation of 1
randomNormalNumbers<-rnorm(1000000)
mean(randomNormalNumbers) #hist function shows distribution
hist(randomNormalNumbers)

hist(rnorm(n=100, mean=100, sd=30))#visualize the arguments of rnorm


#### Matrices
## two dimensional (rows and columns)
## homogenous data type

# matrix is an atomic vector organized into rows and columns

myVec <- 1:12

m <- matrix(data = myVec, nrow = 4) #matrix with 4 rows

m <- matrix(data = myVec, ncol = 3, byrow=T) #matrix with 3 columns filled in my row

#### Lists
## One dimensional
## heterogeneous data types

myList <- list(1:10, matrix(1:8, 4, byrow = T), letters[1:3], pi)
class(myList)
str(myList)  

### sub-setting list
## usimg [] gives you a single item but not then elements
myList[4]
myList[3] - 3 #Cannot do because its not pointing to an element

myList[[4]] #must use [[]] to grab elements
myList[[4]] - 3

myList[[2]][4,1] #You can also grab specific datapoints within the structures
myList[[3]][2]

### name list items when they are created
myList2 <- list(Tester = F, littleM = matrix(1:9,3))
myList2$Tester #list name then $ allows for you to call the part of the list by name
myList2$littleM[2,3] #second row third column of littleM
myList2$littleM[2,]
myList2$littleM[,2]

myList2$littleM[2] #If you give numbers without columns, it will just return that element

### unlist to string everything back to vector
unRolled <- unlist(myList2)
unRolled <- unlist(myList)

data(iris)
head(iris)
plot(Sepal.Length ~ Petal.Length, data = iris) #y~x
model <- lm(Sepal.Length ~ Petal.Length, data = iris)
results <- summary(model)

str(results)
results$coefficients

## Two ways to get specific values from results
results$coefficients[2,4]
unlistedResults<-unlist(results)
unlistedResults$coefficients8 


#### Data Frames
## Equal length vectors each of which is a column

varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"), each = 4)
varC <- runif(12)

dFrame <- data.frame(varA, varB, varC, stringsAsFactors = FALSE)


# add another row
newData <- list(13, "HighN", 0.668)


#Use rbind()
dFrame<-rbind(dFrame, newData)

#Why cant we use c
newData2 <- c(14, "HighN", 0.668) #This is a vector so it gets coerced to being characters

##Add a column
newVar <- runif(13)

#Use cbind()
dFrame <- cbind(dFrame, newVar)

### Data Frames vs Matrices
zMat <- matrix(1:30,ncol = 3, byrow=T)
zDframe <- as.data.frame(zMat)

zMat[3,3]
zDframe[3,3]

zMat[,3]
zDframe[,3]
zDframe$V3 #cant do with matrix

#### Eliminating NAs
# complete.cases() function
zD <- c(NA, rnorm(10), NA, rnorm(3))
complete.cases(zD) #gives logical output

#clean out nas
zD[complete.cases(zD)]
which(!complete.cases(zD))
which(is.na(zD))

#use with matrix
m <- matrix(1:20,5)
m[1,1] <- NA
m[5,4] <- NA
complete.cases(m) #gives T/F as to whether whole row is 'complete' (no NAs)
m[complete.cases(m),]

## get complete cases for only certain rows
m[complete.cases(m[,c(1,2)]),]
