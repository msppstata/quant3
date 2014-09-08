/*******************************************************************************
 Quant 3 - Recitation 2 - Panel and Time Series data
*******************************************************************************/

/*******************************************************************************
* Introduction
* So far we have worked with simple cross-sectional data sets:
	* In these data sets, each line represents a single entity, such as an 
	  individual, state, or in our favorite data set, a single type of automobile

* This semester in Quant 3, you will start using more complicated data sets,
  with multiple observations for each unit.

* Time series data and panel data are two types of complex data sets
	* Time series data has multiple observations for a respondent
	* Panel data has multiple observations for multiple respondents


 
*******************************************************************************/

* Example:
webuse nlswork , clear

* alternative command to open data set 
* use http://www.stata-press.com/data/r12/nlswork.dta , clear

/*******************************************************************************
 
* Notice repeated observations for each respondent, identified by idcode
* Notice that some variables change each year: age, tenure, ttl_exp, ln_wage
* Some variables never change: race, birth_yr 
* For never changing variables, the same value is duplicated for every observation on that individual
* (This will be important when we start merging data sets)
* Finally, some variables change only rarely: msp, ind_code, occ_code

*******************************************************************************/

/*******************************************************************************
* Stata has special tools to work with panel and time series data,
* but, before we can use those tools, we have to tell Stata which 
* variable identifies the respondent, and which one identifies the time period.

* This is done with the xtset command (for panel data) and the tsset command (for time series data)

*******************************************************************************/

help xtset

xtset idcode year 

* If you want to see the current value of xtset, type it with no variables:
xtset


* Lags and leads

* Suppose you want to examine the correlation between current wages and wages
* from the previous year. 

* The value of previous year wages is called the lag of wages.

* Actually, we are working with the log of wages, so create a new variable
* called lag_ln_wage

gen lag_ln_wage = L.ln_wage
browse idcode year ln_wage lag_ln_wage

* Many missing values are created, why?
* lag specifies value from previous year, not previous observation.
* They are not the same if some years are missing

* Sometimes lags are created using subscript notation [_n-1], often combined with the by: prefix
* This approach uses the value of the previous observation, rather than the previous year
* For more on this approach, see help subscripting

* Now, the correlation of log-wages between years can be computed:
corr ln_wage lag_ln_wage

* The lag notation is similar to factor variable notation that you saw last year
* You can use lags directly in commands, rather than creating new variables:
corr ln_wage L.ln_wage

* L. is called the "lag operator", and is one of several time-series operators.
* For more details, see:
help tsvarlist

* What if we want to find the average change in log wages?
* We can create a new variable out of our existing lag variable:
gen diff_ln_wage = ln_wage - lag_ln_wage
browse idcode year ln_wage lag_ln_wage diff_ln_wage
sum diff_ln_wage

* Or, we can use the difference operator described in tsvarlist
sum D.ln_wage

* In addition to the time-series operators, there are many commands that
* apply specifically to panel or time series data, that can only be used
* after the data has been xtset or tsset.

* For a list of panel-data commands:
help xt
* Show ts and xt manual indexes





