

```R
library(cvTools)
library("robustbase")

```


```R
data("coleman")
set.seed(1234)  # set seed for reproducibility
```

* Split n observations into K groups to be used for (repeated)
K-fold cross-validation.
* K should thereby be chosen such that all groups are of approximately equal size.


```R
## set up folds for cross-validation
folds <- cvFolds(nrow(coleman), K = 5, R = 10)
folds
```


    
    Repeated 5-fold CV with 10 replications:    
    Fold     1  2  3  4  5  6  7  8  9 10
       1    11 12  7  4 13 16 15  2  2 13
       2    18 14 20 20 16 18 19 11 14  7
       3    10 17  5  3  2  2  4  8  5 15
       4     2  4 19 19 11  4  3 12 13 10
       5    14  5 13  6  5 20 12 14  8  3
       1    13  3 16 12  8  6 10  4  1  6
       2     4 19 12 15 18  8  7  6 12 20
       3    17 18  3  7 20 10  9 19 15  8
       4     1 20 17 11  1 14 14 15  3 19
       5     5  7  9 17  9  7 18  7 16  9
       1    16  1 15  8 15 12 16 10 10 14
       2    20  6 11  1  7  1  6 16 19  4
       3    19 10  1  5  4  5  1  1 18  5
       4     9  8  4 14  3 13 20  5  4 11
       5     7  2 18  9 14 15 13  3  7  1
       1    15  9  2 16 19  9  2 18 17 12
       2     6 13 14 18 17 17  8 17  9 18
       3    12 11 10  2 10 11 11 20 20 17
       4     3 16  6 13  6  3  5 13  6 16
       5     8 15  8 10 12 19 17  9 11  2


*** compare raw and reweighted LTS estimators for 50% and 75% subsets***


```R
# 50% subsets
fitLts50 <- ltsReg(Y ~ ., data = coleman, alpha = 0.5)
```


```R
fitLts50
```


    
    Call:
    ltsReg.formula(formula = Y ~ ., data = coleman, alpha = 0.5)
    
    Coefficients:
    Intercept    salaryP   fatherWc    sstatus  teacherSc  motherLev  
     29.75772   -1.69854    0.08512    0.66617    1.18400   -4.06675  
    
    Scale estimate 1.119 




```R

cvFitLts50 <- cvLts(fitLts50, cost = rtmspe, folds = folds,
fit = "both", trim = 0.1)
```


```R
cvFitLts50
```


    5-fold CV results:
    improved  initial 
    1.140772 1.511817 



```R
# 75% subsets
fitLts75 <- ltsReg(Y ~ ., data = coleman, alpha = 0.75)
cvFitLts75 <- cvLts(fitLts75, cost = rtmspe, folds = folds,
fit = "both", trim = 0.1)
```


```R
# combine results into one object
cvFitsLts <- cvSelect("0.5" = cvFitLts50, "0.75" = cvFitLts75)
cvFitsLts

```


    
    5-fold CV results:
       Fit reweighted      raw
    1  0.5   1.140772 1.511817
    2 0.75   0.963192 1.165930
    
    Best model:
    reweighted        raw 
        "0.75"     "0.75" 



```R
# "cv" object
ncv(cvFitLts50)


```


2



```R
nfits(cvFitLts50)
```


    NULL



```R
cvNames(cvFitLts50)
cvNames(cvFitLts50) <- c("improved", "initial")
fits(cvFitLts50)
```


<ol class="list-inline">
	<li>'improved'</li>
	<li>'initial'</li>
</ol>




    NULL



```R
cvFitLts50
# "cvSelect" object


```


    5-fold CV results:
    improved  initial 
    1.140772 1.511817 



```R
ncv(cvFitsLts)
nfits(cvFitsLts)

```


2



2



```R
cvNames(cvFitsLts)
cvNames(cvFitsLts) <- c("improved", "initial")
```


<ol class="list-inline">
	<li>'reweighted'</li>
	<li>'raw'</li>
</ol>




```R
fits(cvFitsLts)
fits(cvFitsLts) <- 1:2
cvFitsLts
```


<ol class="list-inline">
	<li>1</li>
	<li>2</li>
</ol>




    
    5-fold CV results:
      Fit improved  initial
    1   1 1.140772 1.511817
    2   2 0.963192 1.165930
    
    Best model:
    improved  initial 
           2        2 

