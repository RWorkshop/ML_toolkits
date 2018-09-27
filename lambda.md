
* ``lambda.min`` is the value of $\lambda$ that gives minimum mean cross-validated error. 
* The other $\lambda$ saved is ``lambda.1se``, which gives the most regularized model such that error is within one standard error 
of the minimum. 
* To use that, we only need to replace ``lambda.min with`` lambda.1se above.
