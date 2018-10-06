
Compute the prediction loss of a model.
==========================================


```R
library(cvTools)
```

    Loading required package: lattice
    Loading required package: robustbase



```R
# fit an MM-regression model
data("coleman")
fit <- lmrob(Y~., data=coleman)
# compute the prediction loss from the fitted values
# (hence the prediction loss is underestimated in this simple
# example since all observations are used to fit the model)

```


```R
mspe(coleman$Y, predict(fit))
rmspe(coleman$Y, predict(fit))
mape(coleman$Y, predict(fit))
```


```R

tmspe(coleman$Y, predict(fit), trim = 0.1)
rtmspe(coleman$Y, predict(fit), trim = 0.1)
```


3.84933128253749



1.96197127464637



1.06196185384444



0.412606171798511



0.642344278248441



```R
# include standard error
mspe(coleman$Y, predict(fit), includeSE = TRUE)
rmspe(coleman$Y, predict(fit), includeSE = TRUE)
mape(coleman$Y, predict(fit), includeSE = TRUE)
```


```R


tmspe(coleman$Y, predict(fit), trim = 0.1, includeSE = TRUE)
rtmspe(coleman$Y, predict(fit), trim = 0.1, includeSE = TRUE)
```


<dl>
	<dt>$mspe</dt>
		<dd>3.84933128253749</dd>
	<dt>$se</dt>
		<dd>2.68482686209083</dd>
</dl>




<dl>
	<dt>$rmspe</dt>
		<dd>1.96197127464637</dd>
	<dt>$se</dt>
		<dd>0.684216659230844</dd>
</dl>




<dl>
	<dt>$mape</dt>
		<dd>1.06196185384444</dd>
	<dt>$se</dt>
		<dd>0.378471183879563</dd>
</dl>




<dl>
	<dt>$tmspe</dt>
		<dd>0.412606171798511</dd>
	<dt>$se</dt>
		<dd>0.225963167329786</dd>
</dl>




<dl>
	<dt>$rtmspe</dt>
		<dd>0.642344278248441</dd>
	<dt>$se</dt>
		<dd>0.175889452884945</dd>
</dl>


