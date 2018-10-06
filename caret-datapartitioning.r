
library(caret)
set.seed(3456)
trainIndex <- createDataPartition(iris$Species, p = .8, 
                                  list = FALSE, 
                                  times = 1)

head(trainIndex,3)

irisTrain <- iris[ trainIndex,]
irisTest  <- iris[-trainIndex,]


library(mlbench)
data(BostonHousing)

testing <- scale(BostonHousing[, c("age", "nox")])
set.seed(5)


## A random sample of 5 data points
startSet <- sample(1:dim(testing)[1], 5)
samplePool <- testing[-startSet,]
start <- testing[startSet,]


newSamp <- maxDissim(start, samplePool, n = 20)
head(newSamp)
## [1] 461 406  49 308 469  76


