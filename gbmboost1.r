
https://rpubs.com/chengjiun/52658

library(gbm)

## gbm fitting
set.seed(123)
fitControl <- trainControl(method = 'cv', number = 6, summaryFunction=defaultSummary)
Grid <- expand.grid( n.trees = seq(50,1000,50), interaction.depth = c(30), shrinkage = c(0.1))



formula <- lgcount ~ season + holiday + workingday + weather + temp + atemp + humidity + windspeed + hour + wday + month + year
fit.gbm <- train(formula, data=subTrain, method = 'gbm', trControl=fitControl,tuneGrid=Grid,metric='RMSE',maximize=FALSE)



plot(fit.gbm)
plot(gbmVarImp)
