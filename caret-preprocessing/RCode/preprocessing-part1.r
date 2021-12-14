
install.packages("caret")

library(caret)


library(earth)
data(etitanic)
head(model.matrix(survived ~ ., data = etitanic),3)


dummies <- dummyVars(survived ~ ., data = etitanic)
head(predict(dummies, newdata = etitanic),3)



data(mdrr)
data.frame(table(mdrrDescr$nR11))
##   Var1 Freq
## 1    0  501
## 2    1    4
## 3    2   23



nzv <- nearZeroVar(mdrrDescr, saveMetrics= TRUE)
nzv[nzv$nzv,][1:10,]
##        freqRatio percentUnique zeroVar  nzv
## nTB     23.00000     0.3787879   FALSE TRUE
## nBR    131.00000     0.3787879   FALSE TRUE
## nI     527.00000     0.3787879   FALSE TRUE
## nR03   527.00000     0.3787879   FALSE TRUE
## nR08   527.00000     0.3787879   FALSE TRUE
## nR11    21.78261     0.5681818   FALSE TRUE
## nR12    57.66667     0.3787879   FALSE TRUE
## D.Dr03 527.00000     0.3787879   FALSE TRUE
## D.Dr07 123.50000     5.8712121   FALSE TRUE
## D.Dr08 527.00000     0.3787879   FALSE TRUE


dim(mdrrDescr)
## [1] 528 342
nzv <- nearZeroVar(mdrrDescr)
filteredDescr <- mdrrDescr[, -nzv]
dim(filteredDescr)
## [1] 528 297



descrCor <-  cor(filteredDescr)
highCorr <- sum(abs(descrCor[upper.tri(descrCor)]) > .999)



descrCor <- cor(filteredDescr)
summary(descrCor[upper.tri(descrCor)])
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.99610 -0.05373  0.25010  0.26080  0.65530  1.00000


highlyCorDescr <- findCorrelation(descrCor, cutoff = .75)
filteredDescr <- filteredDescr[,-highlyCorDescr]
descrCor2 <- cor(filteredDescr)
summary(descrCor2[upper.tri(descrCor2)])
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.70730 -0.05378  0.04418  0.06692  0.18860  0.74460


ltfrDesign <- matrix(0, nrow=6, ncol=6)
ltfrDesign[,1] <- c(1, 1, 1, 1, 1, 1)
ltfrDesign[,2] <- c(1, 1, 1, 0, 0, 0)
ltfrDesign[,3] <- c(0, 0, 0, 1, 1, 1)
ltfrDesign[,4] <- c(1, 0, 0, 1, 0, 0)
ltfrDesign[,5] <- c(0, 1, 0, 0, 1, 0)
ltfrDesign[,6] <- c(0, 0, 1, 0, 0, 1)

comboInfo <- findLinearCombos(ltfrDesign)
comboInfo
## $linearCombos
## $linearCombos[[1]]
## [1] 3 1 2
## 
## $linearCombos[[2]]
## [1] 6 1 4 5
## 
## 
## $remove
## [1] 3 6


ltfrDesign[, -comboInfo$remove]
##      [,1] [,2] [,3] [,4]
## [1,]    1    1    1    0
## [2,]    1    1    0    1
## [3,]    1    1    0    0
## [4,]    1    0    1    0
## [5,]    1    0    0    1
## [6,]    1    0    0    0

