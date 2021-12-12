

```R
3.9 Putting It All Together

In Applied Predictive Modeling there is a case study where the execution times of jobs in a high performance computing environment are being predicted. The data are:

library(AppliedPredictiveModeling)
data(schedulingData)
str(schedulingData)
## 'data.frame':    4331 obs. of  8 variables:
##  $ Protocol   : Factor w/ 14 levels "A","C","D","E",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ Compounds  : num  997 97 101 93 100 100 105 98 101 95 ...
##  $ InputFields: num  137 103 75 76 82 82 88 95 91 92 ...
##  $ Iterations : num  20 20 10 20 20 20 20 20 20 20 ...
##  $ NumPending : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ Hour       : num  14 13.8 13.8 10.1 10.4 ...
##  $ Day        : Factor w/ 7 levels "Mon","Tue","Wed",..: 2 2 4 5 5 3 5 5 5 3 ...
##  $ Class      : Factor w/ 4 levels "VF","F","M","L": 2 1 1 1 1 1 1 1 1 1 ...
The data are a mix of categorical and numeric predictors. Suppose we want to use the Yeo-Johnson transformation on the continuous predictors then center and scale them. Let’s also suppose that we will be running a tree-based models so we might want to keep the factors as factors (as opposed to creating dummy variables). We run the function on all the columns except the last, which is the outcome.

pp_hpc <- preProcess(schedulingData[, -8], 
                     method = c("center", "scale", "YeoJohnson"))
pp_hpc
## Created from 4331 samples and 7 variables
## 
## Pre-processing:
##   - centered (5)
##   - ignored (2)
##   - scaled (5)
##   - Yeo-Johnson transformation (5)
## 
## Lambda estimates for Yeo-Johnson transformation:
## -0.08, -0.03, -1.05, -1.1, 1.44
transformed <- predict(pp_hpc, newdata = schedulingData[, -8])
head(transformed)
##   Protocol  Compounds InputFields  Iterations NumPending         Hour Day
## 1        E  1.2289589  -0.6324538 -0.06155877  -0.554123  0.004586502 Tue
## 2        E -0.6065822  -0.8120451 -0.06155877  -0.554123 -0.043733215 Tue
## 3        E -0.5719530  -1.0131509 -2.78949011  -0.554123 -0.034967191 Thu
## 4        E -0.6427734  -1.0047281 -0.06155877  -0.554123 -0.964170760 Fri
## 5        E -0.5804710  -0.9564501 -0.06155877  -0.554123 -0.902085029 Fri
## 6        E -0.5804710  -0.9564501 -0.06155877  -0.554123  0.698108779 Wed
The two predictors labeled as “ignored” in the output are the two factor predictors. These are not altered but the numeric predictors are transformed. However, the predictor for the number of pending jobs, has a very sparse and unbalanced distribution:

mean(schedulingData$NumPending == 0)
## [1] 0.7561764
For some other models, this might be an issue (especially if we resample or down-sample the data). We can add a filter to check for zero- or near zero-variance predictors prior to running the pre-processing calculations:

pp_no_nzv <- preProcess(schedulingData[, -8], 
                        method = c("center", "scale", "YeoJohnson", "nzv"))
pp_no_nzv
## Created from 4331 samples and 7 variables
## 
## Pre-processing:
##   - centered (4)
##   - ignored (2)
##   - removed (1)
##   - scaled (4)
##   - Yeo-Johnson transformation (4)
## 
## Lambda estimates for Yeo-Johnson transformation:
## -0.08, -0.03, -1.05, 1.44
predict(pp_no_nzv, newdata = schedulingData[1:6, -8])
##   Protocol  Compounds InputFields  Iterations         Hour Day
## 1        E  1.2289589  -0.6324538 -0.06155877  0.004586502 Tue
## 2        E -0.6065822  -0.8120451 -0.06155877 -0.043733215 Tue
## 3        E -0.5719530  -1.0131509 -2.78949011 -0.034967191 Thu
## 4        E -0.6427734  -1.0047281 -0.06155877 -0.964170760 Fri
## 5        E -0.5804710  -0.9564501 -0.06155877 -0.902085029 Fri
## 6        E -0.5804710  -0.9564501 -0.06155877  0.698108779 Wed
Note that one predictor is labeled as “removed” and the processed data lack the sparse predictor.

3.10 Class Distance Calculations

caret contains functions to generate new predictors variables based on distances to class centroids (similar to how linear discriminant analysis works). For each level of a factor variable, the class centroid and covariance matrix is calculated. For new samples, the Mahalanobis distance to each of the class centroids is computed and can be used as an additional predictor. This can be helpful for non-linear models when the true decision boundary is actually linear.

In cases where there are more predictors within a class than samples, the classDist function has arguments called pca and keep arguments that allow for principal components analysis within each class to be used to avoid issues with singular covariance matrices.

predict.classDist is then used to generate the class distances. By default, the distances are logged, but this can be changed via the trans argument to predict.classDist.

As an example, we can used the MDRR data.

centroids <- classDist(trainBC, trainMDRR)
distances <- predict(centroids, testBC)
distances <- as.data.frame(distances)
head(distances)
##                dist.Active dist.Inactive
## PROMETHAZINE      5.810607      4.098229
## ACEPROMETAZINE    4.272003      4.169292
## PYRATHIAZINE      4.570192      4.224053
## THIORIDAZINE      4.548315      5.064125
## MESORIDAZINE      4.621708      5.080362
## SULFORIDAZINE     5.344699      5.145311
This image shows a scatterplot matrix of the class distances for the held-out samples:

xyplot(dist.Active ~ dist.Inactive,
       data = distances, 
       groups = testMDRR, 
       auto.key = list(columns = 2))

```
