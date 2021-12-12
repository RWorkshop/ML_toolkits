
library(caret)

### The Confusion Matrix###

# The function `confusionMatrix()` can be used to compute various summaries for classification
models.




# Random Binary Data Sets
X <- factor(ceiling(runif(1000)-0.20))
Y <- factor(ceiling(runif(1000)-0.25))

# level(X) = c("1","0")

table(X,Y)

# confusionMatrix(Predictions,References)
confusionMatrix(X,Y,positive="1")

precision <- posPredValue(X, Y, positive="1")
recall <- sensitivity(X,Y, positive="1")

F1 <- (2 * precision * recall) / (precision + recall)

precision
recall

F1
