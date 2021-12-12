
library(caret)

library(mlbench)

data()

data(BostonHousing)


head(BostonHousing)

lmFit <- train(medv ~ . ,data = BostonHousing,"lm")


summary(lmFit)

postResample(pred = predict(lmFit), obs = BostonHousing$medv)

### Partial Least Squares

library(pls)
plsFit <- train(medv ~ .,data = BostonHousing,"kernelpls")

postResample(pred = predict(plsFit), obs = BostonHousing$medv)
