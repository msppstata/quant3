/*
Topics for Review
bysort, egen,
factor variables, 
dummies and interactions, 
probit/logit 
margins
*/

/*******************************************************************************
 
* Introduction
* Goal is to give the tools for Q3 AND thesis/capstone.
* This material will build on recitation material from Q1 and Q2.
* That material is still on Blackboard. 
* Students should review material that they missed or don't remember.

*******************************************************************************/


/*******************************************************************************
 
* 1. Complex variable creation with egen and bysort
* For review, see Quant 2, recitation 2 notes.
* help egen
* help bysort

*******************************************************************************/

* Example: 

clear
sysuse citytemp

* Overall mean and std. dev. of tempjan
sum tempjan

* Data is divided by division
tab division
* We know from browsing or describe that division is a labeled number:
tab division, nol

* What about the mean and std. dev. in N. Eng. division only?
sum tempjan if division==1

* We could see the mean and std. dev. for every division.
* Use the bysort prefix, which repeats the command for each group.
bysort division: sum tempjan

* We can create the statistics as new variables in our data set using egen:
bysort division: egen tempjan_divave = mean(tempjan)
bysort division: egen tempjan_divsd  = sd(tempjan)


/*******************************************************************************
 
* 2. Factor variables: Using, but not creating, many dummies at once
* For review, see Quant 2, recitation 6 notes.
* help fvvarlist

*******************************************************************************/

* Suppose we want to run the regression:
regress tempjan heatdd cooldd

* And we want to include dummy variables for each division.
regress tempjan heatdd cooldd i.division


/*******************************************************************************
 
* 3. Dummies and interactions: When not to use factor variables
* If the exact categorical variable does not exist, you can't use factor variables
* What if we are interested in Pacific cities with a high value of heatdd?
* Generate dummy variables for each group, then generate interaction.
* For review, see Quant 2, recitation 4 notes.

*******************************************************************************/

* Dummy variable for cities in the Pacific division:
codebook division
generate pacific = 0
replace  pacific = 1 if division==9 

* Dummy variable for high heatdd (greater than 5,000):
codebook heatdd
generate highheatdd=0
replace  highheatdd=1 if heatdd >= 5000
* Don't forget about the missing!
replace  highheatdd=. if heatdd==.

* Interaction for Pacific cities with high heatdd
generate pacific_highheatdd = pacific*highheatdd

* Regression on levels and interaction
regress tempjan pacific highheatdd pacific_highheatdd


/*******************************************************************************

* 4. Probit/Logit: when the 1/0 variable is your dependent variable
* For review, see Quant 2, recitation 7 notes.
* help logit
* help probit

*******************************************************************************/

* Logit regression:
logit highheatdd tempjuly i.region

* Probit regression:
probit highheatdd tempjuly i.region


/*******************************************************************************
 
* 5. Margins: Predicted probabilities, Marginal Effects
* For review, see Quant 2, recitation 10 notes.
* Remember, margins has two main outputs: predicted probabilities and marginal effects
* help margins

*******************************************************************************/

* Predicted probabilities examples:
margins region  
margins , at(tempjuly = (60 70 80))

* Marginal effects examples:
* marginal effects at average X values
margins , dydx(tempjuly) atmeans 
* average marginal effects
margins , dydx(tempjuly)



