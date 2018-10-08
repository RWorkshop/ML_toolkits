
glmnet
============

* Glmnet is a package that fits a ***generalized linear model*** via ***penalized maximum likelihood***. 
* The regularization path is computed for the lasso or elasticnet penalty at a grid of values for the regularization parameter lambda. 
* The algorithm is extremely fast, and can exploit sparsity in the input matrix $x$. 
* It fits linear, logistic and multinomial, poisson, and Cox regression models. A variety of predictions can be made from the fitted models. It can also fit multi-response linear regression.

glmnet solves the following problem
$$ minβ0,β1N∑i=1Nwil(yi,β0+βTxi)+λ[(1−α)||β||22/2+α||β||1],$$
over a grid of values of λ covering the entire range. 

* Here l(y,η) is the negative log-likelihood contribution for observation i; e.g. for the Gaussian case it is 12(y−η)2. 
* The elastic-net penalty is controlled by α, and bridges the gap between lasso (α=1, the default) and ridge (α=0). 
* The tuning parameter λ controls the overall strength of the penalty.

#### Installation


```{r}
# install.packages("glmnet", repos = "http://cran.us.r-project.org")
library(glmnet)
```
