
library(caret)

# Machine Learning 

# k nearest neighbour

# Euclidean Distance

library(MASS)
library(dplyr)

table(iris$Species)

head(iris)

data(iris)

# Training / Testing 

TrainData <- iris[,1:4] 
TrainClasses <- iris[,5]

glimpse(TrainData)

glimpse(TrainClasses)

knnFit0 <- train(TrainData, TrainClasses,
                 method = "knn")

table(iris$Species,predict(knnFit0))

knnFit1 <- train(TrainData, TrainClasses,
                 method = "knn",
                 preProcess = c("center", "scale"),
                 trControl = trainControl(method = "cv"))

table(iris$Species,predict(knnFit1))

PreProc <- preProcess(TrainData, method = c("center", "scale"))

PreProc

trainTransf <- predict(PreProc,TrainData)
head(trainTransf)

knnFit2 <- train(TrainData, TrainClasses,
                 method = "knn",
                 preProcess = c("range"),
                 trControl = trainControl(method = "boot"))

table(iris$Species,predict(knnFit2))

### Neural Network Models

nnetFit <- train(TrainData, TrainClasses,
                 method = "nnet",
                 preProcess = "range", 
                 tuneLength = 2,
                 trace = FALSE,
                 maxit = 100)


table(iris$Species,predict(nnetFit))
