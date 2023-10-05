# waldratioconfidenceintervaloftwomeans

Wald Ratio Calculator With Confidence Intervals for a ratio of two means with distinct units of measurement.

This package uses a data frame with means from two variables and their standard errors.

Calculates the Wald ratio and confidence intervals and also writes out the standard error of the quotient. 
Returns a new data frame with 4 additional columns appended at the end of the initial data frame.




## Installation

```
#install.packages('devtools')
library(devtools)
devtools::install_github("winfrednyoroka/waldratioconfidenceintervaloftwomeans")
```

## Usage
```
waldratioconfidenceintervaloftwomeans::CI_of_ratio_oftwo_means_droprows(data = bariatric_DBP,mean_colA = 'mean_DBP_diff' ,mean_colB = 'mean_BMI_diff',se_colA = 'MDDBP_SE' ,se_colB = 'MDBMI_SE' ,t = 1.96)
```

