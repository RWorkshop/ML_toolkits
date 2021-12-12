
#### Sonar Data Set

# The Sonar data consist of 208 data points collected on 60 predictors. 
# The goal is to predict the two classes (M for metal cylinder or R for rock).

#  ***M*** Metal cylinder 
#  ***R*** Rock



# First, we split the data into two groups: a training set and a test set. 

# To do this, the ``createDataPartition`` function is used




library(caret)
library(mlbench)
data(Sonar)
set.seed(107)


dim(Sonar)

head(Sonar)


#### Partial least squares

# Partial least squares regression (PLS regression) is a statistical method that bears some  relation to principal components regression. 

# Instead of finding hyperplanes of minimum variance between the response and independent variables, it finds a linear regression model by projecting the predicted variables and the observable variables to a new space. 

# Because both the X and Y data are projected to new spaces, the PLS family of methods  are known as bilinear factor models. Partial least squares Discriminant Analysis (PLS-DA) is a variant used when the Y is categorical.



inTrain <- createDataPartition(Sonar$Class, p = .75,list = FALSE)

training <- Sonar[ inTrain,]
testing <- Sonar[-inTrain,]
dim(training)
dim(testing)


plsFit <- train(Class ~ .,
 data = training,
 method = "pls",
 ## Center and scale the predictors for the training
 ## set and all future samples.
 preProc = c("center", "scale"))



ctrl <- trainControl(method = "repeatedcv", repeats = 3)

plsFit <- train(Class ~ .,
                data = training, method = "pls",
                tuneLength = 15, 
                trControl = ctrl,
                preProc = c("center", "scale"))


predict(plsFit,testing)

testing$Class

table(training$Class,predict(plsFit,training))

table(testing$Class,predict(plsFit,testing))

shapiro.test(training$V1)

shapiro.test(log(training$V1))

names(training)

training[,1:60] <-log(training[,1:60])


plsFit2 <- train(Class ~ .,
                data = training, method = "pls",
                tuneLength = 15, 
                trControl = ctrl,
                preProc = c("center", "scale"))


table(training$Class,predict(plsFit2,training))

table(testing$Class,predict(plsFit2,testing))

testing[,1:60] <-log(testing[,1:60])

table(testing$Class,predict(plsFit2,testing))
