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
