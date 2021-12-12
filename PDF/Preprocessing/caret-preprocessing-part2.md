
### Part 5 The preProcess Function

* The preProcess class can be used for many operations on predictors, including centering and scaling. The function preProcess estimates the required parameters for each operation and predict.preProcess is used to apply them to specific data sets. This function can also be interfaces when calling the train function.

* Several types of techniques are described in the next few sections and then another example is used to demonstrate how multiple methods can be used. Note that, in all cases, the preProcess function estimates whatever it requires from a specific data set (e.g. the training set) and then applies these transformations to any data set without recomputing the values


### 6 Centering and Scaling

* In the example below, the half of the MDRR data are used to estimate the location and scale of the predictors. 
* The function ``preProcess`` doesn’t actually pre-process the data. * ``predict.preProcess`` is used to pre-process this and other data sets.



```R

set.seed(96)
inTrain <- sample(seq(along = mdrrClass), length(mdrrClass)/2)

training <- filteredDescr[inTrain,]
test <- filteredDescr[-inTrain,]
trainMDRR <- mdrrClass[inTrain]
testMDRR <- mdrrClass[-inTrain]

preProcValues <- preProcess(training, method = c("center", "scale"))

trainTransformed <- predict(preProcValues, training)
testTransformed <- predict(preProcValues, test)

```

The preProcess option "ranges" scales the data to the interval between zero and one.


#### Part 7 Imputation

* preProcess can be used to impute data sets based only on information in the training set. One method of doing this is with K-nearest neighbors. 
* For an arbitrary sample, the K closest neighbors are found in the training set and the value for the predictor is imputed using these values (e.g. using the mean). 
* Using this approach will automatically trigger preProcess to center and scale the data, regardless of what is in the method argument. Alternatively, bagged trees can also be used to impute. 
* For each predictor in the data, a bagged tree is created using all of the other predictors in the training set. When a new sample has a missing predictor value, the bagged model is used to predict the value. 
* While, in theory, this is a more powerful method of imputing, the computational costs are much higher than the nearest neighbor technique.




```R
3.8 Transforming Predictors

In some cases, there is a need to use principal component analysis (PCA) to transform the data to a smaller sub–space where the new variable are uncorrelated with one another. The preProcess class can apply this transformation by including "pca" in the method argument. Doing this will also force scaling of the predictors. Note that when PCA is requested, predict.preProcess changes the column names to PC1, PC2 and so on.

Similarly, independent component analysis (ICA) can also be used to find new variables that are linear combinations of the original set such that the components are independent (as opposed to uncorrelated in PCA). The new variables will be labeled as IC1, IC2 and so on.

The “spatial sign” transformation (Serneels et al, 2006) projects the data for a predictor to the unit circle in p dimensions, where p is the number of predictors. Essentially, a vector of data is divided by its norm. The two figures below show two centered and scaled descriptors from the MDRR data before and after the spatial sign transformation. The predictors should be centered and scaled before applying this transformation.

```


```R

library(AppliedPredictiveModeling)
transparentTheme(trans = .4)
plotSubset <- data.frame(scale(mdrrDescr[, c("nC", "X4v")])) 
xyplot(nC ~ X4v,
       data = plotSubset,
       groups = mdrrClass, 
       auto.key = list(columns = 2))  


After the spatial sign:

transformed <- spatialSign(plotSubset)
transformed <- as.data.frame(transformed)
xyplot(nC ~ X4v, 
       data = transformed, 
       groups = mdrrClass, 
       auto.key = list(columns = 2)) 


Another option, "BoxCox" will estimate a Box–Cox transformation on the predictors if the data are greater than zero.


```


```R
preProcValues2 <- preProcess(training, method = "BoxCox")
trainBC <- predict(preProcValues2, training)
testBC <- predict(preProcValues2, test)
preProcValues2
## Created from 264 samples and 31 variables
## 
## Pre-processing:
##   - Box-Cox transformation (31)
##   - ignored (0)
## 
## Lambda estimates for Box-Cox transformation:
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -2.0000 -0.2000  0.3000  0.4097  1.7000  2.0000


```


```R
The NA values correspond to the predictors that could not be transformed. This transformation requires the data to be greater than zero. Two similar transformations, the Yeo-Johnson and exponential transformation of Manly (1976) can also be used in preProcess.

```
